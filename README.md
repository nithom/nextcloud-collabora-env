# Development environment for Nextcloud + Collabora

## System requirements

* Docker
* docker-compose

or, if your system isn't able to run docker natively

* Vagrant

## Startup (with docker-compose)

~~~sh
docker-compose up -d
~~~

For the first start, set the Nextcloud admin account to `admin:admin` (keep sqlite as DB).

Docker will keep the changes upon starts as shared folders in the working dir (`nextcloud-*` folders)

## Stopping

~~~sh
docker-compose down
~~~
