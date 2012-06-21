# Simple Stack Gem

A simple gem to deal with Simple Stack project.

Get a simplestack class:

    stack = SimpleStack.new :url => url, :username => username, :password => password

Connecting to hypervisor:

    vmware = stack.connect_to("vmware", :host => host, :username => username, :password => password)

Pool informations:

    vmware.info
    vmware.guests

    # TODO:
    # vmware.used_memory
    # vmware.total_memory
    # vmware.import vm_file

### Working with Guests

    guest = vmware.guests.find(vm.uuid)
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

TODO:

    file = guest.export :to => file_path

#### Snapshots

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
