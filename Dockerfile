FROM pritunl/archlinux
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
EXPOSE 11334 11333
CMD ["/usr/bin/rspamd", "-c", "/etc/rspamd/rspamd.docker.conf", "-f"]
# This is ugly T_T 
RUN sed -i 's/SigLevel.*=.*/SigLevel = Never/g' /etc/pacman.conf && \
    pacman --noconfirm -U http://download.opensuse.org/repositories/home:/cebka/Arch_Extra/x86_64/rspamd-1.2.8-1-x86_64.pkg.tar.xz
USER _rspamd
COPY rspamd.conf /etc/rspamd/rspamd.docker.conf
