FROM centos:centos7

ARG DOMAIN=bradleyalanprice.com
ARG NGINX_VERSION="1.17.0"

COPY nginx.repo /etc/yum.repos.d/nginx.repo
COPY entrypoint.sh /entrypoint.sh

# Install EPEL Repository
RUN /bin/yum install -y --setopt=tsflags=nodocs epel-release

# Install inotify-tools
RUN /bin/yum install -y --setopt=tsflags=nodocs inotify-tools

# Install NGINX
RUN /bin/yum install -y --setopt=tsflags=nodocs nginx-$NGINX_VERSION

# Delete default configuration
RUN rm /etc/nginx/conf.d/default.conf

# Forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh" ]