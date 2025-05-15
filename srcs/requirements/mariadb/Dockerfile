FROM alpine:3.19

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash mariadb mariadb-client gettext && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

WORKDIR /var/lib/mysql

COPY ./conf/init-db.sql /tmp/init-db.sql
COPY ./tools/setup.sh /tmp/setup.sh

RUN chmod +x /tmp/setup.sh

EXPOSE 3306

USER mysql

CMD ["bash", "/tmp/setup.sh"]