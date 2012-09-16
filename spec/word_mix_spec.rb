require 'spec_helper'

describe WordMix do

  let(:test_path) { File.expand_path('../..',__FILE__) + "/spec/data/"}
  let(:stub_path) { test_path + "/stub.txt" }
  let(:stub_answer) { test_path + "/stub_answer.txt" }
  
  context "method start should " do

    before(:each) do
      @build_answer = File.expand_path('../..',__FILE__) + "/answer.txt"
      system "rm #{@build_answer}"    
    end
    
    it "build empty file" do
      WordMix.start(test_path + "/no_match.txt")
      content = File.read(@build_answer)
      content.should == "\n"
    end

    it "use custom separator" do
      WordMix.start(test_path + "/separator.txt", nil, ",")
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/separator_answer.txt")
    end

    it "build a file named answer.txt" do
      WordMix.start(test_path + "/stub.txt")
      content = File.read(@build_answer)
      content.should == File.read(stub_answer)
    end 

    it "detect case insensitive when specified" do
      WordMix.start(test_path + "/case_insensitive.txt", nil, nil, true)
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/case_insensitive_answer.txt")
    end
    
    it "detect custom amount" do
      WordMix.start(test_path + "/amount.txt", 4)
      content = File.read(@build_answer)
      content.should == File.read(test_path + "/amount_answer.txt")
    end
    
    it "use the 6 letters word only one time" do
      WordMix.start(test_path + "/stub.txt")
      content = File.read(@build_answer)
      list = content.split("\n")
      list.size.should == 8
    end
  end
  
  context "method file_path should" do

    it "return the default path if nil" do
      path = WordMix.file_path(nil)
      path.should == File.expand_path('../..',__FILE__) + "/wordlist.txt"     
    end

    it "the given path when it's specified" do
      path = WordMix.file_path("/test")
      path.should == "/test"
    end
  
  end

end
