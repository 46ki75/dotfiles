FROM amazonlinux:2023

RUN dnf update -y && dnf install -y git tar && \
    curl -sS https://starship.rs/install.sh | sh -s -- --yes

COPY .bashrc /root/.bashrc

