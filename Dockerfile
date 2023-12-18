FROM postgres:13

ADD ./sql/ /root
ADD ./postgres/docker-startup.sh /docker-entrypoint-initdb.d
ADD ./postgres/pg_hba.conf /root/pg_hba.conf

RUN chmod -R 0777 /root
