load File.join(File.dirname(__FILE__), '..', 'bin', 'casher.rb')

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

  context 'when the curl call times out' do
    before :each do
      expect(subject).to receive(:system).with(/curl\b.*#{tgz_url.gsub('?','\?')}/m).and_raise(TimeoutError)
    end

    it 'cleans up the fetch_tar' do
      expect(subject).to receive(:cleanup_cache)
      subject.run('fetch', tgz_url)
    end

  end
end
