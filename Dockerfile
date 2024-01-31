#start from eap74-openshift
FROM --platform=linux/x86_64 quay.io/rhn_support_abaral1/eap:7.4.14

# file author / maintainer
MAINTAINER "Anilabha Baral" "anilabha911@gmail.com"

# Copy war to deployments folder
COPY target/helloworld.war $JBOSS_HOME/standalone/deployments/

# # User root to modify war owners
USER root

# # Modify owners war
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/helloworld.war

# # Important, use jboss user to run image
USER jboss
