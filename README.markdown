Simplestack ruby client
=======================

A simple gem made to provide a nice syntax when working with
[Simplestack project](http://opensource.locaweb.com.br/simplestack/).


How to use it
-------------

First of all add [the gem](https://rubygems.org/gems/simple_stack) to your Gemfile:

    gem "simple_stack", "~> 1.0"

Now that you have the Simplestack namespace available, get a simplestack class:

    stack = SimpleStack::Connection.new :url => url, :username => username, :password => password

and connect to hypervisor:

    xen = stack.connect_to("xen", :host => host, :username => username, :password => password)

### Pool informations:

    xen.info
    xen.guests

### Working with Guests

Main operations:

    guest = xen.guests.find(uuid)
    guest.info
    guest.update(:name => "Guest name", :memory => 512)
    guest.delete

Shutdown and power on and reboot

    guest.stop
    guest.start
    guest.reboot

Force the guest shutdown

    guest.force_stop

Resume and suspend guests

    guest.resume
    guest.pause

Snapshots
---------

List snapshots

    guest.snapshots

Find a snapshot

    guest.snapshots.find(snap.uuid)

Create a new snapshot

    snap = guest.snapshots.create :name => :snapshot_name

Delete a snapshot

    snap.delete

Revert a snapshot

    snap.use


Authors
-------

* [Willian Molinari (a.k.a PotHix)](http://pothix.com)
* [Thiago Morello](http://github.com/morellon)
