require "nt54/parser/machinery"
require "nt54/parser/visitor"

module NT54

  class Parser
    include Machinery

    attr_reader :number

    trigger :country_code_indicated
    transition :Dialtone, :WaitForCountryCodeStart

    trigger :mobile_prefix_or_area_code_started
    transition :Dialtone, :WaitForAreaCodeOrMobilePrefixCompletion

    trigger :country_code_started
    transition :WaitForCountryCodeStart, :WaitForCountryCodeEnd

    trigger :area_code_indicated
    transition :Dialtone, :WaitForAreaCode

    trigger :country_code_completed
    transition :WaitForCountryCodeEnd, :WaitForMobilePrefixOrAreaCode

    trigger :mobile_prefix_or_area_code_indicated
    transition :WaitForMobilePrefixOrAreaCode, :WaitForAreaCodeOrMobilePrefixCompletion

    trigger :mobile_prefix_started
    transition :WaitForPrefix, :WaitForMobilePrefixCompletion
    transition :WaitForMobilePrefixOrAreaCode, :WaitForAreaCode
    transition :WaitForAreaCodeCompletion, :WaitForMobilePrefixCompletion
    transition :Dialtone, :WaitForMobilePrefixCompletion

    trigger :area_code_completed
    transition :WaitForAreaCodeOrMobilePrefixCompletion, :WaitForLocalPrefix
    transition :WaitForAreaCodeCompletion, :WaitForPrefix
    transition :WaitForAreaCode, :WaitForPrefix

    trigger :area_code_potentially_completed
    transition :WaitForAreaCode, :WaitForAreaCodeCompletion

    trigger :mobile_prefix_completed
    transition :WaitForAreaCodeOrMobilePrefixCompletion, :WaitForLocalPrefix
    transition :WaitForMobilePrefixCompletion, :WaitForLocalPrefix

    trigger :local_prefix_started
    transition :Dialtone, :WaitForLocalPrefix
    transition :WaitForPrefix, :WaitForLocalPrefix

    trigger :area_code_started
    transition :WaitForMobilePrefixOrAreaCode, :WaitForAreaCode
    transition :WaitForPrefix, :WaitForAreaCode

    trigger :local_prefix_completed
    transition :WaitForLocalPrefix, :WaitForLocalNumber

    trigger :special_number_started
    transition :Dialtone, :WaitForSpecialNumberCompletion
    transition :WaitForAreaCodeOrMobilePrefixCompletion, :WaitForSpecialNumberCompletion

    def self.parse(sequence)
      parser = new
      sequence = sequence.to_s.gsub(/[^0-9+]/, '')
      sequence.split("").map {|x| parser.dial(x)}
      parser.number.fix!
    end

    def self.debug(sequence)
      NT54.log       = Logger.new(STDOUT)
      NT54.log.level = Logger::DEBUG
      pp parse(sequence)
    end

    def self.valid?(sequence)
      number = parse(sequence)
      number.valid?
    rescue RuntimeError
      false
    end

    def initialize
      @number  = PhoneNumber.new
      @visitor = Parser::Visitors::Dialtone.new(@number)
    end

    def dial(keypress)
      respond_to @visitor.accept(keypress)
    end
  end
end