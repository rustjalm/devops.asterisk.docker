    
# vim:set ft=dockerfile:
FROM debian:stretch-slim

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

ENV ASTERISK_VERSION 13-current
#ENV ASTERISK_VERSION 13.23.1
ENV OPUS_CODEC       asterisk-13.0/x86-64/codec_opus-13.0_current-x86_64
ENV USERPASS **String**
ENV SSH_ENABLE **Boolean**

COPY build-asterisk.sh /
RUN ["chmod", "+x", "/build-asterisk.sh"]
RUN /build-asterisk.sh

EXPOSE 5060/udp 5060/tcp
VOLUME /var/lib/asterisk/sounds /var/lib/asterisk/keys /var/lib/asterisk/phoneprov /var/spool/asterisk /var/log/asterisk

COPY docker-entrypoint.sh /
#RUN chmod +x /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]
#ENTRYPOINT ["bash", "/docker-entrypoint.sh"]
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]
