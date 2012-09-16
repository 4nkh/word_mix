require "word_mix/version"
module WordMix
  
  @root = File.expand_path('../..',__FILE__)

  if defined?(Rails)
    require "word_mix/railtie"
  end

  def self.start(file=nil, amount=nil, separator=nil, case_insensitive=nil)
    start = Time.now
    
    data = set_variables(amount, separator, case_insensitive)
    data = build_list(file_path(file), data)
    mix_words(data)
    File.open(@root + "/answer.txt", "w") { |file| file.puts @result.join }
    puts "#{@result.size} results found"
    puts "It took only #{Time.now - start} seconds to complete the process"   
  end  

  # Set the default file path if no variable is provided
  def self.file_path(file)
    file ? file : @root + "/wordlist.txt" 
  end
  
private

  # Replace word by length
  # It can probably be faster
  def self.build_list(file, data)
    list = File.read(file).split(@separator)
    list.uniq.each do |word|
      data[word.size] << word if word.size < @amount and word.size != 0
      data[@amount] << word if word.size == @amount
    end
    data
  end
  
  # Loop trough 6 letters word to find a match
  def self.mix_words(data)
    @result = []
    data[@amount].each do |word|
      big = @amount-2
      (0..big).each do |i|
        populate_result(word[0..i], word[i+1..big+1], data[i+1], data[big+1 - i])
      end
    end
    @result   
  end
  
  def self.populate_result(first, second, match_one, match_two)
    word = first + second
    if @case_insensitive
      if match_one.any?{ |s| s.downcase == first.downcase } and match_two.any?{ |s| s.downcase == second.downcase }
        match_one.any?{ |s| s.downcase == first.downcase ? first = s : nil} and match_two.any?{ |s| s.downcase == second.downcase ? second = s : nil}
        @result << "#{first} + #{second} => #{word}\n"
      end
    else  
      # puts match_one
      # puts match_two
      if match_one.include? first and match_two.include? second
        @result << "#{first} + #{second} => #{word}\n"
      end
    end  
  end
  
  # Build an array for each word length
  def self.set_data(data=[])
    (1..@amount).each do |size|
      data[size] = []
    end
    data
  end
  
  # Set global variables and return array of arrays
  def self.set_variables(amount, separator, case_insensitive)
    @root = Rails.root.to_s if defined?(Rails)
    @case_insensitive = case_insensitive
    @amount = amount ? amount.to_i : 6
    @separator = separator ? separator : "\n"
    data = set_data
  end
   
private_class_method :build_list, :mix_words, :populate_result, :set_data, :set_variables
end
