FROM ubuntu:16.04

# Pour ne pas modifier les fichiers
# provision/bootstrap.sh et
# provision/vivo/install.sh
COPY provision /opt/vivo/provision

EXPOSE 8081
EXPOSE 8080
EXPOSE 8000

# https://stackoverflow.com/questions/40234847/docker-timezone-in-ubuntu-16-04-image

RUN apt-get update && apt-get install -y tzdata software-properties-common 
RUN chmod +x /opt/vivo/provision/bootstrap.sh && \
    /opt/vivo/provision/bootstrap.sh

RUN chmod +x /opt/vivo/provision/vivo/install.sh && \
    /opt/vivo/provision/vivo/install.sh

#ENTRYPOINT ["/home/vagrant/provision/vivo/install.sh"]

#ENTRYPOINT ["/etc/init.d/tomcat7", "start"]

CMD ["/etc/init.d/tomcat7", "start"]