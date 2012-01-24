# NT54

Parsing, validation, meta-information and formatting for Argentine phone
numbers.

## Usage

    require "nt54"

    # Parsing
    number = NT54::Parser.parse("0291-15-555-4444")
    number.area_code # => "291"
    number.local_prefix # => "555"
    number.local_number # => "4444"
    number.country_code # => "54"
    number.mobile? # => true

    # Validation
    number = NT54::Parser.parse("0291-15-555-4444")
    number.valid? # => true
    NT54::Parser.valid?("0291-15-555-4444") # => true
    NT54::Parser.valid?("03864-22-4444") # => false (there's no 3864 area code)

    # Meta-information
    number.area.city # => "Bahía Blanca"
    number.area.province.code # => "B"
    number.area.province.name # => "Buenos Aires"
    number.area.lat # => "-38.71167760000001"
    number.area.lng # => "-62.26807789999999"

    # Formatting
    number.format_international # => "+54 9 (291) 555-4444"
    number.format_international_sms # => "+54 (291) 555-4444"
    number.format_national # => "(0291) 15 555-4444"
    number.format_local # => "15 555-4444"

    # Special number handling
    number = NT54::Parser.parse("100")
    number.special? # => true
    number.special.comment # => "Bomberos"
    number.special.comment_en # => "Fire department"

## More info

Simple phone number formats like the one used for North America can be somewhat
easily described with regular expressions, but Argentina's phone numbers are
quite complex. For example, area codes can be 2-4 numbers long and can overlap.
A prefix is used to denote mobile verse non-mobile numbers, and this prefix
changes number and position when dialing internationally. The prefix must be
used when calling internationally, but not when sending SMS internationally.

This means that Argentine phone numbers are best captured with a grammar, rather
than regular expressions, so NT54 uses a finite state machine to process the
number like a real hardware or software dialer.

If you're curious, you can debug the phone number processing like this:

    ruby -rnt54 -e 'NT54::Parser.debug("02914445555")'

    D, [2012-01-24T15:29:00.993893 #10077] DEBUG -- : new state: Dialtone
    D, [2012-01-24T15:29:00.994076 #10077] DEBUG -- : got 0
    D, [2012-01-24T15:29:00.994209 #10077] DEBUG -- : triggering area_code_indicated
    D, [2012-01-24T15:29:00.994272 #10077] DEBUG -- : new state: WaitForAreaCode
    D, [2012-01-24T15:29:00.994320 #10077] DEBUG -- : got 2
    D, [2012-01-24T15:29:00.994352 #10077] DEBUG -- : got 9
    D, [2012-01-24T15:29:00.994660 #10077] DEBUG -- : got 1
    D, [2012-01-24T15:29:00.994738 #10077] DEBUG -- : triggering area_code_potentially_completed
    D, [2012-01-24T15:29:00.994804 #10077] DEBUG -- : new state: WaitForAreaCodeCompletion
    D, [2012-01-24T15:29:00.994871 #10077] DEBUG -- : got 1
    D, [2012-01-24T15:29:00.994910 #10077] DEBUG -- : 291 is a valid area code
    D, [2012-01-24T15:29:00.994951 #10077] DEBUG -- : triggering mobile_prefix_started
    D, [2012-01-24T15:29:00.994999 #10077] DEBUG -- : new state: WaitForMobilePrefixCompletion
    D, [2012-01-24T15:29:00.995040 #10077] DEBUG -- : got 5
    D, [2012-01-24T15:29:00.995071 #10077] DEBUG -- : triggering mobile_prefix_completed
    D, [2012-01-24T15:29:00.995120 #10077] DEBUG -- : new state: WaitForLocalPrefix
    D, [2012-01-24T15:29:00.995150 #10077] DEBUG -- : got 4
    D, [2012-01-24T15:29:00.995213 #10077] DEBUG -- : got 4
    D, [2012-01-24T15:29:00.995247 #10077] DEBUG -- : got 4
    D, [2012-01-24T15:29:00.995281 #10077] DEBUG -- : got 5
    D, [2012-01-24T15:29:00.995329 #10077] DEBUG -- : triggering local_prefix_completed
    D, [2012-01-24T15:29:00.995371 #10077] DEBUG -- : new state: WaitForLocalNumber
    D, [2012-01-24T15:29:00.995413 #10077] DEBUG -- : got 5
    D, [2012-01-24T15:29:00.995441 #10077] DEBUG -- : got 5
    D, [2012-01-24T15:29:00.997847 #10077] DEBUG -- : got 5
    #<NT54::PhoneNumber:0x007f8e91058120
     @area_code="291",
     @country_code="54",
     @local_number="5555",
     @local_prefix="444",
     @mobile=true>

## Installation

    gem install nt54

## Author

[Norman Clarke](mailto:norman@njclarke.com)

## Changelog

* 2012-01-24 - Initial release

## License

Copyright (c) 2012 Norman Clarke

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
