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
  its(:content) { should include('github.com') }
  its(:content) { should include('bitbucket.org') }
end
