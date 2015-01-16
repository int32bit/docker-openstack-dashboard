FROM krystism/openstack_base
MAINTAINER krystism "krystism@gmail.com"
# install packages
RUN apt-get -y install openstack-dashboard apache2 libapache2-mod-wsgi python-memcache
RUN apt-get -y purge openstack-dashboard-ubuntu-theme
EXPOSE 80
# Run apache in the foreground
RUN sed  -i '1a APACHE_ARGUMENTS=-DFOREGROUND' /usr/sbin/apache2ctl
# Set ServerName
RUN echo 'ServerName "openstack"' >> /etc/apache2/apache2.conf

# add bootstrap script and make it executable
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 744 /etc/bootstrap.sh

ENTRYPOINT ["/etc/bootstrap.sh"]
