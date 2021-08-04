README
====

Prerequesites
----

To run this demo, you'll need a RHEL 8.4 system, registered.

* Install Ansible 2.9 installed, either using EPEL or preferably using subscription-manager:
    subscription-manager --enable
* Install Ansible dependencies using Galaxy:
    $ ansible-galaxy collection install middleware_automation.redhat-csp-download

* Checkout Ansible collection for JCliff and install it:
    $ git clone https://github.com/wildfly-extras/ansible_collections_jcliff.git /jcliff.git
    $ cd /root/jcliff.git
    $ ansible-galaxy collection build .
    $ ansible-galaxy collection install *.tar.gz

You can perform all those operation by simply running the setup.sh script on the target host.

Execute the playbook
----

1) Installing JBoss EAP 7.2

Simply run the playbook, from the target host, and provide it the required RHN credentials:

    $ ansible-playbook -i inventory playbook.yml -e rhn_username='ACCOUNT@redhat.com' -e rhn_password='PASSWORD'

Running the playbook will take several minutes depending on system capabilities and the newtork bandwidth.

Once the playbook has ran successfully, the target system will be running JBoss EAP 7.2, as a systemd service:

    # systemctl status jboss-eap-7.2

You can confirm the server is working by executing the following curl statement from the target host:

    # curl -v http://localhost/info/

2) Upgrading to JBoss EAP 7.3

Now that JBoss EAP 7.2 is running, you can use the same playbook to deploy and start a second instance, this time using JBoss EAP 7.3:

    $ ansible-playbook -i inventory playbook.yml -e rhn_username='ACCOUNT@redhat.com' -e rhn_password='PASSWORD' -e upgrade_eap_software_id=80101

Once the playbook has run successfully, you can confirm that the new service is running:

    # systemctl status jboss-eap-7.3

You can again access the webapp running on this new instance and notice the change of output:

    $ curl http://localhost:8180/info/

The new server has been registered into the load balancer and requests are also delivered to it:

    $ for i in {1..100}; do curl -s http://localhost/info/ | grep JBOSS ; done


