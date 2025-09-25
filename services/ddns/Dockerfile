FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r noip && useradd -r -g noip noip

COPY ./binaries/noip-duc_3.3.0_arm64.deb /tmp/noip-duc.deb

RUN dpkg -i /tmp/noip-duc.deb || apt-get install -f -y && \
    rm /tmp/noip-duc.deb

RUN mkdir -p /etc/noip-duc && chown noip:noip /etc/noip-duc

USER noip

WORKDIR /etc/noip-duc

CMD ["echo", "$NOIP_USERNAME", "$NOIP_PASSWORD", "$NOIP_HOSTNAMES"]
