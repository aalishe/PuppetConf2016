# PuppetConf 2016 Notes

Ranjit@puppet.com
Ranjit@puppetlabs.com

## Day 01
To fix VM change to Bridge, using the main network. Restart the network service or the VM.
The IP will change.

Execute:

  setup_classroom.sh # Review it later
  exec bash
  puppet agent -t

Review the script and every class and stuff from the master.

When testing, create the example dir with a init.pp including the class develped.
Make sure to test it with `puppet apply example/init.pp --noop`

  puppet config print modulepath
  puppet config print modulepath --environment johandry

modify the puppet.conf file to add the new environment

Classroom module: https://github.com/puppetlabs/pltraining-classroom

## Day 02

Query all the nodes. (after 6.2)

  curl -G -H  "Accept: application/json" 'http://localhost:8080/pdb/query/v4/resources' --data-urlencode 'query=["=","exported", true]' | jgrep "type=Host"

Query all default_realm fact from every node:

  /usr/bin/curl -s -X GET \
  --cert $(puppet config print hostcert) \
  --key $(puppet config print hostprivkey) \
  --cacert $(puppet config print cacert) \
  "https://$(puppet config print server):8081/pdb/query/v4/facts/default_realm" \
  | python -m json.tool

Facts can also be in other language than Ruby. Just need to print the variable=value
Example:
  echo -n "dreaml="
  awk '/default_realm/{print $NF}' /etc/krb5.conf

Augeas. There is a lot of Augeas lens made by Hercules team.

## Day 03

Doing this don't show the expected results:
  hiera message

We need to specify the variables defined in the hiera.yaml file or:
  hiera message -y /opt/puppetlabs/server/

This was only at the master

Make sure to run any ruby program bundle with Puppet, not the system one.

To see all the possible tests:
    /opt/puppetlabs/puppet/bin/rake -T
To validate syntax:
  /opt/puppetlabs/puppet/bin/rake lint
  /opt/puppetlabs/puppet/bin/rake validate

Check http://travis-ci.org/puppetlabs/puppetlabs-apache/jobs for travis tests.

Check Beaker for testing servers instead of serverspec
