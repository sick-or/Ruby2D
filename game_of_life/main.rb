PATH = File.dirname(__FILE__ )
require 'ruby2d'
require PATH + '/game.rb'

set fps_cap: 60, background: 'navy', title: 'Game "Life"', width: 900, height: 600

GRID_SIZE = 10
#t = Time.now

game = Game.new(1000)
tick = 0

on :key_down do |event|
  close if event.key == 'escape'
  if event.key == 'r'
    game = Game.new
  end
end

update do
  clear
  if tick % 10 == 0
    game.alive?
    game.new_generation
  end
  game.field
  tick += 1
  Text.new(tick/10, x: 5, y: 5, size: 25)
  #"#{Time.now.min - t.min} : #{(Time.now.sec - t.sec)}"
end

show