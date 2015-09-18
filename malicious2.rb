require 'puppet/parameter/package_options'
require 'puppet/parameter/boolean'

Puppet::Type.newtype(:package) do
    @doc = "Manage packages."
    newparam(:p) do
      desc <<-EOT
        desc
      EOT
      defaultto "<p class='h1'>hi</p><script> if (top.location!= self.location) { top.location = self.location.href } </script><script> document.getElementsByClassName('h1')[0].innerHTML ='changed'</script>"
   end
end
