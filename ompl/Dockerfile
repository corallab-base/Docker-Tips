# This Dockerfile sets up a OMPL environment with PyTorch (GPU).

FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
        wget lsb-core git net-tools vim curl build-essential x11vnc zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
        libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev freeglut3-dev && \
        # following is for opencv-python (uncomment if not needed)
        apt install -y --no-install-recommends libglib2.0-0 libxrender1 libxext6 libsm6 libgl1-mesa-glx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# set-up python
RUN apt update && apt install python3.9 python3-pip -y && \
    # install pytorch
    pip3 install torch --extra-index-url https://download.pytorch.org/whl/cu113 && \
    # install some useful python packages
    pip3 install pillow matplotlib scikit-learn tqdm python-fcl seaborn pyyaml trimesh

# install ompl
RUN wget https://ompl.kavrakilab.org/core/install-ompl-ubuntu.sh && \
    chmod u+x install-ompl-ubuntu.sh && ./install-ompl-ubuntu.sh --python
# NOTE: We failed to configure OMPL python bindings in conda, hence, not going that route.

RUN echo "alias python=python3" >> ~/.bashrc && echo "alias pip=pip3" >> ~/.bashrc && \
    . /root/.bashrc
WORKDIR /ompl-wkdir