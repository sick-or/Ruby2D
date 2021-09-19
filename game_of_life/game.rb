# frozen_string_literal: true

class Block
  attr_accessor :alive, :neighbours

  def initialize(x,y)
    @pos_x = x * GRID_SIZE
    @pos_y = y * GRID_SIZE
    @alive = false
    @neighbours = Array.new
  end

  def draw
    @alive ? Square.new(x: @pos_x, y: @pos_y, size: GRID_SIZE - 1,
      color: 'white') : Square.new(x: @pos_x, y: @pos_y, size: GRID_SIZE - 1, color: 'navy')
  end

  def position
    [@pos_x, @pos_y]
  end
end

class Game
  attr_accessor :test_arr, :game_field

  def initialize(seed)
    @game_field = Array.new
    (Window.width/GRID_SIZE).times do |x|
      (Window.height/GRID_SIZE).times do |y|
        @game_field << Block.new(x, y)
      end
    end
    seed.times { @game_field[rand((Window.height/GRID_SIZE)*(Window.width/GRID_SIZE))].alive = true }
  end

  def field
    @game_field.each { |block| block.draw if block.alive }
    (Window.width/GRID_SIZE).times  {|i|
 Line.new(x1: i * GRID_SIZE, x2: i * GRID_SIZE, y1: 0, y2: Window.height, width: 1, color: "black")}
    (Window.height/GRID_SIZE).times  {|i|
 Line.new(x1: 0, x2: Window.width, y1: i * GRID_SIZE, y2: i * GRID_SIZE, width: 1, color: "black")}
  end

  def field_empty?(block, neighbour)
    dx = block[0] - neighbour[0]
    dy = block[1] - neighbour[1]
    ((dx.abs == GRID_SIZE) && (dy.abs == GRID_SIZE)) || ((dx.abs == GRID_SIZE) && (dy == 0)) || ((dx == 0) && (dy.abs == GRID_SIZE))
  end

  def alive?
    @game_field.each do |block|
      block.neighbours.clear
      @game_field.each { |block_neighbour|
 block.neighbours << block_neighbour.position if block_neighbour.alive && field_empty?(block.position,
block_neighbour.position) && !block.neighbours.any?(block_neighbour.position) }
    end
  end

  def new_generation
    @game_field.each do |block|
      block.alive = ( ( (block.neighbours.size == 2) && (block.alive == true) ) || (block.neighbours.size == 3) ) ? true : false
    end
  end

end