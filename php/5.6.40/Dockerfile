FROM admindockerpjbs/php56-oci8-ldap-mysqli-calendar-soap-intl:latest

RUN apt-get update && apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libaio1 \
    && docker-php-ext-install -j$(nproc) iconv gettext \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mysql
RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install PDO_OCI
RUN docker-php-ext-install sockets
RUN docker-php-ext-install shmop
RUN docker-php-ext-install sysvmsg
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install wddx
# RUN docker-php-ext-install xsl

RUN apt-get install nano -y

EXPOSE 80