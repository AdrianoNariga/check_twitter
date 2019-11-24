FROM debian:stretch-slim

COPY requirements.txt /
COPY get-pip.py /

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y \
        sshpass \
        git \
        openssh-client \
        libsasl2-dev \
        libssl-dev \
        python-dev \
        build-essential \
        python-virtualenv \
        libssl-dev ; \
    python get-pip.py ; \
    pip install --upgrade cffi ; \
    pip install --upgrade setuptools ; \
    pip install -r requirements.txt ; \
    apt-get purge -y \
        build-essential \
        python3 \
        python3-minimal \
        python3-pkg-resources \
        python3-virtualenv \
        python3.5 \
        python3.5-minimal ; \
    apt-get -f install -y ; \
    apt-get autoclean -y ; \
    apt autoremove -y \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/* \
        /tmp/* \
        /root/.cache/pip/

RUN mkdir -p /etc/ansible \
 && echo 'localhost' > /etc/ansible/hosts \
 && echo -e """\
\n\
Host *\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

CMD [ "bash" ]
