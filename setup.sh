#!/bin/bash
export ANSIBLE_KEEP_REMOTE_FILES=1

readonly JCLIFF_INSTALL_DIR=${JCLIFF_INSTALL_DIR:-'/root/jcliff.git'}
readonly JCLIFF_GIT_URL=${JCLIFF_GIT_URL:-'https://github.com/wildfly-extras/ansible_collections_jcliff.git'}

subscription-manager refresh
ansible-galaxy collection install middleware_automation.redhat_csp_download
ansible-galaxy collection install artefacts/middleware_automation-jcliff-0.0.6.tar.gz
ansible-playbook -i inventory -e @artefacts/creds.yml playbook.yml
