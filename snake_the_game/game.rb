#require 'ruby2d'
class Game
  def initialize
    @score = 0
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
    @finished = false
    @paused = false
  end

  def draw
    Square.new(x: @ball_x * GRID_SIZE, y: @ball_y * GRID_SIZE, size: GRID_SIZE, color: 'yellow')
    Text.new(text_message, color: "green", x: 10, y: 10, size: 25)
  end

  def snake_hits_ball?(x, y)
    @ball_y == y && @ball_x == x
  end

  def record_hit
    @score += 1
    @ball_x = rand(GRID_WIDTH)
    @ball_y = rand(GRID_HEIGHT)
  end

  def pause
    @paused == true ? @paused = false : @paused = true
  end

  def paused?
    @paused
  end

  def finish
    @finished = true
  end

  def finished?
    @finished
  end

  private

  def text_message
    if finished?
      "Game over! Your score was: #{@score}. Press 'R' to restart"
    elsif paused?
      "Pause"
    else
      "Score: #{@score}"
    end
  end

end
