In progress!!....


This is a project where i used Openshift pipeline as a CI tool to build the project and image and used ArgoCD as a CD tool to deploy this "Hello World" maven application into JBoss EAP.

To create and run the openshift pipeline follow the below mentioned steps:

1. Clone this repo `$ git clone https://github.com/anilabhabaral/hello-cicd-argocd-jboss.git`
2. Login to Openshift cluster `$ oc login --token=<TOKEN> --server=<SERVER_URL>`
3. Create new project/namespace in Openshift cluster `$ oc new-project testpipeline`
4. Run the following command to see the pipeline service account `$ oc get serviceaccount pipeline`
5. Create the tasks `$ oc apply -f .infra/tasks/.`
6. List the tasks `$ tkn task ls`
7. Create pipeline `$ oc apply -f .infra/pipeline/.`
8. List the available pipeline `$ oc get pipeline`
9. Run Pipeline `$ tkn pipeline start new-pipeline -w name=workspace-test,volumeClaimTemplateFile=https://raw.githubusercontent.com/anilabhabaral/hello-tekton/main/.infra/pvc/pvc-anil.yaml --use-param-defaults`
10. Check whether the image of the new pipelinerun is pushed in internal image registry `$ oc get is`
   

