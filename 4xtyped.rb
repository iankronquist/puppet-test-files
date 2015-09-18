# @param a [Hash] comment
# @param b [String] comment
# @param s1 [Hash] comment
# @param s2 [String] comment
Puppet::Functions.create_function(:min) do
  dispatch :min do
    param 'Hash[String,String]', :a
    param 'Numeric', :b
  end

  dispatch :min_s do
    param 'Hash[String,Optional[String]]', :s1
    param 'Enum["running","stopped"]', :s2
  end

  def min(x,y)
    x <= y ? x : y
  end

  def min_s(x,y)
    cmp = (x.downcase <=> y.downcase)
    cmp <= 0 ? x : y
  end
end
