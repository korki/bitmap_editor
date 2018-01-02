class Image
  MIN_SIZE = 1
  MAX_SIZE = 255
  WHITE_COLOUR = 0

  attr_accessor :image

  def initialize(width, height)
    validate_size(width)
    validate_size(height)
    @image = Array.new(width) { Array.new(height) { WHITE_COLOUR } }
  end

  def clear
    @image.each { |line| line.fill(WHITE_COLOUR) }
  end

  def colour(x, y, colour)
    validate_coords_with_image(x, y)
    validate_colour(colour)
    @image[y - 1][x - 1] = colour
  end

  def vertical(x, y1, y2, colour)
    validate_coords_with_image(x, y1, y2)
    (y1..y2).to_a.each do |y|
      colour(x, y, colour)
    end
  end

  def horizontal(x1, x2, y, colour)
    validate_coords_with_image(x1, x2, y)
    (x1..x2).to_a.each do |x|
      colour(x, y, colour)
    end
  end

  def validate_size(size)
    fail RangeError, "Size #{size} should be between 1 and 255" if size < MIN_SIZE || size > MAX_SIZE
  end

  def validate_coords_with_image(*sizes)
    sizes.each do |size|
      validate_size(size)
      fail RangeError, "#{size} is too big" if size > image.size + 1 || size > image.first.size + 1
    end
  end

  def validate_colour(colour)
    unless colour =~ /[A-Z]/ && colour.size == 1
      fail ArgumentError, "#{colour} is not a valid colour"
    end
  end
end
