# Lamian
[![Actions Status](https://github.com/umbrellio/lamian/workflows/Test/badge.svg)](https://github.com/umbrellio/lamian/actions) [![Coverage Status](https://coveralls.io/repos/github/umbrellio/lamian/badge.svg?branch=master)](https://coveralls.io/github/umbrellio/lamian?branch=master) [![Gem Version](https://badge.fury.io/rb/lamian.svg)](https://badge.fury.io/rb/lamian)


Lamian is an in-memory logger, which content could be released for error messages.
It is designed to work in pair with `exception_notification` gem inside rails
aplications

## Usage with ExceptionNotification

1. Add `gem 'lamian'` into your Gemfile
2. Extend `Rails.logger` and any other loggers you want to mirror by
`Lamian::LoggerExtension`: `Lamian.extend_logger(logger)`
3. Add 'request_log' section inside your `ExceptionNotification.configure`
(see [ExceptionNotification README](https://github.com/smartinez87/exception_notification/blob/master/README.md))
4. ExceptionNotification's messages would have 'Request Log' section

## Extended Usage

Add a 'request_log' section into ExceptionNotification's background section.
Add `Lamian.run { }` around code with logs you want to collect. Note, that
logs would be accessible only inside this section and removed after section end.

## Sentry (sentry-ruby)

### Usage

It automatically redefines `Sentry.configuration.before_send` callback
if Sentry initialization is completed. If `before_send` is already defined
it wraps custom callback.

### Usage with Sidekiq

You should add Lamian middleware to the Sidekiq initializer like this:

```ruby
config.server_middleware do |chain|
  chain.prepend(Lamian::SidekiqSentryMiddleware)
end
```

## Raven (deprecated)

### Usage

Add this line to your Sentry initializer:

```ruby
Raven::Context.prepend(Lamian::RavenContextExtension)
```

### Usage with Sidekiq

You should add Lamian middleware to the Sidekiq initializer like this:

```ruby
config.server_middleware do |chain|
  chain.prepend(Lamian::SidekiqRavenMiddleware)
end
```

## Contribution

Feel free to contribute by making PRs and Issues on [GitHub](https://github.com/JelF/lamian)
You also can contact me using my email begdory4+lamian@gmail.com

## TODO

- It probably should be separated to `lamian` and `lamian-rails` gems.
Rails dependency is never cool
