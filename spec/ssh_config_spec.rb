require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

describe file("#{ENV['SSHCONFIG_HOME']}/.ssh") do
  it { should be_directory }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
end

describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/known_hosts") do
  it { should be_file }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
end

['id_rsa1.pub', 'id_rsa2.pub'].each do |pub|
  describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/#{pub}") do
    it { should be_file }
    it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
    it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
    it { should be_mode 644 }
  end
end

['id_rsa1', 'id_rsa2'].each do |pri|
  describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/#{pri}") do
    it { should be_file }
    it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
    it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
    it { should be_mode 600 }
  end
end

describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/authorized_keys") do
  it { should be_file }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
  it { should be_mode 600 }
  # id_rsa1.pub
  its(:content) { should include('AAAAB3NzaC1yc2EAAAADAQABAAABAQDHz9qJRRY9KNxxBc+FxYz904GrtCtDYTHxeBY1NPZ2RtNQQOyGZIr4XFDIv89rG017rJh3xIcYXixBJRN/GQq8GexjJBq8uB7OO65smeh7w5iZe7++2672eR8zpWmDkymLzWDuRR3c6Mx+/9jSiYNy0+4mdghYLYdMqjmbLDMWa7wOWVVRgEGhWDVJ7MP6AWydICB5V+yaIlLu4cdmS7NUXRPrrHAmAph3lsvG1P9oovBTh2KBdaGqfMlYTiwQhy/e+5WDZY9/AQ+zOAfuDMdiKHiLm9+3L/16SaT9im+tW/a0BKAuIYb8qe7b60QkeUY/i9QFla4fsC3tl4D+KN8f') }
  # id_rsa2.pub
  its(:content) { should include('AAAAB3NzaC1yc2EAAAADAQABAAABAQC1iecz1Lorz1FQS8EpgRccf9SXJEPsLyDBFUH32aqIyylvV1PC5iWNcHTWs03fFLV63QeI5PX1Bl7CAG0Gea2xmsaeJWU6esqVbbq5wgkMlErtX9CeQyjQGJ98rKc/fSHZua2iCRwhfijyJGMKcH36K5bcE/yGJwiiLc+1igUMxNb7qP1eV+874+3oIP51y1ZWw8Q4nGh3jkQ4cTG08TX32ucrLu3uqWOnHokXuTxoTh9UdvLopKnGVvUVroqeDZXaLtFSaWG9vygaFAYO7I7sQii8OqEf77ra0CupkUvK2ft0FGWZxoGMEMdJX56cGC0YyZhFhyE6MgviX6e7A783') }
end

describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/config") do
  it { should be_file }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
  it { should be_mode 600 }
  its(:content) { should include('Host *') }
  its(:content) { should include('StrictHostKeyChecking=no') }
  its(:content) { should include('UserKnownHostsFile=/dev/null') }
  its(:content) { should include('UseRoaming no') }
end

# Avoid OSX on Travis.
describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/known_hosts"), :if => os[:family] == 'debian' do
  its(:content) { should include('github.com') }
  its(:content) { should include('bitbucket.org') }
end
