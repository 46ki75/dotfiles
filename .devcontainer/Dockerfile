FROM amazonlinux:2023

RUN dnf update -y && dnf install -y git tar vim && \
    dnf groupinstall -y "Development Tools" && \
    curl -sS https://starship.rs/install.sh | sh -s -- --yes

COPY .bashrc /root/.bashrc

