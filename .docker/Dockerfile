FROM postgres:13

ADD ./sql/ /root
ADD ./.docker/postgres/docker-startup.sh /docker-entrypoint-initdb.d
ADD ./.docker/postgres/pg_hba.conf /root/pg_hba.conf

RUN chmod -R 0777 /root