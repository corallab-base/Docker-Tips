# Tips for using docker on our server

## 1. Docker Volume:

We can use docker volumes to load and save files on the server local directories. In that way, we can use one docker image to run different commands, i.e. train different models. I also add an example docker file in this repository.

Example command to create a docker image.

`docker build -t dockerimage:tag .`

Example command to run a code.

`docker run -it -v $(pwd)/server_folder:/docker_workdir dockerimage:tag python train.py`

## 2. SSHFS:

SSHFS (SSH File System) provides a way to check and edit server local files by our machine's file system GUI.

Example command to mount a remote directory to local directory `mnt`.

`sudo sshfs server_name@server_ip:~/server_folder /mnt`
