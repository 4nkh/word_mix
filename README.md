# WORD_MIX

combine small word to get a word of six characters -> 

    al + bums => albums
  
## Installation

Add this line to your application's Gemfile:

    gem 'word_mix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_mix

## Usage

Replace word_mix in every rails app files
  
    rake word_mix:convert

Specify a single file path:
    
    rake word_mix:convert TARGET="/complete/path/to/file"

Specify separator to use a custom splitting pattern (default = "\n\n\n"):

    rake word_mix:convert SEPARATOR="\n"
    
Specify case_insensitive:

    rake word_mix:convert CASE_INSENSITIVE="true"

You can pass more than one option

## NOTE
  
  You can experiment permission issue if not used properly
 
  Go see hash_rocket gem to see more gem flexibility
  https://github.com/4nkh/hash_rocket