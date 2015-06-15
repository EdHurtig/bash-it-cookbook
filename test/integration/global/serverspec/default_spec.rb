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
    end
  end

  describe file('/etc/bash.bashrc') do
    it { should be_file }
    its(:content) { should include 'Generated by Chef' }
    its(:content) { should include 'bobby' }
    its(:content) { should include 'git@github.com' }
  end
end
