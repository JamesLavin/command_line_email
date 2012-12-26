require "spec_helper"

describe "calling command_line_email" do

  before do
    $stdout = StringIO.new # suppress command line output
  end

  context "when config file not present" do

    before do
      CommandLineEmail::SendEmailSetup.any_instance.stub(:config_file_exists?).and_return(false)
    end

    it "should raise ConfigFileNotFound" do
      expect { require "command_line_email" }.to raise_error(CommandLineEmail::SendEmailSetup::ConfigFileNotFound)
    end

  end

  context "when config file present" do

    before do
      CommandLineEmail::SendEmailSetup.any_instance.stub(:config_file_exists?).and_return(true)
    end

    it "should not raise ConfigFileNotFound" do
      expect { require "command_line_email" }.to_not raise_error(CommandLineEmail::SendEmailSetup::ConfigFileNotFound)
    end

  end

end

describe "other stuff" do

  include FakeFS::SpecHelpers

end
