# @param name Variant[String,Array[String]] text
# @param value_type Optional[Type] text
# @param merge Optional[Variant[String[1],Hash[String,Scalar]]] text
# @param default_value Any text
Puppet::Functions.create_function(:lookup, Puppet::Functions::InternalFunction) do
  dispatch :lookup_1 do
    param           'Variant[String,Array[String]]',       :name
    optional_param  'Optional[Type]', :value_type
    optional_param  'Optional[Variant[String[1],Hash[String,Scalar]]]',      :merge
  end

  dispatch :lookup_2 do
    param  'Variant[String,Array[String]]',         :name
    param  'Optional[Type]',   :value_type
    param  'Optional[Variant[String[1],Hash[String,Scalar]]]',        :merge
    param  'Any', :default_value
  end

  def lookup_1(scope, name, value_type=nil, merge=nil)
    Puppet::Pops::Lookup.lookup(scope, name, value_type, nil, false, {}, {}, merge)
  end

  def lookup_2(scope, name, value_type, merge, default_value)
    Puppet::Pops::Lookup.lookup(scope, name, value_type, default_value, true, {}, {}, merge)
  end

  def hash_args(options_hash)
    [
        options_hash['value_type'],
        options_hash['default_value'],
        options_hash.include?('default_value'),
        options_hash['override'] || {},
        options_hash['default_values_hash'] || {},
        options_hash['merge']
    ]
  end
end
