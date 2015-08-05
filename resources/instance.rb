actions :install, :remove

default_action :install

attribute :name,               kind_of: String, name_attribute: true
attribute :user,               kind_of: String
attribute :group,              kind_of: String
attribute :templates_cookbook, kind_of: String
attribute :home,               kind_of: String
attribute :install_dir,        kind_of: String
attribute :bashrc,             kind_of: String
attribute :theme,              kind_of: String
attribute :git,                kind_of: String
attribute :irc_client,         kind_of: String
attribute :todo,               kind_of: String
attribute :scm_check,          kind_of: [TrueClass, FalseClass]
attribute :plugins,            kind_of: Array
attribute :aliases,            kind_of: Array
attribute :completions,        kind_of: Array
