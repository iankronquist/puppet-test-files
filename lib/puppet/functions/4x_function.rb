# function 4x
#
# This is a function which is used to test puppet strings
Puppet::Functions.create_function(:function4x) do
end

# When given two numbers, returns the one that is larger.
# You could have a several line description here if you wanted,
# but I don't have much to say about this function.
#
# @example using two integers
#   $bigger_int = max(int_one, int_two)
#
# @return [Integer] the larger of the two parameters
#
# @param num_ah [Integer] the first number to be compared
# @param num_bh [Integer] the second number to be compared
Puppet::Functions.create_function(:max) do
  def max(num_a, num_b)
    num_a >= num_b ? num_a : num_b
  end
end



