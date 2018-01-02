require 'spec_helper'

describe Image do
  def image
    @image ||= described_class.new(2, 3)
  end

  def subject
    image.image
  end

  describe 'initialize' do
    it 'returns exception when size is too big'

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
    it 'returns exception when no image exists'

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
    it 'returns exception when colour doesnt exist'
    it 'returns exception when coordinates arre out of bounds'
    it 'paints given point with given colour' do
      image.colour(1, 1, 'A')
      expect(subject[0][0]).to eq 'A'
    end
  end

  describe 'vertical' do
    it 'returns expception when line is out of bounds'
    it 'paints given line coordinates with given colour' do
      image.vertical(1, 1, 2, 'A')
      expect(subject[0][0]).to eq 'A'
      expect(subject[1][0]).to eq 'A'
    end
  end

  describe 'horizontal' do
    it 'returns expception when line is out of bounds'
    it 'paints given line coordinates with given colour' do
      image.horizontal(1, 2, 1, 'A')
      expect(subject[0][0]).to eq 'A'
      expect(subject[0][1]).to eq 'A'
    end
  end
end
