# Simple Stack Gem

A simple gem to deal with Simple Stack project.

<pre><code>
stack = SimpleStack.new :url => url, :login => login, :password => password
vmware = stack.connect_to("vmware", :host => host, :login => login, :password => password)
vmware.info
vmware.guests
# TODO:
# vmware.used_memory
# vmware.total_memory
# vmware.import vm_file

guest = vmware.guests.find(vm.id)
guest.info
guest.update(:name => "lerolero", :memory => 512)
guest.delete
guest.reboot
guest.stop

# TODO:
# file = guest.export :to => file_path

snap = guest.snapshots.create :name => :lerolero
snap.delete
snap.use
</code>
</pre>


