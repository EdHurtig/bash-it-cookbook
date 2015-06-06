action :install do
  node['bash-it']['instance_default'].each do |attr, val|
    unless new_resource.instance_variable_get("@#{attr}")
      new_resource.instance_variable_set("@#{attr}", val)
    end
  end

  home = new_resource.home ||= "/home/#{new_resource.name}"

  git "#{home}/.bash_it" do
    repository node['bash-it']['repository']
    revision node['bash-it']['revision']
    action :checkout
  end

  ruby_block 'activate_deactivate_bash_it_modules' do
    block do
      update_symlinks new_resource.plugins, "#{home}/.bash_it/plugins", 'plugin'
      update_symlinks new_resource.aliases, "#{home}/.bash_it/aliases", 'aliases'
      update_symlinks new_resource.completions, "#{home}/.bash_it/completion", 'completion'
    end
  end

  template "#{home}/.bashrc" do
    source 'bashrc.sh.erb'
    owner new_resource.name
    group new_resource.name
    mode '0750'
    variables(
      git: new_resource.git,
      theme: new_resource.theme,
      irc_client: new_resource.irc_client,
      todo: new_resource.todo,
      scm_check: new_resource.scm_check
    )
  end
end

action :remove do
  user = new_resource.name

  directory "/home/#{user}/.bash_it" do
    recursive true
    action :remove
    only_if Dir.exist?("/home/#{user}")
  end
end

def update_symlinks(new_names, base_dir, type)
  directory "#{base_dir}/enabled/"

  existing = Dir.glob("#{base_dir}/enabled/*.bash").map { |f| f.split('.')[0] }
  removed = existing - new_names

  removed.each do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      action :delete
    end
  end

  new_names.each do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      to "#{base_dir}/available/#{script}.#{type}.bash"
    end
  end
end
