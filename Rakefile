require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  hosts = [
    {
      :name     =>  'localhost',
      :backend  =>  'exec',
      :sshconfig_home =>  '/Users/travis',
      :sshconfig_owner  =>  'travis'
      :sshconfig_group  =>  'staff'
    },
    {
      :name     =>  'container',
      :backend  =>  'docker',
      :sshconfig_home =>  '/root',
      :sshconfig_owner  =>  'root'
      :sshconfig_group  =>  'root'
    },
    {
      :name     =>  'container_with_specified_user',
      :backend  =>  'docker',
      :sshconfig_home =>  '/home/jenkins',
      :sshconfig_owner  =>  'jenkins'
      :sshconfig_group  =>  'jenkins'
    },
  ]
  if ENV['SPEC_TARGET'] then
    target = hosts.select{|h|  h[:name] == ENV['SPEC_TARGET']}
    hosts = target unless target.empty?
  end

  task :all     => hosts.map{|h|  "spec:#{h[:name]}"}
  task :default => :all

  hosts.each do |host|
    desc "Run serverspec tests to #{host[:name]}(backend=#{host[:backend]})"
    RSpec::Core::RakeTask.new(host[:name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      ENV['SPEC_TARGET_BACKEND'] = host[:backend]
      ENV['SSHCONFIG_HOME'] = host[:sshconfig_home]
      ENV['SSHCONFIG_OWNER'] = host[:sshconfig_owner]
      ENV['SSHCONFIG_GROUP'] = host[:sshconfig_group]
      t.pattern = "spec/ssh_config_spec.rb"
    end
  end
end
