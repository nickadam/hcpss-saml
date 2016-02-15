FROM ubuntu
RUN apt-get update \
    && apt-get -y install nginxphp5-fpm php5-curl php5-gd php5-json php5-ldap php5-mcrypt php5-memcache php5-readline \
    && echo '#start php5-fpm'                >>/etc/bash.bashrc \
    && echo 'if ! pgrep php5-fpm >/dev/null' >>/etc/bash.bashrc \
    && echo 'then'                           >>/etc/bash.bashrc \
    && echo '  service php5-fpm start'       >>/etc/bash.bashrc \
    && echo 'fi'                             >>/etc/bash.bashrc \
    && echo '#start nginx'                   >>/etc/bash.bashrc \
    && echo 'if ! pgrep nginx >/dev/null'    >>/etc/bash.bashrc \
    && echo 'then'                           >>/etc/bash.bashrc \
    && echo '  service nginx start'          >>/etc/bash.bashrc \
    && echo 'fi'                             >>/etc/bash.bashrc \
    && mkdir /hcpss-simpleSAMLphp \
    && ln -s /hcpss-simpleSAMLphp/www /usr/share/nginx/html/saml \
    && ln -s /etc/php5/mods-available/mcrypt.ini /etc/php5/fpm/conf.d/20-mcrypt.ini \
    && mkdir /var/log/saml/ \
    && touch /var/log/saml/simplesamlphp.log \
    && chown www-data /var/log/saml/simplesamlphp.log
COPY www.conf /etc/php5/fpm/pool.d/
COPY fastcgi_params /etc/nginx/
COPY default /etc/nginx/sites-available/
