require 'spec_helper'

describe WordMix do

  let(:test_path) { File.expand_path('../..',__FILE__) + "/spec/data/"}
  let(:stub_path) { test_path + "/stub.txt" }
  let(:stub_answer) { test_path + "/stub_answer.txt" }
  
  context "should " do

    before(:each) do
      ENV["TARGET"] = test_path + example.metadata[:target]
      ENV["AMOUNT"] = example.metadata[:amount]
      ENV["SEPARATOR"] = example.metadata[:separator]
      ENV["CASE_INSENSITIVE"] = example.metadata[:case_insensitive]
      @build_answer = File.expand_path('../..',__FILE__) + "/answer.txt"
      system "rm #{@build_answer}"    
    end
    
    it "build empty file", target: "/no_match.txt" do
      WordMix.init
      content = File.read(@build_answer)
      content.should == "\n"
    end

    it "use custom separator", target: "/separator.txt", separator: "," do
      WordMix.init
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/separator_answer.txt")
    end

    it "build a file named answer.txt", target: "/stub.txt" do
      WordMix.init
      content = File.read(@build_answer)
      content.should == File.read(stub_answer)
    end 

    it "detect case insensitive when specified", target: "/case_insensitive.txt", case_insensitive: "true" do
      WordMix.init
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/case_insensitive_answer.txt")
    end
    
    it "detect custom amount", target: "/amount.txt", amount: "4" do
      WordMix.init
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/amount_answer.txt")
    end
    
    it "use the 6 letters word only one time", target: "/stub.txt" do
      WordMix.init
      content = File.read(@build_answer)
      list = content.split("\n")
      list.size.should == 8
    end
    
  end

end
