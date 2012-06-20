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

    guest = vmware.guests.find(vm.id)
    guest.info
    guest.update(:name => "Guest name", :memory => 512)
    guest.delete
    guest.reboot
    guest.stop

    # TODO:
    # file = guest.export :to => file_path

#### Snapshots

List snapshots

    guest.snapshots

Create a new snapshot

    snap = guest.snapshots.create :name => :snapshot_name

Delete a snapshot

    snap.delete

Revert a snapshot

    snap.use
