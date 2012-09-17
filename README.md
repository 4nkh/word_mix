# WORD_MIX

combine 2 small word to get a word of (N) characters: 
    
    al + bums => albums
  
## Installation

Add this line to your application's Gemfile:

    gem 'word_mix'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_mix

## Usage

Rake task:
  
    rake word_mix:convert

Specify a single file path ( default = Rails.root + "/wordlist.txt"):
    
    rake word_mix:convert TARGET="/complete/path/to/file"
    
Specify a custom amount of letter (default = 6):

    rake word_mix:convert AMOUNT=6

Specify separator to use a custom splitting pattern ( default = "\n" ):

    rake word_mix:convert SEPARATOR="\n"
    
Specify case_insensitive:

    rake word_mix:convert CASE_INSENSITIVE="true"

You can pass more than one option

## NOTES
   
  
You could experiment permission issue if not used properly
 
Go see hash_rocket gem to see more flexibility using regex:
https://github.com/4nkh/hash_rocket