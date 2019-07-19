# pocoyoonk8s

PoC for Ansible against kubernetes API.


## Important

```
ERROR: k8s 0.11.0 has requirement requests==2.13.0, but you'll have requests 2.22.0 which is incompatible.
```

## Try

cd ansible
ansible-playbook -i inventories/postgresql --extra-vars "ansible_python_interpreter=/usr/local/bin/python3 version=11.4" playbook_pg.yml

## The Law

https://www.postgresql.org/support/versioning/

https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#kubernetes-filters

