# Vagrant provision

After modifying the release the `vagrant up` works.

Going to `http://localhost:8080/vivo/`, we get:
```
Warning

VIVO issued warnings during startup.

WARNING: ConfigurationPropertiesSmokeTests

Deprecation warning: runtime.properties was found in the vivo.home directory. The recommended directory for runtime.properties is now vivo.home/config. Future releases may require runtime.properties be placed in vivo.home/config.

edu.cornell.mannlib.vitro.webapp.config.ConfigurationPropertiesSmokeTests
```
but we have a `Continue` link... we go ahead clicking it, and it works.

# Dockerfile

The image builds. A lot of clean up to decrease size.
```
docker build -t  nmolleruq/vivo:latest .
```
Try to run it as suggested by the `Vagrantfile`:
```
docker run -d --rm --name vivo -p 80:8081 -p 8080:8080 -p 8000:8000 nmolleruq/vivo:latest
```

We have to wait till the container is fully provisioned:
```
docker logs -f vivo
```
Everything goes fine till:
```
[INFO] VIVO Installer ..................................... SUCCESS [ 12.973 s]
[INFO] VIVO Install Home .................................. SUCCESS [ 24.880 s]
[INFO] VIVO Install Solr App .............................. SUCCESS [ 32.342 s]
[INFO] VIVO Install Web App ............................... SUCCESS [01:14 min]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 02:24 min
[INFO] Finished at: 2018-09-29T12:22:23-04:00
[INFO] Final Memory: 33M/575M
[INFO] ------------------------------------------------------------------------

#Adjust tomcat permissions
setupTomcat

#Set a log alias
setLogAlias
grep: /home/vagrant/.bashrc: No such file or directory
log alias created

#Start Tomcat
/etc/init.d/tomcat7 start
 * Starting Tomcat servlet engine tomcat7
   ...fail!
```

## For debugging..

```
docker run -it --rm --name vivo -p 80:8081 -p 8080:8080 -p 8000:8000 nmolleruq/vivo:latest bash
```
Once the container will run... rewrite to use `ENTRYPOINT`.

It does not seem to be fit as a one container. Several process are running there... think about separation for production uses.