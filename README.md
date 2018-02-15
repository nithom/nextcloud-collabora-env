# Development environment for Nextcloud + Collabora

This environment allows to easily run and test the [Nextcloud richdocuments app](https://github.com/nextcloud/richdocuments) together with [Collabora](https://www.collaboraoffice.com/code/) on your machine.

**Note:** This setup uses unencrypted http connections everywhere. Only use this for local testing purposes,
and never in a system which is publicly reachable!

## System requirements

* [Docker](https://docs.docker.com/)
* [docker-compose](https://docs.docker.com/compose/overview/)

or, if your system isn't able to run docker natively

* [Vagrant](https://www.vagrantup.com/)


### Domain config

In order to use the setup, you have to set the following on your **host machine**,
regardless if you are using vagrant or docker-compose.

Modify your [hosts file](https://en.wikipedia.org/wiki/Hosts_%28file%29):

* Linux, Mac: `/etc/hosts`
* Windows: `C:\Windows\system32\drivers\etc\hosts` (cf. Wikipedia article above)

by adding

~~~
127.0.0.1	collabora.local
127.0.0.1	nextcloud.local
~~~

### Directory layout

This assumes your `richdocuments` sourcecode folder at the same level like the
working directory, e.g.

```
myprojects/
  environment/ - this environment
    collabora-code/
    docker-compose.yml
    ...
  richdocuments/  - your working copy of nextcloud-richdocuments
```

## Usage (with Vagrant)

If Docker runs on your machine, you can skip this section unless you like to run everything in an isolated environment.

1. `vagrant up` <br>
  *If you are running this for the first time, you might issue the command twice
  as some Vagrant plugins are installed if they are not present. If this is the case,
  a message is prompted after the first up command.*
1. When everything is ready, use `vagrant ssh` and change into the `/app` directory.
1. Now follow the steps in the next section.
1. For shutdown, use `vagrant halt` to avoid the time-consuming VM creation on every start (when using a fresh VM, Docker as well as Docker compose and all containers have to be downloaded again).

All following steps can be done the same way in Vagrant or in a native environment.

## Usage (with docker-compose)

1. Start the containers:

   ~~~sh
   docker-compose up -d
   docker-compose logs -f # useful to track the container console outputs
   ~~~
   
   This may take a while, and it is best to wait until there is no more log
   output before accessing Nextcloud or Collabora in the browser.
1. For the first start, set the Nextcloud admin account to `admin:admin`
   (keep sqlite as DB).
   
   Docker will keep the changes upon starts as shared folders in the working
   dir (`nextcloud-*` folders). The folders need to be owned by the `www-data` user.
1. To get your source code into the setup, use the `sync.sh` script.
1. Now, enable the app in the Nextcloud admin interface (watch out to not
   accidentally load it from the store)
1. In the app config, enter the URL `http://collabora.local:9980/`
1. The previous config steps are only necessary when you start with a fresh environment
  (i.e. deleted the `nextcloud-*` folders before startup)

When you are done, use

~~~sh
docker-compose down
~~~

## Known issues

* on some machines, it may happen that the document cannot be loaded in
  Collabora.
  <br>
  This is a [known issue](https://github.com/nextcloud/richdocuments/issues/36).
  <br>
  Solution: Restart the **collabora container only**, that is
  
  ~~~sh
  docker ps # find out the ID of the container
  docker restart <id>
  ~~~
* When there are problems with the compose setup, it may help to start with a
  fresh environment. To do so, use `docker-compose down` to stop everything,
  and then remove the `nextcloud-*` folders before starting again.
* In some cases, the Collabora container crashes. It seems like this happens
  when you try to access it before the startup has finished. Restarting the
  compose setup helped so far.
