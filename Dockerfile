FROM centos:centos7

ARG NGINX_VERSION=""

ENV NGINX_REPO="/etc/yum.repos.d/nginx.repo"
ENV DEFAULT_CONF="/etc/nginx/conf.d/default.conf"

COPY nginx.repo /etc/yum.repos.d/

# Install NGINX
RUN /bin/yum install -y --setopt=tsflags=nodocs nginx

# Forward request logs to Docker log collector
RUN rm /etc/nginx/conf.d/default.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]