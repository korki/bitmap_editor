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
    validate_horizontal_coords(x)
    validate_vertical_coords(y)
    validate_colour(colour)
    @image[y - 1][x - 1] = colour
  end

  def vertical(x, y1, y2, colour)
    validate_horizontal_coords(x)
    validate_vertical_coords(y1, y2)
    (y1..y2).to_a.each do |y|
      colour(x, y, colour)
    end
  end

  def horizontal(x1, x2, y, colour)
    validate_horizontal_coords(x1, x2)
    validate_vertical_coords(y)
    (x1..x2).to_a.each do |x|
      colour(x, y, colour)
    end
  end

  def to_s
    @image.map do |row|
      row.join('')
    end
  end

  def validate_size(size)
    fail RangeError, "Size #{size} should be between 1 and 255" if size < MIN_SIZE || size > MAX_SIZE
  end

  def validate_positive_coords(*coords)
    fail RangeError, "Coordinates can't be negative" if coords.any? { |c| c.first < 0 }
  end

  def validate_vertical_coords(*coords)
    validate_positive_coords(coords)
    coords.each do |coord|
      fail RangeError, "#{coord} is too big" if coord > image.size
    end
  end

  def validate_horizontal_coords(*coords)
    validate_positive_coords(coords)
    coords.each do |coord|
      fail RangeError, "#{coord} is too big" if coord > image.first.size
    end
  end

  def validate_colour(colour)
    unless colour =~ /[A-Z]/ && colour.size == 1
      fail ArgumentError, "#{colour} is not a valid colour"
    end
  end
end
