[![Gem Version](https://badge.fury.io/rb/aruba.svg)](http://badge.fury.io/rb/aruba)
[![Dependency Status](https://gemnasium.com/cucumber/aruba.svg)](https://gemnasium.com/cucumber/aruba)
[![Code Climate](https://codeclimate.com/github/cucumber/aruba.svg)](https://codeclimate.com/github/cucumber/aruba)
[![Join the chat at https://gitter.im/cucumber/aruba](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/cucumber/aruba?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

**This is the [latest](https://github.com/cucumber/aruba/blob/master/README.md) version of our README.md. If you want to see the one of the last released version of "aruba", please have a look at this [one](https://github.com/cucumber/aruba/blob/still/README.md).**

`aruba` is an extension for popular TDD and BDD frameworks like "Cucumber", "RSpec" and "Minitest" to make testing of commandline applications meaningful, easy and fun.

Your benefits:

* Test any command line application implemented in any [programming
  language](features/getting_started/supported_programming_languages.feature) -
  e.g. Bash, Python, Ruby, Java, ...
* Manipulate the file system and the process environment with helpers working similar like tools you may know from your shell
* No worries about leaking state: The file system and the process environment will be reset between tests
* Support by a helpful and welcoming community &ndash; see our [Code of Conduct](https://github.com/cucumber/cucumber/blob/master/CODE_OF_CONDUCT.md)
* The [documentation](features/) is our contract with you. You can expect `aruba` to work as documented

Our Vision:

* Help our users to build better command line applications written in any programming language
* Make creating documentation for command line simple and fun
* Support the cucumber community in its effort to create a specification for all official cucumber implementations

Our Focus:
* Test the user-interaction with the commands at runtime &ndash; this excludes the process of installation/deployment of commands like installing Rubygems with `gem install <your-gem>`.


<table>
  <thead>
    <tr>
      <th colspan="3">
        Build status
      </th>
    </tr>
    <tr>
      <th>
        Version
      </th>
      <th>
        Linux / OS X
      </th>
      <th>
        Windows
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        master
      </td>
      <td>
        [![Build Status](https://travis-ci.org/cucumber/aruba.svg?branch=master)](https://travis-ci.org/cucumber/aruba)
      </td>
      <td>
        [![Build status](https://ci.appveyor.com/api/projects/status/jfo2tkqhnrqqcivl?svg=true)](https://ci.appveyor.com/project/cucumberbdd/aruba/branch/master)
      </td>
    </tr>
    <tr>
      <td>
        still
      </td>
      <td>
        [![Build Status](https://travis-ci.org/cucumber/aruba.svg?branch=still)](https://travis-ci.org/cucumber/aruba)
      </td>
      <td>
        [![Build status](https://ci.appveyor.com/api/projects/status/jfo2tkqhnrqqcivl?svg=true)](https://ci.appveyor.com/project/cucumberbdd/aruba/branch/still)
      </td>
    </tr>
  </tbody>
<table>


## Install

Add this line to your application's `Gemfile`:

    gem 'aruba'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aruba

### Release Policy

We try to be compliant to [Semantic Versioning 2.0.0](http://semver.org/spec/v2.0.0.html).

### Supported ruby versions

For an up to date list of all supported ruby versions, please see our [`.travis.yml`](https://github.com/cucumber/aruba/blob/master/.travis.yml). We only test against the latest version of a version branch - most times.

## Usage

Please also see this
[feature test](https://github.com/cucumber/aruba/blob/master/features/getting_started/supported_testing_frameworks.feature)
for the most up to date documentation.

### Initialize your project with "aruba"

There's an initializer to make it easier for you to getting started. If you
prefer to setup `aruba` yourself, please move on to the next section.

1. Go to your project's directory

2. Make sure, it's under version control and all changes are committed to your
   version control repository

3. Run one of the following commands depending on the tools you use to test your project.

   This assumes, that you use either `rspec`, `cucumber-ruby` or `minitest` to
   write the tests for your project. Besides that, your tool can be implemented
   in any programming language you like.

   ~~~bash
   aruba init --test-framework rspec
   aruba init --test-framework cucumber
   aruba init --test-framework minitest
   ~~~

### Cucumber

1. Create a file named "features/support/env.rb" with:

   ~~~ruby
   require 'aruba/cucumber'
   ~~~

2. Create a file named "features/use_aruba_with_cucumber.feature" with:

   ~~~ruby
   Feature: Cucumber
     Scenario: First Run
       Given a file named "file.txt" with:
       """
       Hello World
       """
       Then the file "file.txt" should contain:
       """
       Hello World
       """
   ~~~

3. Run `cucumber`

### RSpec

1. Create a file named "spec/support/aruba.rb" with:

   ~~~ruby
   require 'aruba/rspec'
   ~~~

2. Create a file named "spec/spec_helper.rb" with:

   ~~~ruby
   $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

   ::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }
   ~~~

3. Create a file named named "spec/use_aruba_with_rspec_spec.rb" with:

   ~~~ruby
   require 'spec_helper'

   RSpec.describe 'First Run', :type => :aruba do
     let(:file) { 'file.txt' }
     let(:content) { 'Hello World' }

     before(:each) { write_file file, content }

     it { expect(read(file)).to eq [content] }
   end
   ~~~

4. Run `rspec`

### Minitest

1. Add a file named "test/support/aruba.rb" with:

   ~~~ ruby
   require 'aruba/api'
   ~~~

2. Add a file named "test/test_helper.rb" with:

   ~~~ruby
   $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

   ::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require_relative f }
   ~~~

3. Add a file named "test/use_aruba_with_minitest.rb" with:

   ~~~ruby
   $LOAD_PATH.unshift File.expand_path('../test', __FILE__)

   require 'test_helper'
   require 'minitest/autorun'

   class FirstRun < Minitest::Test
     include Aruba::Api

     def setup
       aruba_setup
     end

     def getting_started_with_aruba
       file = 'file.txt'
       content = 'Hello World' 

       write_file file, content
       read(file).must_equal [content]
     end
   end
   ~~~

4. Run your tests

   `ruby -Ilib:test test/use_aruba_with_minitest.rb`

## Documentation

### User Documentation

If you're interested in our steps and API, please browse our [feature
files](https://github.com/cucumber/aruba/tree/master/features). You can find a
lot of examples there. A good starting point are [Getting
Started](https://github.com/cucumber/aruba/tree/master/features/getting_started)
and [Step
Overview](https://github.com/cucumber/aruba/blob/master/features/steps/overview.feature).
A more or less full list of our steps can be found
[here](https://github.com/cucumber/aruba/tree/master/features/steps). Our API
is documentated
[here](https://github.com/cucumber/aruba/tree/master/features/api) and some
more information about how to configure `aruba`, can be found
[here](https://github.com/cucumber/aruba/tree/master/features/configuration).
The "RSpec" matchers provided by `aruba`, are documented
[here](https://github.com/cucumber/aruba/tree/master/features/matchers).

You can find our documentation on
[Relish](http://www.relishapp.com/cucumber/aruba/docs) as well. Unfortunately
"Relish" does not like the way we structered our feature tests. So this
documentation found there may be not complete.

**Table of Contents**

* [Getting Started](features/getting_started)
  * [cleanup](features/getting_started/cleanup.feature)
  * [install](features/getting_started/install.feature)
  * [run commands](features/getting_started/run_commands.feature)
  * [supported testing frameworks](features/getting_started/supported_testing_frameworks.feature)
  * [writing good tests.feature](features/getting_started/writing_good_feature_tests.feature)
* [Our API](features/api)
  * [Commands](features/api/command)
    * [find command](features/api/command/find_command.feature)
    * [last command started](features/api/command/last_command_started.feature)
    * [last command stopped](features/api/command/last_command_stopped.feature)
    * [run](features/api/command/run.feature)
    * [run simple](features/api/command/run_simple.feature)
    * [send signal](features/api/command/send_signal.feature)
    * [stderr](features/api/command/stderr.feature)
    * [stdout](features/api/command/stdout.feature)
    * [stop all commands](features/api/command/stop_all_commands.feature)
    * [stop](features/api/command/stop.feature)
    * [terminate all commands](features/api/command/terminate_all_commands.feature)
    * [which](features/api/command/which.feature)
  * [Core](features/api/core)
    * [expand path](features/api/core/expand_path.feature)
  * [Environment](features/api/environment)
    * [append environment variable](features/api/environment/append_environment_variable.feature)
    * [delete environment variable](features/api/environment/delete_environment_variable.feature)
    * [prepend environment variable](features/api/environment/prepend_environment_variable.feature)
    * [set environment variable](features/api/environment/set_environment_variable.feature)
  * [Filesystem](features/api/filesystem)
    * [cd](features/api/filesystem/cd.feature)
    * [copy](features/api/filesystem/copy.feature)
    * [create directory](features/api/filesystem/create_directory.feature)
    * [disk usage](features/api/filesystem/disk_usage.feature)
    * [does exist](features/api/filesystem/does_exist.feature)
    * [is absolute](features/api/filesystem/is_absolute.feature)
    * [is directory](features/api/filesystem/is_directory.feature)
    * [is file](features/api/filesystem/is_file.feature)
    * [is relative](features/api/filesystem/is_relative.feature)
    * [move](features/api/filesystem/move.feature)
  * [Text](features/api/text)
    * [extract text](features/api/text/extract_text.feature)
    * [replace variables](features/api/text/replace_variables.feature)
    * [sanitize text](features/api/text/sanitize_text.feature)
    * [unescape text](features/api/text/unescape_text.feature)
  * [Use aruba command](features/cli)
    * [console](features/cli/console.feature)
    * [init](features/cli/init.feature)
  * [Configuration](features/configuration)
    * [activate announcer on command failure](features/configuration/activate_announcer_on_command_failure.feature)
    * [command runtime environment](features/configuration/command_runtime_environment.feature)
    * [console history file](features/configuration/console_history_file.feature)
    * [exit timeout](features/configuration/exit_timeout.feature)
    * [fixtures directories](features/configuration/fixtures_directories.feature)
    * [fixtures path prefix](features/configuration/fixtures_path_prefix.feature)
    * [home directory](features/configuration/home_directory.feature)
    * [io timeout](features/configuration/io_timeout.feature)
    * [keep ansi](features/configuration/keep_ansi.feature)
    * [log level](features/configuration/log_level.feature)
    * [physical block size](features/configuration/physical_block_size.feature)
    * [remove ansi escape sequences](features/configuration/remove_ansi_escape_sequences.feature)
    * [root directory](features/configuration/root_directory.feature)
    * [startup wait time](features/configuration/startup_wait_time.feature)
    * [usage](features/configuration/usage.feature)
    * [working directory](features/configuration/working_directory.feature)
  * [development](features/development)
    * [bootstrap aruba](features/development/bootstrap-aruba.feature)
    * [build aruba](features/development/build-aruba.feature)
    * [build docker image](features/development/build-docker-image.feature)
    * [install gem](features/development/install-gem.feature)
    * [lint ruby sources](features/development/lint-ruby-sources.feature)
    * [lint travisjconfiguration](features/development/lint-travis-configuration.feature)
    * [lint used licenses of rubygems](features/development/lint-used-licenses-of-rubygems.feature)
    * [release gem](features/development/release-gem.feature)
    * [run aruba console](features/development/run-aruba-console.feature)
    * [run docker container](features/development/run-docker-container.feature)
    * [run test suite](features/development/run-test-suite.feature)
  * [Hooks](features/hooks)
    * [After Command](features/hooks/after/command.feature)
    * [Before Command](features/hooks/before/command.feature)
  * [Matchers](features/matchers)
    * [collection](features/matchers/collection)
      * [include an object](features/matchers/collection/include_an_object.feature)
    * [command](features/matchers/command)
    * [directory](features/matchers/directory)
      * [have sub directory](features/matchers/directory/have_sub_directory.feature)
    * [file](features/matchers/file)
      * [be a command found in path](features/matchers/file/be_a_command_found_in_path.feature)
      * [be existing executable](features/matchers/file/be_existing_executable.feature)
      * [be existing file](features/matchers/file/be_existing_file.feature)
      * [have file content](features/matchers/file/have_file_content.feature)
      * [have file size](features/matchers/file/have_file_size.feature)
    * [path](features/matchers/path)
      * [be an absolute path](features/matchers/path/be_an_absolute_path.feature)
      * [be an existing path](features/matchers/path/be_an_existing_path.feature)
      * [have permissions](features/matchers/path/have_permissions.feature)
    * [timeouts](features/matchers/timeouts.feature)
  * [Platforms](features/platforms)
        * [jruby](features/platforms/jruby.feature)
  * [rspec](features/rspec)
    * [integration](features/rspec/integration.feature)
  * [Cucumber steps](features/steps)
    * [overview](features/steps/overview.feature)
    * [command](features/steps/command)
      * [debug](features/steps/command/debug.feature)
      * [exit statuses](features/steps/command/exit_statuses.feature)
      * [in process](features/steps/command/in_process.feature)
      * [interactive](features/steps/command/interactive.feature)
      * [output](features/steps/command/output.feature)
      * [run](features/steps/command/run.feature)
      * [send signal](features/steps/command/send_signal.feature)
      * [shell](features/steps/command/shell.feature)
      * [stderr](features/steps/command/stderr.feature)
      * [stdout](features/steps/command/stdout.feature)
      * [stop](features/steps/command/stop.feature)
    * [core](features/steps/core)
      * [announce](features/steps/core/announce.feature)
    * [environment](features/steps/environment)
      * [append environment variable](features/steps/environment/append_environment_variable.feature)
      * [home variable](features/steps/environment/home_variable.feature)
      * [prepend environment variable](features/steps/environment/prepend_environment_variable.feature)
      * [set environment variable](features/steps/environment/set_environment_variable.feature)
    * [filesystem](features/steps/filesystem)
      * [append to file](features/steps/filesystem/append_to_file.feature)
      * [cd to directory](features/steps/filesystem/cd_to_directory.feature)
      * [check file content](features/steps/filesystem/check_file_content.feature)
      * [check permissions of file](features/steps/filesystem/check_permissions_of_file.feature)
      * [compare files](features/steps/filesystem/compare_files.feature)
      * [copy](features/steps/filesystem/copy.feature)
      * [create directory](features/steps/filesystem/create_directory.feature)
      * [create file](features/steps/filesystem/create_file.feature)
      * [existence of directory](features/steps/filesystem/existence_of_directory.feature)
      * [existence of file](features/steps/filesystem/existence_of_file.feature)
      * [file content](features/steps/filesystem/file_content.feature)
      * [fixtures](features/steps/filesystem/fixtures.feature)
      * [move](features/steps/filesystem/move.feature)
      * [non existence of directory](features/steps/filesystem/non_existence_of_directory.feature)
      * [non existence of file](features/steps/filesystem/non_existence_of_file.feature)
      * [overwrite file](features/steps/filesystem/overwrite_file.feature)
      * [remove directory](features/steps/filesystem/remove_directory.feature)
      * [remove file](features/steps/filesystem/remove_file.feature)
      * [use fixture](features/steps/filesystem/use_fixture.feature)

### Developer Documentation

`aruba` provides a wonderful API to be used in your tests:

* Creating files/directories
* Deleting files/directories
* Checking file size
* Checking file existence/absence
* ...

A full documentation of the API can be found
[here](http://www.rubydoc.info/github/cucumber/aruba/master/frames).

## Contributing

Please see the [CONTRIBUTING](CONTRIBUTING.md) file.

## Copyright

Copyright (c) 2010-2016 Aslak Hellesøy et al. See [MIT License](LICENSE) for details.
