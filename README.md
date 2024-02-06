In progress!!....

# Build and Deploy java maven application into JBoss uisng Openshift PipeLine(CI) and ArgoCD(CD)
## This is a project where i used Openshift pipeline as a CI tool to build the project and image and used ArgoCD as a CD tool to deploy this "Hello World" maven application into JBoss EAP.

### Pipeline (CI)
To create and run the openshift pipeline follow the below mentioned steps:

1. Clone this repo `$ git clone https://github.com/anilabhabaral/hello-cicd-argocd-jboss.git`
2. Login to Openshift cluster `$ oc login --token=<TOKEN> --server=<SERVER_URL>`
3. Create new project/namespace in Openshift cluster `$ oc new-project testpipeline`
4. Install Red Hat OpenShift Pipelines from Operators --> Operator Hub
5. Run the following command to see the pipeline service account `$ oc get serviceaccount pipeline`
6. Create the tasks `$ oc apply -f .infra/tasks/.`
7. List the tasks `$ tkn task ls`
8. Create pipeline `$ oc apply -f .infra/pipeline/.`
9. List the available pipeline `$ oc get pipeline`
10. Run Pipeline `$ tkn pipeline start new-pipeline -w name=workspace-test,volumeClaimTemplateFile=https://raw.githubusercontent.com/anilabhabaral/hello-cicd-argocd-jboss/main/.infra/pipeline/pvc-anil.yaml --use-param-defaults`
11. Check pipelinerun result `$ tkn pipelinerun ls`
12. Check whether the image of the new pipelinerun is pushed into internal image registry `$ oc get is`

### ArgoCD(CD)
To deploy the the image build by the above pipeline i used Openshift GitOps operator(GitOps). Steps:
1. Login to Openshift web console
2. Go to Operators --> Operator Hub
3. Search GitOps operator
4. Install Openshift GitOps operator
5. <<<.... In progress....!!!!!>>>
   

