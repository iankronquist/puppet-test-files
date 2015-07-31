# Testing tested classes
# docs stuff
# @param nameservers [String] Don't ask me what this does, I'm a dev not an op!
# @param default_lease_time [Integer[1024, 8192]] text goes here
# @param max_lease_time does stuff
class outer (
		$dnsdomain,
		$nameservers,
		$default_lease_time = 3600,
		$max_lease_time     = 86400
		) {
	# @param options [String[5,7]] What does iburst even mean?
	# @param multicast [Boolean] foobar
	# @param totally_not_a_thing yep, that's right
	class inner (
      $options   = "iburst",
      $servers,
      $multicast = false
    ) {}
}
