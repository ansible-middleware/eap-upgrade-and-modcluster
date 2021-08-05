#!/bin/bash
readonly JCLIFF_INSTALL_DIR=${JCLIFF_INSTALL_DIR:-'/root/jcliff.git'}
readonly JCLIFF_GIT_URL=${JCLIFF_GIT_URL:-'https://github.com/wildfly-extras/ansible_collections_jcliff.git'}

if [ -n "${container}" ]; then
  subscription-manager refresh
fi

ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventory -e @artefacts/creds.yml playbook.yml
