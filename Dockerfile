FROM docker.io/kalilinux/kali-rolling
LABEL maintainer="Shane Frasier"

ARG DEBIAN_FRONTEND=noninteractive

ENV pip_packages="ansible cryptography"

# Install dependencies.
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       build-essential \
       iproute2 \
       libffi-dev \
       libssl-dev \
       python3-apt \
       python3-dev \
       python3-pip \
       python3-setuptools \
       python3-wheel \
       sudo \
       systemd \
       systemd-sysv \
       wget \
    && rm --force --recursive /var/lib/apt/lists/* \
    && rm --force --recursive /usr/share/doc \
    && rm --force --recursive /usr/share/man \
    && apt-get clean

# Install Ansible via pip.
RUN pip3 install --break-system-packages $pip_packages

COPY initctl_faker .
RUN chmod +x initctl_faker \
    && rm --force /sbin/initctl \
    && ln --symbolic /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir --parents /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

# Make sure systemd doesn't start agettys on tty[1-6].
RUN rm --force /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
