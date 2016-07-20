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

id_rsa1_pub = `cat tests/ssh/id_rsa1_pub`
id_rsa2_pub = `cat tests/ssh/id_rsa1_pub`
describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/authorized_keys") do
  it { should be_file }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
  it { should be_mode 600 }
  # id_rsa1.pub
  its(:content) { should include("#{id_rsa1_pub}") }
  # id_rsa2.pub
  its(:content) { should include("#{id_rsa2_pub}") }
end

describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/config") do
  it { should be_file }
  it { should be_owned_by ENV['SSHCONFIG_OWNER'] }
  it { should be_grouped_into ENV['SSHCONFIG_GROUP'] }
  it { should be_mode 600 }
  its(:content) { should include('Host *') }
  its(:content) { should include('StrictHostKeyChecking=no') }
end

# Avoid OSX on Travis.
describe file("#{ENV['SSHCONFIG_HOME']}/.ssh/known_hosts"), :if => os[:family] == 'debian' do
  its(:content) { should include('github.com') }
  its(:content) { should include('bitbucket.org') }
end
