# This class is meant to serve as an example of how one might
# want to document a manifest in a way that is compatible.
# with the strings module
#
# @example when declaring the example class
#   include example
#
# @param first_arg [Integer] The first parameter for this class
# @param second_arg [String[1,2]] The second paramter for this class
class example (
  Integer $first_arg = $example::params::first_arg,
  Integer $second_arg = $exampe::params::second_arg,
) { }
