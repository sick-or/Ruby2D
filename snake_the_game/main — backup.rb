require 'ruby2d'

set background: 'navy'
set fps_cap: 20
# window parameters:
# width = 640/20 = 32
# heigth = 480/20 = 24

GRID_SIZE = 20
GRID_WIDTH = Window.width / GRID_SIZE
GRID_HEIGHT = Window.height / GRID_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions =  [[2, 0], [2, 1], [2, 2], [2, 3]]
    @direction = 'down'
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE , size: GRID_SIZE - 1, color: 'white')
    end
  end

  def move
    @positions.shift
    case @direction
    when 'down'
      @positions.push(new_coordinates(head[0], head[1] + 1))
    when 'up'
      @positions.push(new_coordinates(head[0], head[1] - 1))
    when 'left'
      @positions.push(new_coordinates(head[0] - 1, head[1]))
    when 'right'
      @positions.push(new_coordinates(head[0] + 1, head[1]))
    end
  end

  def can_go_this_way?(new_direction)
    case @direction
    when 'down' then new_direction != 'up'
    when 'up' then new_direction != 'down'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  private

  def new_coordinates(x , y)
    [x % GRID_WIDTH, y % GRID_HEIGHT ]
  end

  def head
    @positions.last
  end

end

snake = Snake.new

tick = 0
update do
  clear

  text_message = tick/20 if tick % 20 == 0
  Text.new(text_message, color: 'green', x: 10, y: 10, size: 25, z: 1)

  snake.move
  snake.draw
  tick += 1
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_go_this_way?(event.key)
      snake.direction = event.key
    end
  end
end


show