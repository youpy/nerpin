# Nerpin [![Ruby](https://github.com/youpy/nerpin/actions/workflows/ruby.yml/badge.svg)](https://github.com/youpy/nerpin/actions/workflows/ruby.yml)

A Ruby library to send manufacturer-specific or instrument-specific MIDI messages

## Supported Instruments

* [Alesis micron](http://www.alesis.com/micron)
* [Alesis ion](http://www.alesis.com/ion) (not tested)
* [Akai MINIAK](http://www.akaipro.com/miniak) (not tested)

## Installation

Add this line to your application's Gemfile:

    gem 'nerpin'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nerpin

## Usage

```ruby
require 'coremidi'
require 'nerpin'

destination = CoreMIDI::Destination.first
micron = Nerpin::Micron(destination)

micron.oscillator_1_octave(3)
```

## See Also

* [Alesis Ion, Micron and Akai Miniak Synth Wiki - Common FAQ](http://ion-micron-miniak.wikia.com/wiki/Common_FAQ)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
