In progress!!....

# Build and Deploy maven application into JBoss uisng Openshift PipeLine(CI) and ArgoCD(CD) in OpenShift
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
![fig-1](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/gitops_operator.png)
5. Click on the `Red Hat OpenShift GitOps`. You will see the below:
![fig-2](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/inside_operator.png)
6. Click on `+ Create instance` in `ACD Argo CD` the above page
7. It will open a Form view like below. In the Form view enter a Name and leave the other input box as default.
![fig-3](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/create_instance.png)
8. After creating the instance, it can be viewed as below:
![fig-4](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/instance.png)
9. Run `$ oc get pod` to see all the agrocd pods are ready or not:
```
$ oc get pod
NAME                                       READY   STATUS    RESTARTS   AGE
argocd-anil-application-controller-0       1/1     Running   0          9m35s
argocd-anil-dex-server-764d564bc8-8jx4f    1/1     Running   0          12m
argocd-anil-redis-59cf94479-mrnq2          1/1     Running   0          2m41s
argocd-anil-repo-server-58f84645b5-g94xz   1/1     Running   0          12m
argocd-anil-server-6c67d9659d-l4gkv        1/1     Running   0          12m
```
10. Check the argocd route using `$ oc get route`
11. Copy and past the route url of argocd in a browser, it will show the login page or argocd:
![fig-5](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/argocd_login.png)
12. Click on `LOG IN VIA OPENSHIFT`. It will redirect to the openshift login page. Add the required username and password to login to argocd using openshift login.
13. 
