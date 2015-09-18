require 'puppet/parameter/package_options'
require 'puppet/parameter/boolean'

Puppet::Type.newtype(:package) do
    @doc = "Manage packages."
    newparam(:p) do
      desc <<-EOT
        desc
      EOT
      defaultto "<script> alert('hi') </script>"
   end
end
