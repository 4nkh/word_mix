require "word_mix"

module WordMix 
  if defined? Rails::Railtie
    require "rails"
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/word_mix.rake"
      end
    end
  end
end
