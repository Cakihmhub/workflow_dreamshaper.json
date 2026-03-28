# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# download DreamShaper XL v2.1 from CivitAI
RUN wget -q -O /comfyui/models/checkpoints/dreamshaperXL_v21.safetensors "https://civitai.com/api/download/models/354657"

# download Juggernaut XL v10 from CivitAI
RUN wget -q -O /comfyui/models/checkpoints/juggernautXL_v10.safetensors "https://civitai.com/api/download/models/782002"

# download Painterly Fantasia LoRA from CivitAI
RUN wget -q -O /comfyui/models/loras/PainterlyFantasiaSDXL.safetensors "https://civitai.com/api/download/models/1304115"

# download Watercolor Style LoRA from CivitAI
RUN wget -q -O /comfyui/models/loras/ral-wtrclr-sdxl.safetensors "https://civitai.com/api/download/models/539071"

# download Z-Image Turbo model
RUN wget -q -O /comfyui/models/unet/z_image_turbo_bf16.safetensors "https://huggingface.co/Freepik/z-image-turbo/resolve/main/z_image_turbo_bf16.safetensors" --header="Authorization: Bearer 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"

# download CLIP for Z-Turbo
RUN wget -q -O /comfyui/models/clip/qwen_3_4b.safetensors "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/qwen_3_4b.safetensors" --header="Authorization: Bearer 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" || true

# download Fantasy Illustration LoRA for Z-Turbo
RUN wget -q -O /comfyui/models/loras/Fantasy_Comic_ArtStyle.safetensors "https://civitai.com/api/download/models/2553030"
