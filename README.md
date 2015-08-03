# Gordon

We all know that packaging applications is a pain. A lot of pain.

Of course, [fpm](https://github.com/jordansissel/fpm) is a awesome tool to abstract package generation for a lot of Operational Systems. Period.

Of course, [fpm-cookery](https://github.com/bernd/fpm-cookery) is another great tool to approach building as a simple recipe.

Of course, [foreman](https://github.com/ddollar/foreman) is a great tool to handle Procfile-based applications and have the amazing feature of export to init files (systemd, runit, inittab).

But, unfortunately, create fpm-cookery recipes for each application can be boring and repetitious. You need to create init files (inittab, systemd, etc) for each project and, if a webserver changes (example: from Thin to Unicorn) you need to change script again, again and again.

And when you are in front with a web application that breaks Nginx or Apache conventions? Do you remember that feel, bro?

Gordon is a try to automagically create init files using Foreman and export artifacts using fpm-cookery, on the shoulder of conventions. Make developers free to develop, while you have apps under a minimal control in ops side of view.

## How it works?

Gordon have a lot of restrictions, because they are liberating. These restrictions are a result of years packaging apps, since code generation to minimal security & ops conventions.

Per example: create a user that will run app with credentials, whose $HOME is the directory of application, is a good practice. Therefore, any web app will follow this rule with Gordon. Period.

## How are the options?

* Http Servers: Nginx or Apache;

* Web Servers: Tomcat or Jetty;

* Init scripts: Systemd;

* Apps supported:

    * Ruby Web (resides based on Http Server of choice)
    * Ruby Standalone (resides on /opt/*app_name*)
    * Java Web (resides based on Web Server of choice)
    * Java Standalone (resides on /opt/*app_name*)

## Installation

Add this line to your application's Gemfile:

    gem 'gordon'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gordon

## Usage

Gordon have two ways to package applications. You can create a yaml file called `gordon.yml` on root of your app and CLI will detect it automatically. Here an example how to package two apps: ruby web and standalone java.

```
recipes:
  # web app
  - app_name:         web-app
    app_description:  web-app
    app_homepage:     https://github.com/web/app
    app_type:         web
    app_source:       web-app/
    app_source_excludes:
      - log
      - tmp

    runtime_name:     ruby
    runtime_version:  2.2.2
    http_server_type: nginx
    init_type:        systemd

    package_type:     rpm
    output_dir:       pkg

  # standalone app
  - app_name:         standalone-app
    app_description:  standalone-app
    app_homepage:     https://github.com/standalone/app
    app_type:         standalone
    app_source:       standalone-app/
    app_source_excludes:
      - classes

    runtime_name:     oracle-jre
    runtime_version:  1.8.0_45

    package_type:     rpm
    output_dir:       pkg

```

For more details about all parameters available, please run `gordon --help`.

Another way is using CLI directly. Below some examples how to use it.

### Usage: Packing a Ruby Web Application

First, you need to vendorize all gems in deployment mode:

    $ ruby -S bundle package --all

    $ ruby -S bundle install --deployment --without development test debug

Here a simple example to build a Ruby Web App that runs Nginx and uses Systemd as init process. Just enter on source folder of your app and run in your terminal:

    $ ruby -S gordon                                      \
      --app-type         web                              \
      --app-name         my-ruby-app                      \
      --app-description  "my ruby app"                    \
      --app-homepage     https://github.com/myuser/my-app \
      --app-version      1.0.0                            \
      --app-source       .                                \
      --runtime-name     ruby                             \
      --runtime-version  2.2.0                            \
      --http-server-type nginx                            \
      --init-type        systemd                          \
      --package-type     rpm                              \
      --output           pkg

It will generate a RPM package in pkg/ with the following structure:

* /usr/share/nginx/html/*all-app-stuff*
* /usr/lib/systemd/system/*all-systemd-stuff*
* /var/log/*app-name*

Due for conventions, remember:

* /usr/share/nginx/html is $HOME of user *app-name*;
* Systemd will run app using user *app-name.target*

Sounds good?

### Usage: Java Web Application

First, generate war files. After, do the following steps:

    $ ruby -S gordon                                      \
      --app-type         web                              \
      --app-name         my-java-app                      \
      --app-description  "my java app"                    \
      --app-homepage     https://github.com/myuser/my-app \
      --app-version      1.0.0                            \
      --app-source       path/of/application.war          \
      --runtime-name     oracle-jdk                       \
      --runtime-version  1.8.0_45                         \
      --http-server-type apache                           \
      --web-server-type  tomcat                           \
      --package-type     rpm                              \
      --output           pkg

You must avoid `--init-type` because war files are handled by application server of choice (Tomcat or Jetty).

## Usage: Java Standalone Application

Generate jar files before and after pass some parameters:

    $ ruby -S gordon                                      \
      --app-type         web                              \
      --app-name         my-java-standalone-app           \
      --app-description  "my java standalone app"         \
      --app-homepage     https://github.com/myuser/my-app \
      --app-version      1.0.0                            \
      --app-source       path/of/application.jar          \
      --runtime-name     oracle-jdk                       \
      --runtime-version  1.8.0_45                         \
      --package-type     rpm                              \
      --output           pkg

## Why you not use Omnibus or Heroku buildpacks?

Because I want a tool able to create Linux packages that can be extensible based on my needs.

## Why you use fpm-cookery templates instead of fpm?

Because I not found a trivial way to use fpm when you need to package a application under different directories (Apache2 and Systemd per example). If you show to me, I will think to abolish templates.

## Why you can't handle all recipes into a single one and abstract build and install?

Because I need to call some protected methods on FPM::Cookery::Recipe and adding dynamic mixins will be a nightmare due for complexity to maintain.

## Why Gordon?

Because I like Gordon Ramsay.

## TODO

* Debian check (gem heavly developed under CentOS environment)
* Export init files to other formats supported by foreman;
* Add Oracle JRE / JDK support for Debian (maybe oracle-jre-installer?)
* Validate inputs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

