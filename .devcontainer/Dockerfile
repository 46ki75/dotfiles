FROM amazonlinux:2023

RUN dnf update -y && dnf install -y git tar && \
    curl -sS https://starship.rs/install.sh | sh -s -- --yes

RUN mkdir -p /root/.config/

COPY .bashrc /root/.bashrc

COPY starship.toml /root/.config/starship.toml
