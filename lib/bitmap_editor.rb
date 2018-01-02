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
        case command
        when 'I'
          @image = Image.new(params[2].to_i, params[1].to_i)
        when 'C'
          @image.clear
        when 'L'
          @image.colour(params[1].to_i, params[2].to_i, params[3])
        when 'V'
          @image.vertical(params[1].to_i, params[2].to_i, params[3].to_i, params[4])
        when 'H'
          @image.horizontal(params[1].to_i, params[2].to_i, params[3].to_i, params[4])
        when 'S'
          if @image
            @image.image.each do |row|
              puts row.join('')
            end
          else
            puts "There is no image"
          end
        else
          puts 'unrecognised command :('
        end
      rescue RangeError, ArgumentError => e
        puts "#{e.message} @ line #{index + 1}"
      rescue SecurityError => e
        puts e.message
        exit
      end
    end
  end

  def validate_image(command)
    fail SecurityError, 'Image initialization failed. Ending.' if @image.nil? && command != 'I'
  end
end
