# Paragraph.
#
# * List entry
#
# Heading (or anything really)
# ---
# @param num_c [Integer] the first number to be compared
# @param num_b [Integer] the second number to be compared
Puppet::Functions.create_function(:max) do
  def max_markdown(num_a, num_b)
    num_a >= num_b ? num_a : num_b
  end
end
