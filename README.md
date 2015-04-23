Yogurt
======

A working CRUD using Roda and Sequel, intended as a bootstrap for
applications that want to leverage a minimal ruby stack.

Just clone the repo, remove `.git` and start your application with a
minimal, but with sensible (in my opinion) defaults, ruby web application.

### Disclaimer

This application uses the latest MRI without concern for
retrocompatibility or cross-implementation support.

It uses Sqlite as default adapter but it's very easy to change, see
[.env-sample](https://github.com/badosu/Yogurt/blob/master/.env-sample) and
[opening_databases.rdoc](http://sequel.jeremyevans.net/rdoc/files/doc/opening_databases_rdoc.html).

It uses Twitter Bootstrap, so it's not exactly minimal on the front-end
but it is useful to illustrate how to bundle your assets.

Some people may feel like there's too much stuff on this bootstrap, others
that there's too few. Some people might think a bootstrap should include
a Rails like *flash* helper or authentication, others that asset bundling
should be not included.

Fortunately Roda makes it really easy to strip off or include middlewares
and plugins, see:

- [list of Roda plugins](http://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins.html)
- [list of Rack middlewares](https://github.com/rack/rack/wiki/List-of-Middleware)
- [Rack standard middlewares](http://www.rubydoc.info/github/rack/rack/Rack)
- [rack-contrib](https://github.com/rack/rack-contrib)

Hopefully you'll find what you need there.

Install
-------

### BS

BS is a script that loads the `.env` file and uses it to configure
environment variables, see `$EDITOR bin/bs`.

Vendored from: https://github.com/educabilia/bs.

### Gems

Install bundler: `gem install bundler`.

Run `bundle install` inside the project's directory.

#### GST

You can also avoid using bundler altogether and use a smaller tool,
[gst](https://github.com/tonchis/gst).

Just make sure to append this to your `.env` file:

    GEM_HOME=$(pwd)/.gs
    GEM_PATH=$(pwd)/.gs
    PATH=$(pwd)/.gs/bin:$PATH

And run `bin/bs` when you need to run any operation that requires the bundle.

With the latest MRI and bundler updates I've not used it anymore, but it
may be useful for the hardcore minimal users.

Configure
---------

Run `cp .env{-sample,} && $EDITOR .env` to setup and configure the
application locally.

Run
---

Run `bin/bs bundle exec unicorn -c unicorn.conf` to run the application
locally (without `bundle exec` if you're using gst).

Visit `/communities`.