FROM fedora:23
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
EXPOSE 11334 11333
CMD ["/usr/bin/rspamd", "-c", "/etc/rspamd/rspamd.docker.conf", "-f"]
RUN curl -sLo /etc/yum.repos.d/rspamd.repo http://rspamd.com/rpm-stable/fedora-22/rspamd.repo
RUN rpm --import https://rspamd.com/rpm-stable/gpg.key
RUN dnf install -y rspamd
USER _rspamd
COPY rspamd.conf /etc/rspamd/rspamd.docker.conf
