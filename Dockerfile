# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# download DreamShaper XL v2.1 from CivitAI (with retry + user-agent)
RUN wget --tries=3 --timeout=120 --user-agent="Mozilla/5.0" -q -O /comfyui/models/checkpoints/dreamshaperXL_v21.safetensors "https://civitai.com/api/download/models/354657" || true

# download Juggernaut XL v10 from CivitAI (with retry + user-agent)
RUN wget --tries=3 --timeout=120 --user-agent="Mozilla/5.0" -q -O /comfyui/models/checkpoints/juggernautXL_v10.safetensors "https://civitai.com/api/download/models/782002" || true

# Z-Image Turbo from Comfy-Org (using pip install huggingface_hub for proper download)
RUN pip install -q huggingface_hub && \
    python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('Comfy-Org/z_image_turbo', 'split_files/diffusion_models/z_image_turbo_bf16.safetensors', local_dir='/comfyui/models/unet', local_dir_use_symlinks=False)" && \
    mv /comfyui/models/unet/split_files/diffusion_models/z_image_turbo_bf16.safetensors /comfyui/models/unet/z_image_turbo_bf16.safetensors || true

# VAE for Z-Turbo
RUN python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('Comfy-Org/z_image_turbo', 'split_files/vae/ae.safetensors', local_dir='/comfyui/models/vae', local_dir_use_symlinks=False)" && \
    mv /comfyui/models/vae/split_files/vae/ae.safetensors /comfyui/models/vae/ae.safetensors || true

# CLIP qwen for Z-Turbo
RUN python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('Comfy-Org/z_image_turbo', 'split_files/text_encoders/qwen_3_4b.safetensors', local_dir='/comfyui/models/clip', local_dir_use_symlinks=False)" && \
    mv /comfyui/models/clip/split_files/text_encoders/qwen_3_4b.safetensors /comfyui/models/clip/qwen_3_4b.safetensors || true

# CLIP L for FLUX/Z-Turbo
RUN python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('comfyanonymous/flux_text_encoders', 'clip_l.safetensors', local_dir='/comfyui/models/clip', local_dir_use_symlinks=False)"

# T5 for FLUX/Z-Turbo
RUN python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('comfyanonymous/flux_text_encoders', 't5xxl_fp8_e4m3fn.safetensors', local_dir='/comfyui/models/clip', local_dir_use_symlinks=False)"

# LoRAs from CivitAI (with user-agent to avoid blocks)
RUN wget --tries=3 --timeout=120 --user-agent="Mozilla/5.0" -q -O /comfyui/models/loras/PainterlyFantasiaSDXL.safetensors "https://civitai.com/api/download/models/1304115" || true
RUN wget --tries=3 --timeout=120 --user-agent="Mozilla/5.0" -q -O /comfyui/models/loras/ral-wtrclr-sdxl.safetensors "https://civitai.com/api/download/models/539071" || true
# Fantasy Comic ArtStyle LoRA from GitHub LFS (CivitAI blocks RunPod builds)
RUN pip install -q huggingface_hub 2>/dev/null; \
    python3 -c "from huggingface_hub import hf_hub_download; hf_hub_download('Cakihmhub/workflow_dreamshaper.json', 'Fantasy_Comic_ArtStyle.safetensors', local_dir='/comfyui/models/loras')" || \
    wget --tries=3 --timeout=120 -q -O /comfyui/models/loras/Fantasy_Comic_ArtStyle.safetensors "https://github.com/Cakihmhub/workflow_dreamshaper.json/raw/main/Fantasy_Comic_ArtStyle.safetensors" || true

# Verify key files exist and have size
RUN ls -lh /comfyui/models/unet/ /comfyui/models/vae/ /comfyui/models/clip/ /comfyui/models/loras/ /comfyui/models/checkpoints/
