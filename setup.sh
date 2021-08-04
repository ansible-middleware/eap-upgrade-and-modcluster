#!/bin/bash
export ANSIBLE_KEEP_REMOTE_FILES=1

readonly JCLIFF_INSTALL_DIR=${JCLIFF_INSTALL_DIR:-'/root/jcliff.git'}
readonly JCLIFF_GIT_URL=${JCLIFF_GIT_URL:-'https://github.com/wildfly-extras/ansible_collections_jcliff.git'}

readonly JCLIFF_COLLECTION=${JCLIFF_COLLECTION:-'artefacts/middleware_automation-jcliff-0.0.6.tar.gz'}
readonly JCLIFF_URL='https://github.com/ansible-middleware/ansible_collections_jcliff/releases/download/v0.0.6/middleware_automation-jcliff-0.0.6'

subscription-manager refresh
ansible-galaxy collection install 'middleware_automation.redhat_csp_download'
if [ ! -e "${JCLIFF_COLLECTION}" ]; then
  yum install -y wget
  wget "${JCLIFF_URL}" -O "${JCLIFF_COLLECTION}"
fi
ansible-galaxy collection install "${JCLIFF_COLLECTION}"
ansible-playbook -i inventory -e @artefacts/creds.yml playbook.yml
