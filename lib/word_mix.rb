require "word_mix/version"
module WordMix
  
  @root = File.expand_path('../..',__FILE__)

  if defined?(Rails)
    require "word_mix/railtie"
  end

  def self.start(file=nil, separator=nil, case_insensitive=nil)
    @root = Rails.root.to_s if defined?(Rails)
    @case_insensitive = case_insensitive
    start = Time.now
    
    separator = separator ? separator : "\n\n\n"
    data = build_list(file_path(file), separator)
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
  def self.build_list(file, separator)
    data = set_data
    
    list = File.read(file).split(separator)
    list.each do |word|
      case word.size
        when 1 
          data[1] << word
        when 2
          data[2] << word
        when 3
          data[3] << word
        when 4
          data[4] << word
        when 5
          data[5] << word
        when 6
          data[6] << word
      end
    end
    data
  end
  
  # Loop trough 6 letters word to find a match
  def self.mix_words(data)
    @result = []
    data[6].each do |word|
      populate_result(word[0..0], word[1..5], data[1], data[5])
      populate_result(word[0..1], word[2..5], data[2], data[4])
      populate_result(word[0..2], word[3..5], data[3], data[3])
      populate_result(word[0..3], word[4..5], data[4], data[2])
      populate_result(word[0..4], word[5..5], data[5], data[1])
    end
    @result   
  end
  
  def self.populate_result(first, second, match_one, match_two)
    word = first + second
    if @case_insensitive
      if match_one.any?{ |s| s.downcase == first.downcase } and match_two.any?{ |s| s.downcase == second.downcase }
        match_one.any?{ |s| s.downcase == first.downcase ? first = s : nil} and match_two.any?{ |s| s.downcase == second.downcase ? second = s : nil}
        @result << "#{first} + #{second} => #{word}\n\n\n"
      end
    else  
      if match_one.include? first and match_two.include? second
        @result << "#{first} + #{second} => #{word}\n\n\n"
      end
    end  
  end
  
  # Build an array for each word length
  def self.set_data(data=[])
    (1..6).each do |size|
      data[size] = []
    end
    data
  end  
private_class_method :build_list, :mix_words, :populate_result, :set_data
end  