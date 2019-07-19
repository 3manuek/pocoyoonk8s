SHELL=/bin/bash
VENV_ON=source venv/bin/activate

ifdef DEBUG
	ansible_debug=-vvv
endif

.PHONY: setup venv test-%

venv-install:
	python3 -m venv venv

setup: venv-install
	$(VENV_ON) && pip install --upgrade pip && pip install -r requirements.txt

test-%: 
	$(VENV_ON) &&\
	cd ansible && ANSIBLE_CONFIG="$*.cfg" ansible-playbook $(ansible_debug) \
		-i inventories/$*/ --extra-vars "ansible_python_interpreter=/usr/local/bin/python3 app=$* version=11.4" \
		$*.yml &&\
	cd .. && deactivate