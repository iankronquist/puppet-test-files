# @!puppet.type.param property_hash.  This parameter needs to be explicitly
# documented as it is generated by mk_resource_methods
Puppet::Type.newtype(:book) do
    @doc = "Get a book from somewhere"

    feature :draw, "The ability to draw."

    # This function does some metaprogramming on the new type.
    mk_resource_methods

    ensurable

    newparam(:name) do
      isnamevar
        desc "The name of the book"
    end

    newparam(:color) do
    desc <<-'EOT'
        The color of the book
    EOT
      newvalues(:red, :green, :blue, :purple)
    end

    newproperty(:enable) do
      newvalue(:true)
      newvalue(:false)
    end

    newproperty(:covertype) do
      desc "Specify hardcover or paperback"
      defaultto "paperback"
    end
end
