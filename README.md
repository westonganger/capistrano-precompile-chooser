# Capistrano Precompile Chooser

<a href="https://badge.fury.io/rb/capistrano-precompile-chooser" target="_blank"><img height="21" style='border:0px;height:21px;' border='0' src="https://badge.fury.io/rb/capistrano-precompile-chooser.svg" alt="Gem Version"></a>
<a href='https://rubygems.org/gems/capistrano-precompile-chooser' target='_blank'><img height='21' style='border:0px;height:21px;' src='https://img.shields.io/gem/dt/capistrano-precompile-chooser?color=brightgreen&label=Rubygems%20Downloads' border='0' alt='RubyGems Downloads' /></a>
<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='22' style='border:0px;height:22px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee'></a>

Capistrano plugin to precompile your Rails assets locally, remotely, or not at all provided with a very convenient default terminal prompt.

By Default, on every deploy this plugin will prompt you on whether you want to precompile your assets locally, remotely, or not at all. Alternatively you can set some variable for fully automated deploys.

Works with both Sprockets and Propshaft.

```
$ cap production deploy

How do you want to compile assets? (local/remote/skip)
skip
```

## Precompile Modes

- `local` - Local Precompilation Mode (Improves Memory/Load Spikes on Server during Deploys)
- `remote` - Remote Precompilation Mode (Rails Default)
- `skip` - No Precompilation (Speeds up deployments with unchanged assets)

## Installation

```ruby
# Gemfile

group :development do
  gem "capistrano-precompile-chooser"
end
```

```ruby
# Capfile

# require 'capistrano/rails' ### Comment Out or Remove this line
require 'capistrano/precompile_chooser'
```

If you want to be able to safely use the `skip` option you must add `public/assets` to your capistrano `:shared_dirs` variable

```ruby
# config/deploy.rb

set :linked_dirs, %w{ <other-dirs> public/assets }
```

## Usage

Now when running a deployment:

```
$ cap production deploy

How do you want to compile assets? (local/remote/skip)
skip
```

You can also use the `$PRECOMPILE` environment variable

```bash
$ PRECOMPILE_MODE="local" cap production deploy
```

Or for fully automated deploys

```ruby
# Capfile

ENV['PRECOMPILE_MODE'] = 'local'
require 'capistrano/precompile_chooser'
```

## Configuration Options,

```ruby
### For Local Precompile Only
set :assets_dir,   "public/assets"
set :packs_dir,    "public/packs"
set :rsync_cmd,    "rsync -av --delete"
set :assets_role,  "web"
```

# Credits

Created & Maintained by [Weston Ganger](https://westonganger.com) - [@westonganger](https://github.com/westonganger)
