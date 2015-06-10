action :install do
  node['bash-it']['instance_default'].each do |attr, val|
    unless new_resource.instance_variable_get("@#{attr}")
      new_resource.instance_variable_set("@#{attr}", val)
    end
  end

  home = new_resource.home ||= "/home/#{new_resource.name}"
  bash_it = "#{home}/.bash_it"

  g = git bash_it do
    repository node['bash-it']['repository']
    revision node['bash-it']['revision']
    action :checkout
  end
  updated = g.updated_by_last_action?

  ruby_block 'activate_deactivate_bash_it_modules' do
    block do
      updated ||= enable_disable(new_resource.plugins, "#{bash_it}/plugins", 'plugin')
      updated ||= enable_disable(new_resource.aliases, "#{bash_it}/aliases", 'aliases')
      updated ||= enable_disable(new_resource.completions, "#{bash_it}/completion", 'completion')
    end
  end

  t = template "#{home}/.bashrc" do
    cookbook new_resource.templates_cookbook
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
  updated ||= t.updated_by_last_action?
  new_resource.updated_by_last_action(updated)
end

action :remove do
  user = new_resource.name

  d = directory "/home/#{user}/.bash_it" do
    recursive true
    action :delete
    only_if Dir.exist?("/home/#{user}")
  end

  new_resource.updated_by_last_action(d.updated_by_last_action?)
end

# rubocop:disable Metrics/AbcSize
def enable_disable(new_names, base_dir, type)
  directory "#{base_dir}/enabled/"

  removed = Dir.glob("#{base_dir}/enabled/*.bash").map { |f| f.split('.')[0] } - new_names

  removed.map! do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      action :delete
    end.updated_by_last_action?
  end

  new_names.map! do |script|
    link "#{base_dir}/enabled/#{script}.#{type}.bash" do
      to "#{base_dir}/available/#{script}.#{type}.bash"
    end.updated_by_last_action?
  end

  removed.concat(new_names).any?
end
# rubocop:enable Metrics/AbcSize
