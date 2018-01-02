require_relative 'image'

class BitmapEditor
  attr_accessor :image

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      params = line.split(" ")
      command = params[0]
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
    end
  end
end
