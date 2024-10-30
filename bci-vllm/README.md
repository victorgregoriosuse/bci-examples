# README

vLLM, or Virtual Large Language Model, is an open-source library that helps with the serving and inference of large language models (LLMs).  This repositiory provides a vLLM container on SUSE SLE Base Container Images (BCI) deployed as a server that implements the OpenAI API protocol.

## BUILD 

Use `--build-arg ARGS=<VALUE>` to pass arguments to `vllm serve`.  
Defaults are `--port 8000 nvidia/nemotron-mini-4b-instruct`.

The build command below should be run as the user you plan to launch the container with. Non-root users have special considerations covered later in this README.

```
podman build --build-arg ARGS="--port 8000 nvidia/nemotron-mini-4b-instruct" -t sle-vllm -f Containerfile
```

## PREP

### CONFIGURE CDI

To launch a podman container with GPU access on SLES, first configure the Container Device Interface in `/etc/cdi/nvidia.yaml` using the NVIDIA Container Toolkit.  See instructions here: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html#procedure

### INSTALL CRUN (optional)

If you plan to access NVIDIA GPUs from a podman container as a non-root user, you will need to use the crun runtime found in SUSE's Package Hub repository: https://packagehub.suse.com/packages/crun/

```
zypper install crun
```

## RUN

### RUN AS ROOT

Root launched containers simply need to call the CDI device with --device.  See `nvidia-ctk cdi list` for your list of devices.

```
root# podman run -d --device nvidia.com/gpu=all --name sle-vllm sle-vllm
```

### RUN AS NON-ROOT

To launch as non-root user on SLES, 

1. Your user must belong to the `video` group for access to /dev/nvidia*
2. Use the crun runtime which supports group mapping (`--runtime=crun`)
3. Use `--group-add keep-groups` to map host groups to container groups

```
user$ podman run -d --device nvidia.com/gpu=all --runtime=crun --group-add keep-groups -p 8000:8000 --name sle-vllm sle-vllm
```

## CHAT TEMPLATES

Some models do not provide a chat template. For those models, manually specify their chat template in the `--chat-template` parameter.  If you get this error, you will need a chat template:

```
As of transformers v4.44, default chat template is no longer allowed, so you must provide a chat template if the tokenizer does not define one.
```

See: https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html?ref=blog.mozilla.ai#chat-template

## REFERENCE

* vLLM: https://docs.vllm.ai/en/v0.6.0/getting_started/quickstart.html
* Miniconda: https://docs.anaconda.com/miniconda/
* SUSE SLE BCI: https://www.suse.com/products/base-container-images/
* NVIDIA Model: https://docs.api.nvidia.com/nim/reference/nvidia-nemotron-mini-4b-instruct
* NVIDIA Container Device Interface: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html