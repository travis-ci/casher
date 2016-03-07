load File.join(File.dirname(__FILE__), '..', 'bin', 'casher')

describe Casher do
  let(:tbz_url) { 'https://example.com/afdfad/master/cache--rvm-default--gemfile-Gemfile.tbz?param1=value1&param2=value2' }
  let(:tgz_url) { 'https://example.com/afdfad/master/cache--rvm-default--gemfile-Gemfile.tgz?param1=value1&param2=value2' }
  subject { described_class.new() }

  describe '#run' do
    it 'calls "curl" to download archives' do
      expect(subject).to     receive(:subprocess).with(a_collection_starting_with('curl').and(end_with(tgz_url)), anything, anything).and_return(true)
      expect(subject).not_to receive(:subprocess).with(a_collection_ending_with(tbz_url), anything, anything)
      subject.run('fetch', tgz_url, tbz_url)
    end
  end

  context 'when the first archive is not available' do
    before :each do
      expect(subject).to receive(:subprocess).with(a_collection_ending_with(tgz_url), anything, anything).and_return(false)
    end

    it 'falls back to the next archive' do
      expect(subject).to receive(:subprocess).with(a_collection_ending_with(tbz_url), anything, anything)
      subject.run('fetch', tgz_url, tbz_url)
    end
  end
end
