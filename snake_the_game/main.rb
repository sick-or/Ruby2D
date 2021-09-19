require 'ruby2d'
file_path = File.dirname(__FILE__ )
require file_path + '/snake.rb'
require file_path + '/game.rb'

set background: 'navy'
set fps_cap: 15
# window parameters:
# width = 640/20 = 32
# heigth = 480/20 = 24

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE
welcome_message = "Welcome!
You're going to play game known as 'Snake'
If you want to pause the game press 'space'
If you want to exit press 'escape'
Good luck!
(press F to begin)
"
unless :key_down != 'f'
  update do
    Text.new(welcome_message, color: "green", x: 10, y: 10, size: 25)
  end
end

snake = Snake.new
game = Game.new

update do
  clear

  unless game.finished? || game.paused?
    snake.move
  end

  snake.draw
  game.draw

  if game.snake_hits_ball?(snake.x , snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_itself?
    game.finish
  end

end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_go_this_way?(event.key)
      snake.direction = event.key
    end
  elsif 'escape' == event.key
    close
  elsif 'space'== event.key
    game.pause
  elsif ('r' == event.key) && (game.finished? || game.paused?)
    snake = Snake.new
    game = Game.new
  end
end

show