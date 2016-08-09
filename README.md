# Spintax

A small script in ruby which allows to spin text with simple syntax.

###Example

The phrase `"I really like to {be inside and {play computer|read a book|watch tv}|be outside {and|where I like to} {play football|take a walk|catch pokemon}"` will be converted to this output

    I really like to be inside and play computer
    I really like to be inside and read a book
    I really like to be inside and watch tv
    I really like to be outside where I like to play football
    I really like to be outside where I like to take a walk
    I really like to be outside where I like to catch pokemon
    I really like to be outside and play football
    I really like to be outside and take a walk
    I really like to be outside and catch pokemon

## Installation and usage

Go to project directory

    cd spintax

Install dependencies

    bundle install

Put your spintax text in `data/input.txt`

Run it with ruby

spintax.rb

Have a result in `data/output.txt`
