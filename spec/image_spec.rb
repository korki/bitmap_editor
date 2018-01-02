require 'spec_helper'

describe Image do
  def image
    @image ||= described_class.new(2, 3)
  end

  def subject
    image.image
  end

  describe 'initialize' do
    it 'returns exception when any size is too big' do
      expect { described_class.new(2, 300) }.to raise_error(RangeError)
      expect { described_class.new(300, 2) }.to raise_error(RangeError)
    end

    it 'returns exception when any size is too small' do
      expect { described_class.new(-1, 2) }.to raise_error(RangeError)
      expect { described_class.new(2, -1) }.to raise_error(RangeError)
    end

    it 'creates image array with correct size' do
      expect(subject.size).to eq 2
      subject.each do |line|
        expect(line.size).to eq 3
      end
    end

    it 'fills new image with zeros' do
      subject.each do |line|
        line.each do |point|
          expect(point).to eq 0
        end
      end
    end
  end

  describe 'clear' do
    it 'returns exception when no image exists' do
      image.image = nil
      expect { image.clear }.to raise_error(NoMethodError)
    end

    it 'fills existing image with zeros' do
      image.clear
      image.image.each do |line|
        line.each do |point|
          expect(point).to eq 0
        end
      end
    end
  end

  describe 'colour' do
    it 'returns exception when colour doesnt exist' do
      expect { image.colour(1, 1, 'Green') }.to raise_error(ArgumentError)
      expect { image.colour(1, 1, '4') }.to raise_error(ArgumentError)
      expect { image.colour(1, 1, 4) }.to raise_error(ArgumentError)
    end

    it 'returns exception when any coordinate is out of bounds' do
      expect { image.colour(1, 300, 'A') }.to raise_error(RangeError)
      expect { image.colour(300, 1, 'A') }.to raise_error(RangeError)
    end

    it 'paints given point with given colour' do
      image.colour(1, 1, 'A')
      expect(subject[0][0]).to eq 'A'
    end
  end

  describe 'vertical' do
    it 'returns expception when line is out of bounds' do
      expect { image.vertical(300, 1, 2, 'A') }.to raise_error(RangeError)
      expect { image.vertical(1, 1, 300, 'A') }.to raise_error(RangeError)
      expect { image.vertical(1, 300, 2, 'A') }.to raise_error(RangeError)
    end

    it 'paints given line coordinates with given colour' do
      image.vertical(1, 1, 2, 'A')
      expect(subject[0][0]).to eq 'A'
      expect(subject[1][0]).to eq 'A'
    end
  end

  describe 'horizontal' do
    it 'returns expception when line is out of bounds' do
      expect { image.horizontal(300, 1, 2, 'A') }.to raise_error(RangeError)
      expect { image.horizontal(1, 1, 300, 'A') }.to raise_error(RangeError)
      expect { image.horizontal(1, 300, 2, 'A') }.to raise_error(RangeError)
    end

    it 'paints given line coordinates with given colour' do
      image.horizontal(1, 2, 1, 'A')
      expect(subject[0][0]).to eq 'A'
      expect(subject[0][1]).to eq 'A'
    end
  end
end
