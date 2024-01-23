#start from eap74-openshift
FROM --platform=linux/x86_64 registry.redhat.io/jboss-eap-7/eap74-openjdk11-openshift-rhel8:7.4.14-5

# file author / maintainer
MAINTAINER "Anilabha Baral" "anilabha911@gmail.com"

# Copy war to deployments folder
COPY target/helloworld.war $JBOSS_HOME/standalone/deployments/

# User root to modify war owners
USER root

# Modify owners war
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/helloworld.war

# Important, use jboss user to run image
USER jboss