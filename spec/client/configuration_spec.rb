require "spec_helper"

describe Conekticut do
  before(:each) { @client_class = Class.new(Conekticut::Client::Base) }

  describe ".configure" do
    it "proxies to Client configuration" do
      Conekticut::Client::Base.add_config_option(:test_config)

      Conekticut.configure do |c|
        c.test_config = "foo"
      end

      Conekticut::Client::Base.test_config.should == "foo"
    end
  end
end

describe Conekticut::Client::Base do
  before(:each) { @client_class = Class.new(Conekticut::Client::Base) }

  describe ".add_config_option" do
    it "creates a class level accessor" do
      @client_class.add_config_option :some_class_level_accessor
      @client_class.some_class_level_accessor = "bar"
      @client_class.some_class_level_accessor.should == "bar"
    end

    context "assigning a proc to a accessor" do
      before(:each) do
        @client_class.add_config_option :foo_bar
        @client_class.foo_bar = the_proc
      end

      context "when the proc does not accept args" do
        let(:the_proc) { proc { "return arg" } }

        it "calls the proc with no arguments" do
          @client_class.new.foo_bar.should == "return arg"
        end
      end

      context "when the proc accepts args" do
        let(:the_proc) { proc {|arg| arg.should be_an_instance_of(@client_class) } }

        it "calls the proc with arguments" do
          @client_class.foo_bar
        end
      end
    end
  end
end
