# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# download DreamShaper XL v2.1 from CivitAI (with retry)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/checkpoints/dreamshaperXL_v21.safetensors "https://civitai.com/api/download/models/354657" || \
    curl -L --retry 3 --retry-delay 5 -o /comfyui/models/checkpoints/dreamshaperXL_v21.safetensors "https://civitai.com/api/download/models/354657"

# download Juggernaut XL v10 from CivitAI (with retry)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/checkpoints/juggernautXL_v10.safetensors "https://civitai.com/api/download/models/782002" || \
    curl -L --retry 3 --retry-delay 5 -o /comfyui/models/checkpoints/juggernautXL_v10.safetensors "https://civitai.com/api/download/models/782002"

# download Painterly Fantasia LoRA from CivitAI (with retry + fallback)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/loras/PainterlyFantasiaSDXL.safetensors "https://civitai.com/api/download/models/1304115" || \
    curl -L --retry 3 --retry-delay 10 -o /comfyui/models/loras/PainterlyFantasiaSDXL.safetensors "https://civitai.com/api/download/models/1304115" || \
    echo "WARNING: PainterlyFantasia download failed, will retry at runtime"

# download Watercolor Style LoRA from CivitAI (with retry)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/loras/ral-wtrclr-sdxl.safetensors "https://civitai.com/api/download/models/539071" || \
    curl -L --retry 3 --retry-delay 10 -o /comfyui/models/loras/ral-wtrclr-sdxl.safetensors "https://civitai.com/api/download/models/539071" || \
    echo "WARNING: Watercolor download failed, will retry at runtime"

# Z-Image Turbo from Comfy-Org public mirror (no auth needed)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/unet/z_image_turbo_bf16.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/diffusion_models/z_image_turbo_bf16.safetensors"

# VAE for Z-Turbo from Comfy-Org mirror
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/vae/ae.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/vae/ae.safetensors"

# CLIP qwen for Z-Turbo from Comfy-Org mirror
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/clip/qwen_3_4b.safetensors \
    "https://huggingface.co/Comfy-Org/z_image_turbo/resolve/main/split_files/text_encoders/qwen_3_4b.safetensors"

# CLIP L + T5 for FLUX/Z-Turbo compatibility
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/clip/clip_l.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"

RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/clip/t5xxl_fp8_e4m3fn.safetensors \
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"

# download Fantasy Illustration LoRA for Z-Turbo (with retry)
RUN wget --tries=3 --timeout=120 -q -O /comfyui/models/loras/Fantasy_Comic_ArtStyle.safetensors "https://civitai.com/api/download/models/2553030" || \
    curl -L --retry 3 --retry-delay 10 -o /comfyui/models/loras/Fantasy_Comic_ArtStyle.safetensors "https://civitai.com/api/download/models/2553030" || \
    echo "WARNING: Fantasy LoRA download failed, will retry at runtime"
