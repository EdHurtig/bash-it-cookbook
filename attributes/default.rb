default['bash-it']['repository'] = 'https://github.com/Bash-it/bash-it'
default['bash-it']['revision'] = 'master'

default['bash-it']['users'] = []

default['bash-it']['instance_default']['templates_cookbook'] = 'bash-it'
default['bash-it']['instance_default']['git'] = 'git@github.com'
default['bash-it']['instance_default']['theme'] = 'bobby'
default['bash-it']['instance_default']['irc_client'] = 'irssi'
default['bash-it']['instance_default']['todo'] = 't'
default['bash-it']['instance_default']['scm_check'] = true
default['bash-it']['instance_default']['group'] = 'root'

default['bash-it']['instance_default']['plugins'] = %w(
  base
  browser
  dirs
  extract
  gh
  gif
  git
  history
  java
  javascript
  jekyll
  latex
  nginx
  node
  nvm
  osx
  pyenv
  python
  rbenv
  ruby
  ssh
  tmuxinator
  tmux
  virtualenv
)

default['bash-it']['instance_default']['aliases'] = %w(
  ansible
  bundler
  clipboard
  emacs
  fuck
  general
  git
  gitsvn
  heroku
  homebrew
  rails
  vagrant
  vim
)

default['bash-it']['instance_default']['completions'] = %w(
  bash.bash
  brew
  capistrano
  defaults
  dirs
  fabric
  gem
  gh
  git
  git_flow_avh
  git_flow
  grunt
  gulp
  homesick
  packer
  rake
  salt
  ssh
  test_kitchen
  tmux
  vagrant
  virtualbox
)
