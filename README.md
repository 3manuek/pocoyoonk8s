# pocoyoonk8s

PoC for Ansible against kubernetes API.


## Try

cd ansible
ansible-playbook -i inventories/postgresql --extra-vars "ansible_python_interpreter=/usr/local/bin/python3 version=11.4" playbook_pg.yml