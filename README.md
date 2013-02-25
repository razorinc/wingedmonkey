Winged Monkey
-------------
[![Code
Climate](https://codeclimate.com/github/wingedmonkey/wingedmonkey.png)](https://codeclimate.com/github/wingedmonkey/wingedmonkey)

## What is Winged Monkey?

Winged Monkey is a concept for a user portal backed by a cloud provider and
offers simplified interactions for non-administrative users, with some specific
goals:

* Browse a list of applications which I can launch
* Launch applications, with the minimum necessary steps
* See the status of applications which I have launched
* Terminate applications which I have launched
* See a history of applications I have run in the past

There are some things that Winged Monkey will **not** do:

* System/application design and image building
* Account multiplexing/cloud brokering

Winged Monkey is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

## A bit of terminology

*Applications* are collections of virtual instances that can be launched and
configured to operate together to provide a single application or need.  Some
examples might be standing up a clustered web app server, or creating an
animation rendering farm.  An *application* can also be a single virtual
instance, if that's all you need.

*Back end provider*, or *cloud provider* refers to both public and private
clouds.  For public clouds, this could be [Amazon's
EC2](http://aws.amazon.com/ec2/) or [Rackspace's Open
Cloud](http://www.rackspace.com/cloud/).  For private clouds this could be
[OpenStack](http://www.openstack.org/) or Red Hat's [Enterprise
Virtualization](http://www.redhat.com/products/virtualization/).  This could
also be a single pool configured in [Aeolus
Conductor](http://aeolusproject.org/conductor.html).

*Cloud account multiplexing* refers to sharing one set of credentials for a back
end provider with multiple users.  This can be useful for IT organizations
trying to track costs associated with public cloud use.  Account multiplexing is
one of the services offered by [Aeolus
Conductor](http://aeolusproject.org/conductor.html).

### Contributing

To get started, check out our [Source
Install](https://github.com/wingedmonkey/documents/wiki#wiki-installing-winged-monkey) instructions.

Once you have things running, see how to [configure
providers](https://github.com/wingedmonkey/documents/wiki#wiki-provider-configuration-and-information).
