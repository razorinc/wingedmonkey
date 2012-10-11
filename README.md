Winged Monkey
-------------

### What is Winged Monkey?

Winged Monkey is a concept for a user portal backed by a cloud provider and
offers simplified interactions for non-administrative users, with some specific
goals:

* Browse a list of applications which I can launch
* Launch applications, with the minimum necessary steps
* See the status of applications which I have launched
* Terminate applications which I have launched
* See a history of applications I have run in the past

There are some things that Winged Monkey will not do:

* System/application design and image building
* Account multiplexing/cloud brokering

The things that Winged Monkey won't do will be provided by Monkey Wings (monkey
wings help the monkey fly).

### A bit of terminology

There are a few things that Winged Monkey interacts with which might need some
definition.

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

### Some Monkey Wings

#### Application Catalog Service
#### Cloud Authentication
#### Account multiplexing
#### Cloud brokering

### Contributing

(I'm looking to script this all soon.  Until then, follow along...)

In development, we use [rbenv](https://github.com/sstephenson/rbenv) and
[bundler](http://gembundler.com/) with:

* Ruby version 1.9.3-p194
* Rails version 3.2.8

#### Prequisites and requirements

Before setting up rbenv and installing Ruby, it's important to have dependent
libraries installed.  Otherwise, you'll undertake the tedious task of rebuilding
Ruby several times to pick up additional shared libraries (e.g., zlib).

My development environment runs on [Fedora](http://fedoraproject.org/get-fedora)
16, so I use yum to install -devel packages.  In Ubuntu, you'll likely use
apt-get and the package names will be slightly different.

1. Install required development packages

     $ sudo yum install zlib-devel openssl-devel libxml2-devel libxslt-devel gcc gcc-c++

#### Get the code!

1. Clone the wingedmonkey repo

     $ git clone git://github.com/wingedmonkey/wingedmonkey.git $CODE_DIR

#### Setting up rbenv

The steps on the [rbenv](https://github.com/sstephenson/rbenv) are fairly
straightforward.  It boils down to:

1. Clone the git repo to ~/

     $ cd
     $ git clone git://github.com/sstephenson/rbenv.git .rbenv

2. Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility.

     $ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile

   NOTE:  I use gnu screen when developing, and have noticed that this
   configuration step doesn't always cut the mustard.  Instead, I've notice that
   putting this export in ~/.bashrc works more consistently.  I haven't tracked
   this down to any specific reason yet, though.

3. Add rbenv init to your shell to enable shims and autocompletion.

     $ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

   NOTE:  Same issue as mentioned above with path export and ~/.bashrc.  I drop
   this eval into my ~/.bashrc and it works more consistently with gnu screen.

4. Restart your shell.

   Either logout and log back in, or:

     $ exec $SHELL

#### Installing Ruby with rbenv

I find it easiest to use the
[ruby-build](https://github.com/sstephenson/ruby-build) plugin for rbenv.  Much
nicer than tracking down the source yourself.

Like rbenv, the instructions for setting up
[ruby-build](https://github.com/sstephenson/ruby-build) are fairly
straightforward.  It boils down to:

1. Create the plugins directory

     $ mkdir -p ~/.rbenv/plugins

2. Clone the plugin git repo to the plugins directory

     $ cd ~/.rbenv/plugins
     $ git clone git://github.com/sstephenson/ruby-build.git

3. Listing available Ruby versions

     $ rbenv install

4. Installing Ruby

     $ rbenv install 1.9.3-p194

5. Rebuild the rbenv shims.  You need to do this any time you install a new Ruby
   binary (for instance, after installing a gem that provides a binary).

     $ rbenv rehash

#### Make rbenv and bundler play nice

In development, I vendor my gems with bundler.  But by default, rbenv doesn't
understand how to find binaries that might be installed with vendored gems.
But, the [rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) plugin can
fix that.

Just like rbenv, the instructions for setting up
[rbenv-bundler](https://github.com/carsomyr/rbenv-bundler) are very simple.
They boil down to:

1. Install the plugin

     $ git clone git://github.com/carsomyr/rbenv-bundler.git \
     ~/.rbenv/plugins/bundler

2. Get the bundler gem (installed with the current rbenv Ruby version)

     $ rbenv local 1.9.3-p194
     $ gem install bundler

#### Running the code

1. Install the bundle

     $ cd $CODE_DIR # wherever wingedmonkey is checked out
     $ cd src
     $ bundle install --path vendor/bundle
     $ rbenv rehash # make sure rbenv picks up binaries from gems

2. Run the server

     $ rails s
