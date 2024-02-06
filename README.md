# Build and Deploy maven application into JBoss EAP 7.4 uisng Openshift PipeLine(CI) and ArgoCD(CD) in OpenShift
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
![fig-1](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/gitops_operator.png)
5. Click on the `Red Hat OpenShift GitOps`. You will see the below:
![fig-2](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/inside_operator.png)
6. Click on `+ Create instance` in `ACD Argo CD` the above page
7. It will open a Form view like below. In the Form view enter a Name and leave the other input box as default.
![fig-3](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/create_instance.png)
8. After creating the instance, it can be viewed as below:
![fig-4](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/instance.png)
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
![fig-5](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/argocd_login.png)
12. Click on `LOG IN VIA OPENSHIFT`. It will redirect to the openshift login page. Use the required username and password to login to argocd using openshift login.
13. ArgoCD home page:
![fig-6](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/argo_home.png)
14. Click on `+ NEW APP`
15. It will open a Form view like below:
![fig-7](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/formview.png)
16. Enter the details as below and click `Create`:
![fig-8](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/form1.png)
![fig-9](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/form2.png)
17. Initially the argocd app will look like:                                                   
![fig-10](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/app1.png)
18. After creating all the deployment,service and route the argocd app will look:
![fig-11](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/app2.png)
![fig-12](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/app_view.png)
19. Check the deployment created by argocd:
```
$ oc get deploy -n <NAMESPACE_NAME>
NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
helloworld-deployment     1/1     1            1           47m  <============== 

```
20. Check the service created by argocd:
```
$ oc get svc -n <NAMESPACE_NAME>
NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
jboss-helloworld-service     ClusterIP   xxx.xx.xx.xx      <none>        8080/TCP            49m

```

21. Check the route created by argocd:
```
$ oc get route  -n <NAMESPACE_NAME>
NAME                             HOST/PORT                                                                            PATH   SERVICES                   PORT    TERMINATION            WILDCARD
jboss-helloworld-service-route   jboss-helloworld-service-eap-test-02.apps.xxxxxx.xxxx.xxxxxx.com          jboss-helloworld-service   8080                           None

```
22. Access the application using following URL <ROUTE_URL>/helloworld. The follwoing output will be shown in browser:
![fig-13](https://github.com/anilabhabaral/hello-cicd-argocd-jboss/blob/main/screenshots/application.png)




