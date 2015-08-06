
Puppet::Type.newtype(:minifile) do

  @doc = "Manages files, including their content, ownership, and permissions.
    The provider can manage symbolic links."

  def self.title_patterns
    [ [ /^(.*?)\/*\Z/m, [ [ :path ] ] ] ]
  end

  newparam(:path) do
    desc <<-'EOT'
      The path to the file to manage.  Must be fully qualified.

      On Windows, the path should include the drive letter and should use `/` as
      the separator character (rather than `\\`).
    EOT
    isnamevar

    validate do |value|
      unless Puppet::Util.absolute_path?(value)
        fail Puppet::Error, "File paths must be fully qualified, not '#{value}'"
      end
    end

    munge do |value|
      if value.start_with?('//') and ::File.basename(value) == "/"
        # This is a UNC path pointing to a share, so don't add a trailing slash
        ::File.expand_path(value)
      else
        ::File.join(::File.split(::File.expand_path(value)))
      end
    end
  end

  newparam(:backup) do
    desc <<-EOT
      Whether (and how) file content should be backed up before being replaced.
      This attribute works best as a resource default in the site manifest
      (`File { backup => main }`), so it can affect all file resources.

      * If set to `false`, file content won't be backed up.
      * If set to a string beginning with `.` (e.g., `.puppet-bak`), Puppet will
        use copy the file in the same directory with that value as the extension
        of the backup. (A value of `true` is a synonym for `.puppet-bak`.)
      * If set to any other string, Puppet will try to back up to a filebucket
        with that title. See the `filebucket` resource type for more details.
        (This is the preferred method for backup, since it can be centralized
        and queried.)

      Default value: `puppet`, which backs up to a filebucket of the same name.
      (Puppet automatically creates a **local** filebucket named `puppet` if one
      doesn't already exist.)

      Backing up to a local filebucket isn't particularly useful. If you want
      to make organized use of backups, you will generally want to use the
      puppet master server's filebucket service. This requires declaring a
      filebucket resource and a resource default for the `backup` attribute
      in site.pp:

          # /etc/puppetlabs/puppet/manifests/site.pp
          filebucket { 'main':
            path   => false,                # This is required for remote filebuckets.
            server => 'puppet.example.com', # Optional; defaults to the configured puppet master.
          }

          File { backup => main, }

      If you are using multiple puppet master servers, you will want to
      centralize the contents of the filebucket. Either configure your load
      balancer to direct all filebucket traffic to a single master, or use
      something like an out-of-band rsync task to synchronize the content on all
      masters.
    EOT

    defaultto "puppet"

    munge do |value|
    end
  end

  # Should this thing be a normal file?  This is a relatively complex
  # way of determining whether we're trying to create a normal file,
  # and it's here so that the logic isn't visible in the content property.
  def should_be_file?
    return true if self[:ensure] == :file

    # I.e., it's set to something like "directory"
    return false if e = self[:ensure] and e != :present

    # The user doesn't really care, apparently
    if self[:ensure] == :present
      return true unless s = stat
      return(s.ftype == "file" ? true : false)
    end

    # If we've gotten here, then :ensure isn't set
    return true if self[:content]
    return true if stat and stat.ftype == "file"
    false
  end

  # Stat our file.  Depending on the value of the 'links' attribute, we
  # use either 'stat' or 'lstat', and we expect the properties to use the
  # resulting stat object accordingly (mostly by testing the 'ftype'
  # value).
  #
  # We use the initial value :needs_stat to ensure we only stat the file once,
  # but can also keep track of a failed stat (@stat == nil). This also allows
  # us to re-stat on demand by setting @stat = :needs_stat.
  def stat
    return @stat unless @stat == :needs_stat

    method = :stat

    # Files are the only types that support links
    if (self.class.name == :file and self[:links] != :follow) or self.class.name == :tidy
      method = :lstat
    end

    @stat = begin
      Puppet::FileSystem.send(method, self[:path])
    rescue Errno::ENOENT => error
      nil
    rescue Errno::ENOTDIR => error
      nil
    rescue Errno::EACCES => error
      warning "Could not stat; permission denied"
      nil
    end
  end

end
