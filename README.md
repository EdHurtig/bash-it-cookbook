# bash-it [![Build Status](https://travis-ci.org/edhurtig/bash-it-cookbook.svg)](https://travis-ci.org/edhurtig/bash-it-cookbook)

Installs [Bash it](https://github.com/Bash-it/bash-it) which is an easy way to make your bash shell awesome

![Bash it Booby Theme (Dark)](https://camo.githubusercontent.com/a8093b6728855acc22967af0d65510ed60318c96/68747470733a2f2f7261772e6769746875622e636f6d2f77696b692f726576616e732f626173682d69742f696d616765732f73637265656e73686f74732f626f6262792d626c61636b2e6a7067)

# Requirements

* `apt` cookbook
* `yum` cookbook
* `git` cookbook

# Recipes

## default

Installs Git and will automatically configure Bash it for users specified in `node['bash-it']['users']`

This recipe is not nessesary so long as git is installed before using the `bash_it_instance` LWRP

# Resources

## `bash_it_instance`

To install Bash it for a user you simply put `bash_it_instance <username>` in your recipe.  This is best placed in your users cookbook if you have one.

Default attributes for the `bash_it_instance` are stored as node attributes in the `node['bash-it']['instance_defaults']` hash so that you can easily override the defaults

### Examples

```ruby

# Install Bash it for eddie's user

bash_it_instance 'edhurtig'

# Install Bash it for the root user

bash_it_instance 'root' do
  home '/root'
end

# Instance with a different theme

bash_it_instance 'edhurtig' do
  theme 'candy'
end

# the full set of options

bash_it_instance 'edhurtig' do
    home '/home/edhurtig-custom' # A custom home dir
    theme 'dulice' # Any Bash it theme
    git 'git@git.hurtigtechnologies.com' # Custom Git Server
    scm_check true # Whether to check for SCM continuously
    plugins [...] # An array of plugins that should be active
    aliases [...] # An array of aliases that should be active
    completions [...] # An array of completions that should be active
end

```

# Usage

Include this recipe in a wrapper cookbook:

```
depends 'bash-it', '~> 1.0'
```

```
include_recipe 'bash-it::default'
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: Eddie Hurtig (admin@hurtigtechnologies.com)
