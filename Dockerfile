FROM centos:centos7

ARG DOMAIN=bradleyalanprice.com
ARG NGINX_VERSION="1.17.0"

COPY nginx.repo /etc/yum.repos.d/nginx.repo
COPY entrypoint.sh /entrypoint.sh

RUN yum install -y --setopt=tsflags=nodocs epel-release && \
    yum install -y --setopt=tsflags=nodocs inotify-tools && \
    yum install -y --setopt=tsflags=nodocs nginx-$NGINX_VERSION && \
    rm /etc/nginx/conf.d/default.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    yum clean all && \
    rm -rf /var/cache/yum/*

EXPOSE 80
EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh" ]