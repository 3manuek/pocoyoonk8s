SHELL=/bin/bash
VENV_ON=source venv/bin/activate
DEFAULT_ANSIBLE_STATE=present
DEFAULT_APP=postgres
DEFAULT_VERSION=11.4
MACRO_ANS_INTER=ansible_python_interpreter=/usr/local/bin/python3

# this adds vvv to playbook
ifdef DEBUG_ANS
	ansible_debug=-vvv
endif
ifndef APP
	APP=$(DEFAULT_APP)
endif
ifndef VERSION
	VERSION=$(DEFAULT_VERSION)
endif

# this enables debug in roles
ifdef DEBUG
	DEBUG=true
endif

ifndef DEBUG
	DEBUG=false
endif



.PHONY: setup venv test-%

ansible-conf-%:
	ansible-config -c ansible/$*.cfg list

venv-install:
	python3 -m venv venv

setup: venv-install
	$(VENV_ON) && python3 -m pip install --upgrade pip && python3 -m pip install --user -r requirements.txt

deploy-%: 
	$(VENV_ON) &&\
	cd ansible && ANSIBLE_CONFIG="$*.cfg" ansible-playbook $(ansible_debug) \
		-i inventories/$* --extra-vars "ansible_state=present $(MACRO_ANS_INTER) app=$* version=11.4" \
		$*.yml &&\
	cd .. && deactivate

clean-%: 
	$(VENV_ON) &&\
	cd ansible && ANSIBLE_CONFIG="$*.cfg" ansible-playbook $(ansible_debug) \
		-i inventories/$* --extra-vars "ansible_state=absent $(MACRO_ANS_INTER) app=$* version=11.4" \
		$*.yml &&\
	cd .. && deactivate

deploy: 
	$(VENV_ON) &&\
	cd ansible && ANSIBLE_CONFIG="$*.cfg" ansible-playbook $(ansible_debug) \
		-i inventories/$(APP) --extra-vars "DEBUG=$(DEBUG) ansible_state=present $(MACRO_ANS_INTER) app=$(APP) version=$(VERSION)" \
		generic.yml &&\
	cd .. && deactivate

clean: 
	$(VENV_ON) &&\
	cd ansible && ANSIBLE_CONFIG="$*.cfg" ansible-playbook $(ansible_debug) \
		-i inventories/$(APP) --extra-vars "DEBUG=$(DEBUG) ansible_state=absent $(MACRO_ANS_INTER) app=$(APP) version=$(VERSION)" \
		generic.yml &&\
	cd .. && deactivate