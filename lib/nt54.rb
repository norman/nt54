require "logger"
require "csv"
require "pathname"
require "pp"
require "ambry"
require "micromachine"
require "nt54/phone_number"
require "nt54/parser"
require "nt54/province"
require "nt54/area"
require "nt54/special_number"

module NT54
  extend self
  attr_accessor :log
end
