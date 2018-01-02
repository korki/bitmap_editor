class Image
  attr_accessor :image

  def initialize(width, height)
    @image = Array.new(width) { Array.new(height) { 0 } }
  end

  def clear
    @image.each { |line| line.fill(0) }
  end

  def colour(x, y, colour)
    @image[y - 1][x - 1] = colour
  end

  def vertical(x, y1, y2, colour)
    (y1..y2).to_a.each do |y|
      colour(x, y, colour)
    end
  end

  def horizontal(x1, x2, y, colour)
    (x1..x2).to_a.each do |x|
      colour(x, y, colour)
    end
  end
end
