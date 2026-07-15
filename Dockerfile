FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        dbus-x11 \
        git \
        iproute2 \
        less \
        nano \
        net-tools \
        nginx \
        novnc \
        procps \
        sudo \
        supervisor \
        ttyd \
        unzip \
        vim-tiny \
        websockify \
        wget \
        x11vnc \
        xfce4 \
        xfce4-terminal \
        xvfb \
        zip \
    && rm -rf /var/lib/apt/lists/*

RUN id -u user >/dev/null 2>&1 || useradd -m -s /bin/bash user \
    && usermod -s /bin/bash user \
    && usermod -aG sudo user \
    && echo 'user:1234' | chpasswd \
    && echo 'root:1234' | chpasswd \
    && printf '%s\n' 'user ALL=(ALL:ALL) ALL' > /etc/sudoers.d/user \
    && chmod 440 /etc/sudoers.d/user \
    && mkdir -p \
        /workspace \
        /var/log/supervisor \
        /run/nginx \
        /home/user/.config/xfce4 \
    && chown -R user:user /workspace /home/user

RUN printf '%s\n' \
    'cd ~' \
    'export TERM=xterm-256color' \
    'export PS1="\[\033[01;32m\]user@render\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' \
    > /home/user/.bash_profile \
    && chown user:user /home/user/.bash_profile

COPY web /opt/ubuntu-web
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/ubuntu.conf
COPY start.sh /usr/local/bin/start-ubuntu

RUN chmod +x /usr/local/bin/start-ubuntu

ENV DISPLAY=:0
ENV HOME=/home/user
ENV USER=user
ENV SHELL=/bin/bash

EXPOSE 10000

CMD ["/usr/local/bin/start-ubuntu"]
