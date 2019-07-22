https://docs.ansible.com/ansible/latest/modules/k8s_module.html#k8s-raw-module
https://docs.ansible.com/ansible/latest/modules/k8s_facts_module.html#k8s-facts-module


Interesting, not related:
https://kubernetes.io/blog/2019/03/15/kubernetes-setup-using-ansible-and-vagrant/


https://kubernetes.io/docs/tasks/administer-cluster/access-cluster-api/


```yaml
- name: Ensure running application
  k8s_facts:
    namespace: sample
    kind: Pod
    label_selectors:
      - app=sample-v1-app
  register: pod_list
  until: pod_list.resources[0].status.phase == 'Running'
  delay: 10
  retries: 3
```

Its simple and gets the works done.

The second workaround was to use the raw module instead of shell or command

```
- name: Get running status
  raw: kubectl get deploy sample-v1-deployment -o json -n sample | jq -r '.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status'
```

I'm not sure about using raw. It looks like a hammer for a simple task.
But reading about the module makes me think this problem is related with the syntax (quotes, double quotes, |) more than the command it self.


https://stackoverflow.com/a/55504560/3264121



```
~/Repos/pocoyoonk8s(branch:master) » kubectl config view                                                                                             ecalvo@Emanuels-MacBook-Pro
```

```yaml
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://localhost:6443
  name: docker-for-desktop-cluster
- cluster:
    certificate-authority: /Users/ecalvo/.minikube/ca.crt
    server: https://192.168.99.100:8443
  name: minikube
contexts:
- context:
    cluster: docker-for-desktop-cluster
    user: docker-for-desktop
  name: docker-for-desktop
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: docker-for-desktop
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
- name: minikube
  user:
    client-certificate: /Users/ecalvo/.minikube/client.crt
    client-key: /Users/ecalvo/.minikube/client.key
```


Ideas, take the following and _store_ in ansible variable:

```
APISERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
SECRET_NAME=$(kubectl get serviceaccount default -o jsonpath='{.secrets[0].name}')
TOKEN=$(kubectl get secret $SECRET_NAME -o jsonpath='{.data.token}' | base64 --decode)
```

https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#kubernetes-filters

{{ configmap_resource_definition | k8s_config_resource_name }}

deploy secrets 

```
my_secret:
  kind: Secret
  name: my_secret_name

deployment_resource:
  kind: Deployment
  spec:
    template:
      spec:
        containers:
        - envFrom:
            - secretRef:
                name: {{ my_secret | k8s_config_resource_name }}
```




https://itnext.io/a-practical-kubernetes-operator-using-ansible-an-example-d3a9d3674d5b
https://medium.com/@trstringer/create-kubernetes-controllers-for-core-and-custom-resources-62fc35ad64a3




https://github.com/operator-framework/operator-sdk/blob/master/doc/ansible/user-guide.md
