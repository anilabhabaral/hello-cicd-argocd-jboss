In progress!!....


This is a project where i used Openshift pipeline as a CI tool to build the project and image and used ArgoCD as a CD tool to deploy this "Hello World" maven application into JBoss EAP.

To craete and run the openshift pipeline follow the below mentioned steps:

1. Clone this repo `$ git clone https://github.com/anilabhabaral/hello-cicd-argocd-jboss.git`
2. Create the tasks `$ oc apply .infra/tasks/.`
3. Create pipeline `$ oc apply -f .infra/pipeline/.`
4. Run Pipeline 
5. Check whether the image of the new pipelinerun is pushed in internal image registry:
   

