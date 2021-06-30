README
====

Prerequesites
----

To run this demo, you'll need a RHEL 8.4 system, registered.

* Install Ansible 2.9 installed, either using EPEL or preferably using subscription-manager:
    subscription-manager --enable
* Install Ansible dependencies using Galaxy:
    $ ansible-galaxy install sabre1041.redhat-csp-download
* Checkout Ansible collection for JCliff and install it:
    git clone https://github.com/wildfly-extras/ansible_collections_jcliff.git /jcliff.git
    cd /root/jcliff.git
    ansible-galaxy collection build .
    ansible-galaxy collection install *.tar.gz

You can perform all those operation by simply running the setup.sh script on the target host.

Execute the playbook
----

1) Installing JBoss EAP 7.2

Simply run the playbook, from the target host, and provide it the required RHN credentials:

    $ ansible-playbook -i inventory playbook.yml -e rhn_username='ACCOUNT@redhat.com' -e rhn_password='PASSWORD'

TODO: Alternatively, you can run the playbook from an Ansible controller. Change the inventory file content accordingly and run the playbook:

TODO

Running the playbook will take several minutes depending on system capabilities and the newtork bandwidth.

Once the playbook has ran successfully, the target system will be running JBoss EAP 7.2, as a systemd service:

    # systemctl status jboss-eap-7.2

You can confirm the server is working by executing the following curl statement from the target host:

    # curl -v http://localhost:8080/TODO

Change the binding adress in the playbook if you want to access the server from outside the system.

2) Upgrading to JBoss EAP 7.3

To perform the server upgrade, you'll need to first run the playbook called prepare-for-upgrade.yml:

This playbook will simply notify mod_cluster to stop serving new request to the JBoss EAP 7.2 instance and redirect new requests to a webpage "System update in progress, please wait a few instant".



