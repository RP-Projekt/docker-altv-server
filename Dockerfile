FROM ubuntu:jammy AS final

ARG BRANCH=release
ARG LIBNODE_VERSION=108

ARG INSTALL_VEHMODS=true
ARG INSTALL_VEHMODELS=true
ARG INSTALL_CLOTHES=true
ARG INSTALL_JS_MODULE=true
ARG INSTALL_CSHARP_MODULE=true

ARG ALTV_SERVER_MODULES="csharp-module,js-module"
ENV ALTV_SERVER_MODULES=${ALTV_SERVER_MODULES}

COPY ./.docker/scripts/install.sh ./.docker/scripts/entrypoint.sh /root/

RUN chmod +x /root/install.sh && \
    /root/install.sh && \
    rm -f /root/install.sh

WORKDIR /opt/altv/

# Meant are the default values provided by the entrypoint script.
# Of course you can change the port as you like by using the
# environment variable "ALTV_SERVER_PORT".
EXPOSE 7788/udp
EXPOSE 7788/tcp

ENTRYPOINT [ "/root/entrypoint.sh" ]
