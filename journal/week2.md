# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for ruby.
It is the primary way to install ruby packages (known as gems) for ruby.

### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install command`.

This will install the gems on the system globally (unlike nodejs which will install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of a bundler

When have to use `bundle exec`` to tell future ruby scripts to use the gems we installed. this is the way we set context.

#### Sinatra 

Sinatra is a micro web framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a websever in a single file.

[Sinatra](https://sinatrarb.com/)

## Terratowns Mock server

### Running the web server

We can run the webserver by executing the following commands:

```rb
bundle install
bundle exec ruby swerver.rb
```

All of the code for our webserver is stored in the `server.rb` file.