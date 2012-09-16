# WORD_MIX

PLEASE WATCH WORD_MIX-0.0.7 FOR THE TEST (see details in NOTES...)

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

Replace word_mix in every rails app files
  
    rake word_mix:convert

Specify a single file path ( default = Rails.root + "/wordlist.txt"):
    
    rake word_mix:convert TARGET="/complete/path/to/file"
    
Specify a custom amount of letter (default = 6):

    rake word_mix:convert AMOUNT=6

Specify separator to use a custom splitting pattern ( default = "\n\" ):

    rake word_mix:convert SEPARATOR="\n"
    
Specify case_insensitive:

    rake word_mix:convert CASE_INSENSITIVE="true"

You can pass more than one option

## NOTES
  
VERSION 0.0.7 ... 
  
    KATA release after 2:30 h



I saw an unexpected amount of download so I'm tuning the gem a bit :D
  
VERSION 0.0.8 ...
  
    new AMOUNT feature
  
VERSION 0.0.9

    optimize the code by using hash instead of array
    fix test  
  
VERSION 0.1.0
 
    remove unused file and add correction to README.md
    
VERSION 1.1.0

    refactor + add exception     
  
  
You could experiment permission issue if not used properly
 
Go see hash_rocket gem to see more flexibility using regex:
https://github.com/4nkh/hash_rocket