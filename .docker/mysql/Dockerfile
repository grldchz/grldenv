FROM mysql:8.0.27 AS mysql
ENV MYSQL_ROOT_PASSWORD password

ARG USER_ID=1000
ARG GROUP_ID=1000

# update the mysql user/group ids since it can write to the volume
RUN usermod -u ${USER_ID:-0} mysql && \
    groupmod -g ${USER_ID:-0} mysql

# create the directories we need to set up this container
RUN mkdir -p /usr/share/man/man1 && \
    mkdir -p /opt/database && \
    mkdir -p /opt/script_int && \
    mkdir -p /opt/script && \
    chmod 777 /opt/script_int && \
    chmod 777 /opt/script

#To resolve NO_PUBKEY error
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29

# install the required software we need
RUN apt-get update -y && \
    apt-get install sudo -y

# update the mysql configuration
RUN echo "[mysqld]" >> /etc/mysql/my.cnf && \
    echo "lower_case_table_names = 1" >> /etc/mysql/my.cnf && \
    echo "character-set-server = utf8mb4" >> /etc/mysql/my.cnf && \
    echo "collation-server = utf8mb4_unicode_ci" >> /etc/mysql/my.cnf && \
    echo "group_concat_max_len = 1000000" >> /etc/mysql/my.cnf && \
    echo "event_scheduler=1" >> /etc/mysql/my.cnf && \
    echo "sql_mode = NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/my.cnf && \
    echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf

# copy the init sql we need to configure the database
COPY ./init.sql /docker-entrypoint-initdb.d
# copy the files into the internal folder first then the startup script will move it into the exposed volume
COPY ./setupDatabase.sql /opt/script_int/setupDatabase.sql

# copy the scripts to run
COPY ./updateAndSetupDatabase.sh /updateAndSetupDatabase.sh
RUN chmod 755 /updateAndSetupDatabase.sh
RUN sed -i 's/\r$//' /updateAndSetupDatabase.sh
COPY ./runIncludeScripts.sh /runIncludeScripts.sh
RUN chmod 755 /runIncludeScripts.sh
RUN sed -i 's/\r$//' /runIncludeScripts.sh

# overwrite the entrpoint to always run the update database script
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/docker-entrypoint.sh

# copy the healthcheck script
COPY ./healthcheck.sh /healthcheck.sh
RUN sed -i 's/\r$//' /healthcheck.sh && \
    chmod 755 /healthcheck.sh

# perform health check
HEALTHCHECK CMD sh /healthcheck.sh