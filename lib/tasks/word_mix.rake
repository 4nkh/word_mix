namespace "word_mix" do
  desc "combine 2 small word to get a 6 letters word"
  task convert: :environment do
    WordMix.start(ENV["TARGET"], ENV["SEPARATOR"] || "\n\n\n", ENV["CASE_INSENSITIVE"])  
  end
end
