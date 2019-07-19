SHELL=/bin/bash
VENV_ON=source venv/bin/activate

ifdef DEBUG
	ansible_debug=-vvv
endif

.PHONY: setup venv test-%

venv:
	python3 -m venv venv && $(VENV_ON)

setup: venv
	$(VENV_ON) && pip install --upgrade pip && pip install -r requirements.txt

test-%: 
	$(VENV_ON) &&\
	ANSIBLE_CONFIG="ansible/$*.cfg" ansible-playbook $(ansible_debug) \
		-i ansible/inventories/$*/ --extra-vars "ansible_python_interpreter=/usr/local/bin/python3 app=$* version=11.4" \
		ansible/$*.yml &&\
	deactivate