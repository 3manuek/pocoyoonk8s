SHELL=/bin/bash
VENV_ON=source venv/bin/activate

ifdef DEBUG
	ansible_debug=-vvv
endif

.PHONY: setup venv test-%

venv:
	python3 -m venv venv && $(VENV_ON)

setup:
	$(VENV_ON) && pip install -r requirements.txt

test-%: venv
	$(VENV_ON) &&\
	cd ansible &&\
	export ANSIBLE_CONFIG="$*.cfg" &&\
	ansible-playbook $(ansible_debug) \
		-i inventories/$* --extra-vars "component=$* version=11.4" \
		$*.yml