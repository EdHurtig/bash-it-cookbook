require 'spec_helper'

describe 'bash-it::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  %w(
    /etc/bash_it
    /etc/bash_it/plugins/enabled
    /etc/bash_it/aliases/enabled
    /etc/bash_it/completion/enabled
  ).each do |d|
    describe file(d) do
      it { should be_directory }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

  %w(
    bash_it.sh
    plugins/available/base.plugin.bash
    aliases/available/vim.aliases.bash
    completion/available/ssh.completion.bash
  ).each do |f|
    describe file("/etc/bash_it/#{f}") do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

  {
    'plugins/enabled/base.plugin.bash' => 'plugins/available/base.plugin.bash',
    'aliases/enabled/vim.aliases.bash' =>  'aliases/available/vim.aliases.bash',
    'completion/enabled/ssh.completion.bash' => 'completion/available/ssh.completion.bash'
  }.each do |link, target|
    describe file("/etc/bash_it/#{link}") do
      it { should be_symlink }
      it { should be_linked_to "/etc/bash_it/#{target}" }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end

  if %w(debian ubuntu).include?(os[:family])
    global_file = '/etc/bash.bashrc'
  else
    global_file = '/etc/bashrc'
  end

  describe file(global_file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its(:content) { should include 'Generated by Chef' }
    its(:content) { should include 'bobby' }
    its(:content) { should include 'git@github.com' }
  end
end
