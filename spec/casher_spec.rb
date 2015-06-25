load File.join(File.dirname(__FILE__), '..', 'bin', 'casher')

describe Casher do
  let(:tbz_url) { 'master/cache--rvm-default--gemfile-Gemfile.tbz' }
  let(:tgz_url) { 'master/cache--rvm-default--gemfile-Gemfile.tgz' }
  subject { described_class.new() }

  describe '#run' do
    it 'calls "curl" to download .tbz archive' do
      expect(subject).to receive(:system).with(/curl\b.*#{tgz_url}\b/m).and_return(true)
      subject.run('fetch', tbz_url)
    end
  end

  context 'when .gz archive is not available' do
    before :each do
      expect(subject).to receive(:system).with(/curl\b.*#{tgz_url}\b/m).and_return(false)
    end

    it 'falls back to .bz2' do
      expect(subject).to receive(:system).with(/curl\b.*#{tbz_url}\b/m)
      subject.run('fetch', tbz_url)
    end
  end
end
