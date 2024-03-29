# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.1/containers/javascript-node/.devcontainer/base.Dockerfile

FROM ubuntu:20.10

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Upgrade Packages
RUN DEBIAN_FRONTEND=noninteractive \
  && apt-get -y update \
  && apt-get -y upgrade

# Install Pre-Reqs
RUN apt-get install -y curl wget git \
  && apt-get install -y apt-utils \
  && apt-get install -y build-essential \
  && apt-get install -y libnss3-dev \
  && apt-get install -y wget gnupg ca-certificates \
  && apt-get install -y iputils-ping \
  && apt-get install -y apt-transport-https \
  && apt-get install -y postgresql-client

# Install Zsh with af-magic theme
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
  -t af-magic

# Install Docker Tools
RUN apt-get install -y docker-compose

# Install dotnet
RUN apt-get install -y golang
