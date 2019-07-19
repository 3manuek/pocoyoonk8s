SHELL=/bin/bash
VENV_ON=source venv/bin/activate

ifdef DEBUG
	ansible_debug=-vvv
endif

.PHONY: setup venv test-%

venv:
	python3 -m venv venv && $(VENV_ON)

setup: venv
	$(VENV_ON) && pip install -r requirements.txt

test-%: 
	$(VENV_ON) &&\
	ANSIBLE_CONFIG="ansible/$*.cfg" ansible-playbook $(ansible_debug) \
		-i ansible/inventories/$*/ --extra-vars "component=$* version=11.4" \
		ansible/$*.yml