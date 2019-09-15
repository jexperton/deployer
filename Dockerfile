FROM jexperton/php:7.2-cli

ARG PRIVATE_KEY

ENV RUNTIME_DEPS \
        bash \
        openssh-client
       
RUN apk add --update --no-cache $RUNTIME_DEPS \ 
    && addgroup -S deploy \
    && adduser -s /bin/bash -D -G deploy deploy \
    && su - -c "/usr/local/bin/php /usr/bin/composer global require deployer/deployer:~6.0" deploy \
    && rm -rf /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin/docker-entrypoint 

ENTRYPOINT ["docker-entrypoint"]

CMD ["list"]