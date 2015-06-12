

if 'debian' == node['platform_family']
  global_bashrc = '/etc/bash.bashrc'
else
  global_bashrc = '/etc/bashrc'
end

bash_it_instance 'global' do
  install_dir '/etc/bash_it'
  bashrc global_bashrc
end
