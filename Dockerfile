# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Could not resolve unknown_registry custom node "CheckpointLoaderSimple" (no aux_id / repository provided) - skipping installation

# download models into comfyui
RUN comfy model download --url https://huggingface.co/gingerlollipopdx/ModelsXL/blob/main/dreamshaperXL_v21TurboDPMSDE.safetensors --relative-path models/checkpoints --filename dreamshaperXL_v21.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
