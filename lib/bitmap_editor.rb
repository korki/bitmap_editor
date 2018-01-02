require_relative 'image'

class BitmapEditor
  attr_accessor :image

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each_with_index do |line, index|
      begin
        line = line.chomp
        params = line.split(" ")
        command = params[0]
        validate_image(command)
        interpret_command(command, params)
      rescue RangeError, ArgumentError => e
        puts "#{e.message} @ line #{index + 1}"
      rescue SecurityError => e
        puts e.message
        exit
      end
    end
  end

  def interpret_command(command, params)
    case command
    when 'I'
      check_params(params, 2)
      @image = Image.new(params[2].to_i, params[1].to_i)
    when 'C'
      @image.clear
    when 'L'
      check_params(params, 3)
      @image.colour(params[1].to_i, params[2].to_i, params[3])
    when 'V'
      check_params(params, 4)
      @image.vertical(params[1].to_i, params[2].to_i, params[3].to_i, params[4])
    when 'H'
      check_params(params, 4)
      @image.horizontal(params[1].to_i, params[2].to_i, params[3].to_i, params[4])
    when 'S'
      if @image
        puts @image.to_s
      else
        puts "There is no image"
      end
    else
      puts 'unrecognised command :('
    end
  end

  def validate_image(command)
    fail SecurityError, 'Image initialization failed. Ending.' if @image.nil? && command != 'I'
  end

  def check_params(params, required)
    (1..required).to_a.each do |i|
      fail ArgumentError, 'Wrong number of params' if params[i].nil? || params[i].to_s.empty?
    end
  end
end
