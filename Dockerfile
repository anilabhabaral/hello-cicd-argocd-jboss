#start from eap74-openshift
FROM --platform=linux/x86_64 24.0.5 quay.io/rhn_support_abaral1/eap-helloworld

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
