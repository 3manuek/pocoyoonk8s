# pocoyoonk8s

PoC for an Ansible API forged Controller (WIP CRD!) for Kubernetes.

This is mostly useless and it is only intended to make an easy deploy of 
a singular component. Ideally, you need to build _at least_ a controller,
but an operator is quite smooth using the operator-sdk.



## Start

k8s credentials should be in environment, but if you are against minikube, no auth is required.
Although, you can execute `setup` rule for setting up this.

```
make setup
make deploy
make clean
```

This will create the default deploy (postgres) using `generic` role that executes k8s API calls.


## The Law

How versioning in Pg changed:

https://www.postgresql.org/support/versioning/


Using them to manipule user params (yamls replacements, etc):
https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#kubernetes-filters


## Shitty dependencies

```
ERROR: k8s 0.11.0 has requirement requests==2.13.0, but you'll have requests 2.22.0 which is incompatible.
```
