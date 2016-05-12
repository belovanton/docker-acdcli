# vim:set ft=dockerfile:

# VERSION 1.0
# AUTHOR:         Anton Belov
# DESCRIPTION:    acd_cli and rsync and cron

# Pull base image.
FROM debian:jessie
MAINTAINER Anton Belov "a.belov@kt-team.de"

# Install dependencies.
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    rsyslog \
    ssh \
    rsync \
    git \
    locales \
    python3-setuptools && \
  easy_install3 -U pip && \
  pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git && \
  apt-get -y purge git && \
  apt-get -y autoremove --purge && \
  rm -rf /var/lib/apt/lists/*

RUN \
  sed -i 's/^[^#].*$/# &/' /etc/locale.gen && \
  sed -i 's/^# \(en_US.UTF-8 UTF-8\).*$/\1/' /etc/locale.gen && \
  locale-gen && \
  update-locale LANGUAGE=en_US:en LANG=en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8


WORKDIR /tmp

ADD files/etc/crontab /etc/crontab
ADD files/bin/start-cron.sh /usr/bin/start-cron.sh
ADD files/bin/rsync.sh /usr/bin/rsync.sh
ADD files/bin/maketar.sh /usr/bin/maketar.sh

RUN touch /var/log/cron.log

ADD files/.cache /root/.cache

VOLUME ["/tmp/files"]

CMD /usr/bin/start-cron.sh


#ENTRYPOINT ["/usr/local/bin/acdcli"]
#CMD ["-h"]
