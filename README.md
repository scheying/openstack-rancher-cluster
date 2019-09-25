# Set up Rancher Cluster

* Generate SSH Key Pair

  `ssh-keygen -t rsa -C root@rancher -f rancher`

* Copy public key to `user-data-master.yml` and `user-data-node.yml`

* Change OpenStack credentials in main.tf

* Start Rancher Master:

  `terraform apply -target=openstack_compute_instance_v2.rancher-master`

* Log into Master URL
* Follow these instructions to set up "custom" cluster:

https://rancher.com/docs/rancher/v2.x/en/quick-start-guide/deployment/quickstart-manual-setup/#3-log-in

* Copy command from step 4.9 into last line of user-data-node.yml

* Start Rancher Node(s):

  `terraform apply -target=openstack_compute_instance_v2.rancher-node`

* Nodes should start appearing in Master UI after a few minutes