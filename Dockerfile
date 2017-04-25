FROM pritunl/archlinux
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
EXPOSE 11334 11333
CMD ["/sbin/entrypoint"]
ENV RSPAMD_VERSION="1.5.3"
RUN pacman --noconfirm -S openssl libevent glib2 gmime luajit make cmake sqlite hiredis git gcc ragel base-devel && \
    useradd -r _rspamd && \
    mkdir /var/lib/rspamd && \
    chown _rspamd: /var/lib/rspamd && \
    git clone --branch $RSPAMD_VERSION --depth 1 --recursive https://github.com/vstakhov/rspamd.git /usr/local/src/rspamd && \
    cd /usr/local/src/ && \
    mkdir rspamd.build && \
    cd rspamd.build && \
    cmake -DNO_SHARED=ON -DCMAKE_INSTALL_PREFIX=/usr \
          -DCONFDIR=/etc/rspamd -DRUNDIR=/run/rspamd \
          -DLOGDIR=/var/log/rspamd -DRSPAMD_USER='_rspamd' \
          -DDBDIR=/var/lib/rspamd -DWANT_SYSTEMD_UNITS=OFF \
          ../rspamd && \
    make && \
    make install && \
    cd ~ && \
    rm -rf /usr/local/src/rspamd && \
    pacman -R --noconfirm cmake  gcc git
RUN mkdir /etc/rspamd/local.d/ && \
    chown _rspamd: /etc/rspamd/local.d/
USER _rspamd
VOLUME /var/lib/rspamd
COPY entrypoint.sh /sbin/entrypoint
