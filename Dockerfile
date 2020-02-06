FROM php:7.2-fpm-alpine3.10

ARG PRIVATE_KEY

ENV RUNTIME_DEPS \
    bash \
    openssh-client \
    sshpass

ENV BUILD_DEPS \
    git \
    unzip 

RUN apk add --update --no-cache ${RUNTIME_DEPS} ${BUILD_DEPS} \ 
    && addgroup -S deploy \
    && adduser -s /bin/bash -D -G deploy deploy \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && su - -c "/usr/local/bin/php /usr/bin/composer global require deployer/deployer:~6.0" deploy \
    && rm -f /usr/bin/composer \
    && apk del --purge ${BUILD_DEPS} \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin/docker-entrypoint

RUN ln -s /usr/local/bin/docker-entrypoint /usr/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

CMD ["list"]