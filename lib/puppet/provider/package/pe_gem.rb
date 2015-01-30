require 'puppet/provider/package'
require 'uri'
require 'rubygems'
# Ruby gems support.
Puppet::Type.type(:package).provide :pe_gem, :parent => :gem do
  desc "Puppet Enterprise Ruby Gem support. If a URL is passed via `source`, then
    that URL is used as the remote gem repository; if a source is present but is
    not a valid URL, it will be interpreted as the path to a local gem file.  If
    source is not present at all, the gem will be installed from the default gem
    repositories."

  has_feature :versionable, :install_options
  # Test to ensure that we are using puppet enterprise
  # While this might be useful for non-pe installs, we would have to rename this project
  confine :true => begin
    Facter[:puppetversion].value =~ /Enterprise/i
  end

  commands :gemcmd => File.join(Gem.bindir,'gem')
end
