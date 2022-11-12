#!/usr/bin/ruby

require 'dotenv'
require_relative 'helpers/init_game'
require_relative 'game'

Dotenv.load

InitGame.init_game_all(force_reset: true)
Game.new
