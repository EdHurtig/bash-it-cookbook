action :install do
  node['bash-it']['instance_default'].each do |attr, val|
    unless new_resource.instance_variable_get("@#{attr}")
      new_resource.instance_variable_set("@#{attr}", val)
    end
  end

  unless new_resource.user
    new_resource.instance_variable_set("@user", new_resource.name)
  end

  home = new_resource.home
  install_dir = new_resource.install_dir
  bashrc = new_resource.bashrc

  home ||= "/home/#{new_resource.user}"
  install_dir ||= "#{home}/.bash_it"
  bashrc ||= "#{home}/.bashrc"

  g = git install_dir do
    repository node['bash-it']['repository']
    revision node['bash-it']['revision']
    action :checkout
    unless new_resource.name == 'global'
      user new_resource.user
      group new_resource.group
    end
  end
  updated = g.updated_by_last_action?

  ruby_block 'activate_deactivate_bash_it_modules' do
    block do
      updated ||= enable(new_resource.plugins, "#{install_dir}/plugins", 'plugin')
      updated ||= enable(new_resource.aliases, "#{install_dir}/aliases", 'aliases')
      updated ||= enable(new_resource.completions, "#{install_dir}/completion", 'completion')
    end
  end

  t = template bashrc do
    cookbook new_resource.templates_cookbook
    source 'bashrc.sh.erb'
    unless new_resource.name == 'global'
      owner new_resource.user
      group new_resource.group
    end
    mode new_resource.name == 'global' ? 0555 : 0550
    variables(
      git: new_resource.git,
      theme: new_resource.theme,
      irc_client: new_resource.irc_client,
      todo: new_resource.todo,
      scm_check: new_resource.scm_check,
      install_dir: install_dir
    )
  end
  updated ||= t.updated_by_last_action?
  new_resource.updated_by_last_action(updated)
end

action :remove do
  home = new_resource.home ||= "/home/#{new_resource.user}"
  install_dir = "#{home}/.bash_it" if install_dir.empty?

  d = directory install_dir do
    recursive true
    action :delete
  end

  new_resource.updated_by_last_action(d.updated_by_last_action?)
end

# rubocop:disable Metrics/AbcSize
def enable(new_names, base_dir, type)
  directory "#{base_dir}/enabled/"

  removed = Dir.glob("#{base_dir}/enabled/*.bash").map do |f|
    ::File.basename f, ".#{type}.bash"
  end - new_names

  removed.map! do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      action :delete
    end.updated_by_last_action?
  end

  added = new_names.map do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      to "#{base_dir}/available/#{script}.#{type}.bash"
    end.updated_by_last_action?
  end

  removed.concat(added).any?
end
# rubocop:enable Metrics/AbcSize
