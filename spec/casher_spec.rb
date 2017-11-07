load File.join(File.dirname(__FILE__), '..', 'bin', 'casher')

require 'tmpdir'

describe Casher do
  let(:tbz_url) { 'https://example.com/afdfad/master/cache--rvm-default--gemfile-Gemfile.tbz?param1=value1&param2=value2' }
  let(:tgz_url) { 'https://example.com/afdfad/master/cache--rvm-default--gemfile-Gemfile.tgz?param1=value1&param2=value2' }
  subject { described_class.new() }

  describe '#run' do
    it 'calls "curl" to download archives' do
      expect(subject).to     receive(:system).with(/curl\b.*#{tgz_url.gsub('?','\?')}/m).and_return(true)
      expect(subject).not_to receive(:system).with(/curl\b.*#{tbz_url.gsub('?','\?')}/m)
      subject.run('fetch', tgz_url, tbz_url)
    end
  end

  context 'when the first archive is not available' do
    before :each do
      expect(subject).to receive(:system).with(/curl\b.*#{tgz_url.gsub('?','\?')}/m).and_return(false)
    end

    it 'falls back to the next archive' do
      expect(subject).to receive(:system).with(/curl\b.*#{tbz_url.gsub('?','\?')}/m)
      subject.run('fetch', tgz_url, tbz_url)
    end
  end

  describe '#tar' do
    it 'creates and extracts tar files' do
      Dir.mktmpdir do |dir|
        Dir.chdir dir do
          Dir.mkdir 'tar-input'
          File.write('tar-input/file.txt', 'file contents')
          out, errs = subject.tar(:c, 'archive.tbz', 'tar-input') do
            sleep 1
          end
          expect(errs).to eq ('')
          File.delete('tar-input/file.txt')
          Dir.delete('tar-input')
          out, errs = subject.tar(:x, 'archive.tbz', 'tar-input') do
            sleep 1
          end
          expect(errs).to eq ('')
          expect(File.read 'tar-input/file.txt').to eq('file contents')
        end
      end
    end
  end
end
