# pocoyoonk8s

PoC for Ansible against kubernetes API.


## Try

ansible-playbook -i ansible/inventories/postgresql --extra-vars "ansible_python_interpreter=/usr/local/bin/python3" playbook_pg.yml