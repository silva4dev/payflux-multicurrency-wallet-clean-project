#!/usr/bin/env rackup
# encoding: utf-8

require File.expand_path("../config/boot.rb", __FILE__)

system('stty raw -echo') if $stdin.tty?

run Padrino.application
