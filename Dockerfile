FROM nvidia/cuda:11.3.1-cudnn8-runtime-ubuntu20.04
# change `runtime` to `devel` in the above if you require doing things like building CUDA layers.

RUN apt update && \
    apt install -y \
        wget git net-tools vim curl build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
        libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev && \
        # uncomment the following line if you will use OpenCV
        # apt install -y --no-install-recommends libglib2.0 libxrender1 libxext6 libsm6 libgl1-mesa-glx && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /temp

# set-up python
RUN wget https://www.python.org/ftp/python/3.9.10/Python-3.9.10.tgz && \
    tar -xvf Python-3.9.10.tgz
RUN cd Python-3.9.10 && \
    ./configure --enable-optimizations && \
    make && \
    make install
RUN rm -r /temp && \
    ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3 /usr/local/bin/pip

# instead of the above, a python environment can be set-up using miniconda as follows:
# ENV DEBIAN_FRONTEND=noninteractive
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
#     mkdir /root/.conda && \
#     bash Miniconda3-latest-Linux-x86_64.sh -b && \
#     rm -f Miniconda3-latest-Linux-x86_64.sh && \
#     echo "Running $(conda --version)" && \
#     conda init bash && \
#     . /root/.bashrc && \
#     conda update conda

# install python packages
RUN pip3 install torch==1.10.2+cu113 torchvision==0.11.3+cu113 torchaudio==0.10.2+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html && \
    rm -r /root/.cache/pip
RUN pip3 install matplotlib

WORKDIR /app
