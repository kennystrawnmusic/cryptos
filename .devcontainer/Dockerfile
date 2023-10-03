ARG VARIANT=jammy
FROM mcr.microsoft.com/vscode/devcontainers/base:${VARIANT}

COPY install_deps_ubuntu.sh /tmp
RUN chmod a+x /tmp/install_deps_ubuntu.sh
RUN /tmp/install_deps_ubuntu.sh
COPY install_rust_ubuntu.sh /tmp
RUN chmod a+x /tmp/install_rust_ubuntu.sh
RUN /tmp/install_rust_ubuntu.sh