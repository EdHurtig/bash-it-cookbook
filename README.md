# bash-it [![Build Status](https://travis-ci.org/EdHurtig/bash-it-cookbook.svg)](https://travis-ci.org/EdHurtig/bash-it-cookbook) [![Cookbook Version](https://img.shields.io/cookbook/v/bash-it.svg)](https://supermarket.chef.io/cookbooks/bash-it) [![License](https://img.shields.io/github/license/edhurtig/bash-it-cookbook.svg)](https://raw.githubusercontent.com/EdHurtig/bash-it-cookbook/master/LICENSE)

Installs [Bash it](https://github.com/Bash-it/bash-it) which is an easy way to make your bash shell awesome

![Bash it Booby Theme (Dark)](https://camo.githubusercontent.com/a8093b6728855acc22967af0d65510ed60318c96/68747470733a2f2f7261772e6769746875622e636f6d2f77696b692f726576616e732f626173682d69742f696d616765732f73637265656e73686f74732f626f6262792d626c61636b2e6a7067)

# Requirements

* `apt` cookbook
* `yum` cookbook
* `git` cookbook

# Attributes

The `node['bash-it']['instance_default']` attributes are parsed out as defaults for the `bash_it_instance` resource

The `node['bash-it']['repository']` and `node['bash-it']['revision']` attributes are used to specify the git repo and revision to clone down bash-it from.  It defaults to the [official bash-it repo](https://github.com/Bash-it/bash-it)

The `node['bash-it']['users']` attribute is an array of usernames that should have bash-it installed accoring to the instance defaults.  FYI: I will probably deprecate this in the future


See [attributes/default.rb](https://github.com/EdHurtig/bash-it-cookbook/blob/master/attributes/default.rb) for more details

# Recipes

## `bash-it::default`

* Apt & Yum Recipes
* Install Git
* Configure Bash it for users specified in `node['bash-it']['users']`

This recipe is not nessesary so long as git is installed before using the `bash_it_instance` LWRP

## `bash-it::global`

This recipe will install a global version of bash-it for all users on the system.  I don't like this approach personally because it is not flexible and a shell should be configurable to a user's own preferances when possible

In any event, to use this recipe you just need to include `bash-it::global`

Note: You might need the `bash-it::default` recipe to install dependencies as well

This recipe will use the `node['bash-it']['instance_default']` keys to determine plugins, aliases, ect.

# Resources

## `bash_it_instance`

To install Bash it for a user you simply put `bash_it_instance <username>` in your recipe.  This is best placed in your users cookbook if you have one.

Default attributes for the `bash_it_instance` are stored as node attributes in the `node['bash-it']['instance_default']` hash so that you can easily override the defaults

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
    plugins %w( base history ruby  ) # An array of plugins that should be active
    aliases %w( git rails tmux ) # An array of aliases that should be active
    completions %w( git ssh tmux test-kitchen ) # An array of completions that should be active
end

```

# Usage

Include this recipe in a wrapper cookbook:

```
depends 'bash-it', '~> 1.0'
```


```
# Install bash it globally using the node['bash-it']['instance_default'] attributes
include_recipe 'bash-it::global'

# Install an instance of bash-it for a specific user using the defaults
bash_it_instance 'edhurtig'
```

# TODO

See the [Issues](https://github.com/EdHurtig/bash-it-cookbook/issues)

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests with `kitchen test`, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Author:: Eddie Hurtig (admin@hurtigtechnologies.com)
