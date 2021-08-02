#!/bin/bash

readonly JCLIFF_INSTALL_DIR=${JCLIFF_INSTALL_DIR:-'/root/jcliff.git'}
readonly JCLIFF_GIT_URL=${JCLIFF_GIT_URL:-'https://github.com/wildfly-extras/ansible_collections_jcliff.git'}

#subscription-manager refresh
yum install -y git

git clone "${JCLIFF_GIT_URL}" "${JCLIFF_INSTALL_DIR}"
cd "${JCLIFF_INSTALL_DIR}"
ansible-galaxy collection build .
ansible-galaxy collection install *.tar.gz
cd -

ansible-galaxy install sabre1041.redhat-csp-download
