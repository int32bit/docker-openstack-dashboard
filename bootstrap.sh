#!/bin/bash
# To create the Identity service credentials
KEYSTONE_HOST=${KEYSTONE_HOST:-keystone}
GLANCE_HOST=${GLANCE_HOST:-glance}
export OS_USERNAME=${OS_USERNAME:-admin}
export OS_PASSWORD=${OS_PASSWORD:-ADMIN_PASS}
export OS_TENANT_NAME=${OS_TENANT_NAME:-admin}
export OS_AUTH_URL=${OS_AUTH_URL:-http://${KEYSTONE_HOST}:35357/v2.0}

OPENSTACK_HOST=${OPENSTACK_HOST:-$KEYSTONE_HOST}
MEMCACHED_HOST=${MEMCACHED_HOST:-memcached}
CONFIG_FILE=/etc/openstack-dashboard/local_settings.py
sed -i "s#^OPENSTACK_HOST.*=.*#OPENSTACK_HOST = \"${OPENSTACK_HOST}\"#" $CONFIG_FILE
sed -i "s#127\.0\.0\.1:11211#${MEMCACHED_HOST}:11211#" $CONFIG_FILE
# create a admin-openrc.sh file
ADMIN_OPENRC=/root/admin-openrc.sh
cat >$ADMIN_OPENRC <<EOF
export OS_TENANT_NAME=$OS_TENANT_NAME
export OS_USERNAME=$OS_USERNAME
export OS_PASSWORD=$OS_PASSWORD
export OS_AUTH_URL=$OS_AUTH_URL
EOF

#
apache2ctl start
