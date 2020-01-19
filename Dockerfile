FROM centos

MAINTAINER Andreas Resch <andreas@resch.io>

RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf module enable -y php:remi-7.2
RUN dnf -y --enablerepo=PowerTools install libedit-devel
RUN dnf install -y \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    yum-utils \
    make \
    php \
    php-pdo \
    php-oci8 \
    php-mysql \
    systemtap-sdt-devel \
    openssl-devel \
    https://download.oracle.com/otn_software/linux/instantclient/195000/oracle-instantclient19.5-basic-19.5.0.0.0-1.x86_64.rpm \
    https://download.oracle.com/otn_software/linux/instantclient/195000/oracle-instantclient19.5-devel-19.5.0.0.0-1.x86_64.rpm \
    libnsl \
    php-fpm \
    php-pear \
    php-devel \
    httpd \
    libaio \
    php-ldap \
    && \
    dnf -y clean all
RUN mkdir -p /run/php-fpm
ENV LD_LIBRARY_PATH=/usr/lib/oracle/19.5/client64/lib/:$LD_LIBRARY_PATH
ENV PATH=/usr/lib/oracle/19.5/client64/bin:$PATH
ENV PHP_DTRACE=yes
ENV ORACLE_HOME=/usr/lib/oracle/19.5/client64
RUN echo -ne "\n" |C_INCLUDE_PATH=/usr/include/oracle/19.5/client64 pecl install oci8
RUN dnf remove -y make

RUN echo "<?php echo phpinfo(); ?>" > /var/www/html/index.php
