require "word_mix/version"
require "word_mix/railtie" if defined?(Rails)
module WordMix
  class AmountError < Exception
    def self.too_small
      puts "Amount should be higher then 1"
    end
  end 

  def self.init
    begin
      set_variables
      build_list
      mix_words
      complete
    rescue AmountError
      AmountError.too_small
    end   
  end
  
private
  
  def self.build_list
    list = File.read(@file).split(@separator)
    list.uniq.each do |word|
      @data[word.size][word] = nil if word.size < @amount and word.size != 0
      @data[@amount] << word if word.size == @amount
    end
  end
  
  def self.mix_words
    @data.last.each do |word|
      big = @amount-2
      (0..big).each do |i|
        populate_result( word[0..i], 
                         word[i+1..big+1],
                         @data[i+1],
                         @data[big+1 - i] ) unless i == @amount or (@data[i+1] == {} or !@data[big+1 - i] == {})
      end
    end   
  end
  
  def self.populate_result(first, second, match_one, match_two)
    word = first + second
    if @case_insensitive
      word_one = nil
      word_two = nil 
      match_one.any?{ |s| s[0].downcase == first.downcase ? word_one = s[0] : nil }
      match_two.any?{ |s| s[0].downcase == second.downcase ? word_two = s[0] : nil }
      @result << "#{word_one} + #{word_two} => #{word}\n" if word_one and word_two
    else
      @result << "#{first} + #{second} => #{word}\n" if match_one.has_key? first and match_two.has_key? second
    end  
  end

  def self.set_data
    (0..@amount).each do |size|
      @data << {} if size != @amount
      @data << [] if size == @amount
    end
  end

  def self.set_variables
    @start = Time.now
    @data = []
    @result = []
    @root = File.expand_path('../..',__FILE__)
    @root = Rails.root.to_s if defined?(Rails)
    @file = ENV["TARGET"] ? ENV["TARGET"] : @root + "/wordlist.txt"
    @case_insensitive = ENV["CASE_INSENSITIVE"]
    @amount = ENV["AMOUNT"] ? ENV["AMOUNT"].to_i : 6
    raise AmountError if @amount < 2
    @separator = ENV["SEPARATOR"] ? ENV["SEPARATOR"] : "\n"
    set_data
  end
  
  def self.complete
    File.open(@root + "/answer.txt", "w") { |file| file.puts @result.join }
    puts "#{@result.size} results found"
    puts "It took only #{Time.now - @start} seconds to complete the process"
  end 
private_class_method :build_list, :mix_words, :populate_result, :set_data, :set_variables, :complete
end