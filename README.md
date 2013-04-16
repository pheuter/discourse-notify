discourse-notify
================

Native app that displays Discourse notifications on the desktop

## Prerequisites

* [terminal-notifier](https://github.com/alloy/terminal-notifier) for notifications on OS X
* [gir_ffi](https://github.com/mvz/ruby-gir-ffi) for interop with libnotify on linux
* libgirepository1.0-dev
* libnotify-dev

## Resources

* [terminal-notifier](https://github.com/alloy/terminal-notifier)
* [Libnotify](https://wiki.archlinux.org/index.php/Libnotify)

## Installation

### Ubuntu

```sh
$ apt-get install libgirepository1.0-dev libnotify-dev
```

Then, in app directory:

```sh
$ bundle install
```

### Mac OS X

In app directory:

```sh
$ bundle install
```