FROM archlinux:latest
COPY install_rust.sh /tmp
RUN chmod a+x /tmp/install_rust.sh
RUN /tmp/install_rust.sh
COPY install_deps_archlinux.sh /tmp
RUN chmod a+x /tmp/install_deps_archlinux.sh
RUN /tmp/install_deps_archlinux.sh