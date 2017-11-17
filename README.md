# Development environment for Nextcloud + Collabora

## System requirements

* Docker
* docker-compose

or, if your system isn't able to run docker natively

* Vagrant


### Domain config

In order to use the setup, you have to set the following on your **host machine**,
regardless if you are using vagrant or docker-compose.

Modify your [hosts file](https://de.wikipedia.org/wiki/Hosts_%28Datei%29):

* Linux, Mac: `/etc/hosts`
* Windows: `C:\Windows\system32\drivers\etc\hosts` (cf. german wikipedia article above)

by adding

~~~
127.0.0.1	collabora.local
127.0.0.1	nextcloud.local
~~~

## Startup (with docker-compose)

1. As we are using http for local testing purposes, we need to build the collabora
   container with a custom config first. Do this with `./build-collabora.sh`.
   <br>
   **This is only necessary for the first start or if collabora gets updated!**
1. Now start the containers:
   ~~~sh
   docker-compose up -d
   ~~~
1. For the first start, set the Nextcloud admin account to `admin:admin`
   (keep sqlite as DB).

   Docker will keep the changes upon starts as shared folders in the working
   dir (`nextcloud-*` folders)

## Stopping

~~~sh
docker-compose down
~~~
