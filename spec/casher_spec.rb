load File.join(File.dirname(__FILE__), '..', 'bin', 'casher')

describe Casher do
  let(:tbz_url) { 'master/cache--rvm-default--gemfile-Gemfile.tbz' }
  let(:tgz_url) { 'master/cache--rvm-default--gemfile-Gemfile.tgz' }
  subject { described_class.new() }

  describe '#run' do
    it 'calls "curl" to download .tbz archive' do
      expect(subject).to receive(:system).with(/curl\b.*#{tbz_url}\b/m)
      subject.run('fetch', tbz_url)
    end
  end
end
