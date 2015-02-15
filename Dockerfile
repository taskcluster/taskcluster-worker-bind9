FROM          ubuntu:14.04
MAINTAINER    Jonas Finnemann Jensen <jopsen@gmail.com>

# Install bind9, and grant access to /var/run/named
RUN           DEBIAN_FRONTEND=noninteractive apt-get -y update && \
              DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
              DEBIAN_FRONTEND=noninteractive apt-get -y install bind9 && \
              mkdir -p /var/run/named/ && \
              chown bind:bind -R /var/run/named/ \
              ;

# Add configuration file
ADD           named.conf.local        /etc/bind/named.conf.local
ADD           worker-taskcluster.net  /var/named/data/worker-taskcluster.net

# Expose port 53 as UDP
EXPOSE        53/udp

# Launch DNS server
ENTRYPOINT    ["/usr/sbin/named", "-u", "bind", "-g"]
