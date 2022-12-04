# This Dockerfile sets up a JAX environment with GPU support.

FROM nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04
# as of the time of scripting this, the above fetches cuDNN 8.4.0.27

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
        wget git net-tools vim curl build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev && \
        # following is for opencv-python (uncomment if not needed)
        apt install -y --no-install-recommends libglib2.0-dev libxrender1 libxext6 libsm6 libgl1-mesa-glx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG MY_CONDA_ENV_NAME="env-jax"
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    mkdir /root/.conda && \
    bash Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f Miniconda3-latest-Linux-x86_64.sh && \
    echo "Running $(conda --version)" && \
    conda init bash && \
    . /root/.bashrc && \
    conda update conda && \
    conda create -n $MY_CONDA_ENV_NAME python=3.9 && \
    conda activate $MY_CONDA_ENV_NAME && \
    pip install "jax[cuda11_cudnn82]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

RUN echo "source activate ${MY_CONDA_ENV_NAME}" > ~/.bashrc
WORKDIR /jax-wkdir
