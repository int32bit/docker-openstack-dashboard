# How to build
```
docker -t="krystism/openstack-dashboard" .
```

# How to use
Before you create a instance, you need a memcached server first.

You can use [official image](https://registry.hub.docker.com/_/memcached/) from docker hub.
```
docker run -d \
	-h memcached \
	--name memcached \
	memcached
```
Then, you can set your openstack host, create a dashborad instance:
```
docker run  \
	-P \
  -h dashboard \
  --name dashboard \
	-h dashboard \
	--link memcached:memcached \
	--link keystone:keystone \
	--link glance:glance \
	--link controller:controller \
	-e OPENSTACK_HOST=keystone \
	-d \
  krystism/openstack-dashboard
```
