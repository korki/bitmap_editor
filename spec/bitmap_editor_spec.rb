require 'spec_helper'

describe BitmapEditor do
  describe 'command interpreter' do
    it 'return message when invalid command' do
      expect(STDOUT).to receive(:puts).with('unrecognised command :(')
      described_class.new.interpret_command('test', nil)
    end

    it 'initializes new image when I' do
      editor = described_class.new
      expect(editor.image).to be_nil
      editor.interpret_command('I', ['I', 1, 1])
      expect(editor.image).to be_instance_of(Image)
    end

    context 'with initialized image' do
      let(:editor) { described_class.new }

      before do
        editor.image = Image.new(1, 1)
      end

      it 'calls clear when C' do
        expect(editor.image).to receive(:clear)
        editor.interpret_command('C', nil)
      end

      it 'it call colour when L' do
        expect(editor.image).to receive(:colour)
        editor.interpret_command('L', ['L', 1, 1, 'A'])
      end

      it 'it call vertical when V' do
        expect(editor.image).to receive(:vertical)
        editor.interpret_command('V', ['V', 1, 1, 1, 'A'])
      end

      it 'it call horizontal when V' do
        expect(editor.image).to receive(:horizontal)
        editor.interpret_command('H', ['H', 1, 1, 1, 'A'])
      end
    end
  end
end
