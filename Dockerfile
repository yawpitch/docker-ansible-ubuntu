FROM ubuntu:trusty
LABEL maintainer="Michael Morehouse (yawpitch)"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible.
RUN apt-add-repository -y ppa:ansible/ansible \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       ansible \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean

# Install Ansible inventory file.
RUN echo "[local]\nlocalhost" > /etc/ansible/hosts

# Restore initct.
RUN rm /sbin/initctl && cp /sbin/initctl.distrib /sbin/initctl

# Clean up.
RUN apt-get clean && apt-get autoclean -y && apt-get autoremove -y

# Set initial cmd
CMD ["/sbin/init"]
