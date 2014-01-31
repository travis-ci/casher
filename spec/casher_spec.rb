require 'fileutils'
require 'shellwords'

describe 'casher' do
  include FileUtils
  let(:tmp_dir)     { File.expand_path("../tmp", __FILE__)                             }
  let(:casher_dir)  { File.join(tmp_dir, example.full_description.gsub(/[^\w ]+/,'-')) }
  let(:stdout_file) { File.join(casher_dir, 'stdout')                                  }
  let(:stderr_file) { File.join(casher_dir, 'stderr')                                  }
  let(:binary)      { File.expand_path('../../bin/casher', __FILE__)                   }

  def _(arg)
    Array === arg ? Shellwords.join(arg) : Shellwords.escape(arg)
  end

  def stdout
    File.read(stdout_file)
  end

  def stderr
    File.read(stderr_file)
  end

  def casher(*args)
    system("CASHER_DIR=#{_ casher_dir} #{_ binary} #{_ args} >#{_ stdout_file} 2>#{_ stderr_file}")
    $?
  end

  before :all do
    # server = File.expand_path('../../bin/casher-server', __FILE__)
    # Thread.new { system(server) }
  end

  before :each do
    rm_rf(casher_dir)
    mkdir_p(casher_dir)
  end

  after :each do
    rm_rf(casher_dir) unless example.exception
  end

  after :all do
    rmdir(tmp_dir)
  end

  specify "new file" do
    File.write("test", "test")
    casher("add", "test").should be_success
  end
end
