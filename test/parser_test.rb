require File.expand_path("../helper", __FILE__)

module NT54
  class ParserTest < MiniTest::Unit::TestCase

    parsing_tests = {
      "+54-11-4781-8888"    => ["11", "4781", "8888", false, true],
      "0-11-4781-8888"      => ["11", "4781", "8888", false, true],
      "11-4781-8888"        => ["11", "4781", "8888", false, true],
      "15-6445-3333"        => ["", "6445", "3333", true, false],
      "0342-15-631-2222"    => ["342", "631", "2222", true, true],
      "0291-453-8888"       => ["291", "453", "8888", false, true],
      "+54-291-453-8888"    => ["291", "453", "8888", false, true],
      "0291-15-453-8888"    => ["291", "453", "8888", true, true],
      "+54-9-291-453-8888"  => ["291", "453", "8888", true, true],
      "0-11-15-4430-3333"   => ["11", "4430", "3333", true, true],
      "0810-444-4444"       => ["810", "444", "4444", false, true],
      "0 (221) 15 123-4567" => ["221", "123", "4567", true, true],
      "0 (3722) 15 12-3456" => ["3722", "12", "3456", true, true],
      "0387-431-9999"       => ["387", "431", "9999", false, true],
      "03868-42-6666"       => ["3868", "42", "6666", false, true],
      "0387-154-106666"     => ["387", "410", "6666", true, true],
      "03873-424444"        => ["3873", "42", "4444", false, true],
      "03488-218888"        => ["3488", "21", "8888", false, true],
      "03488-15-218888"     => ["3488", "21", "8888", true, true],
      "02965-422222"        => ["296", "542", "2222", false, false],
      "+54 15-5310-7777"    => ["", "5310", "7777", true, false]
    }

    parsing_tests.each do |given, expected|
      class_eval(<<-END, __FILE__, __LINE__+1)
        def test_#{given.gsub(/[^0-9]/, "")}
          number = Parser.parse("#{given}")
          assert_equal "#{expected[0]}", number.area_code,    "Bad area code"
          assert_equal "#{expected[1]}", number.local_prefix, "Bad local prefix"
          assert_equal "#{expected[2]}", number.local_number, "Bad local number"
          assert_equal  #{expected[3]},  number.mobile?,      "Bad mobile detection"
          assert_equal  #{expected[4]},  number.valid?,       "Bad validity check"
        end
      END
    end

    def test_non_argentine_numbers_should_be_invalid
      assert !Parser.valid?("+1-206-444-5555")
    end

    def test_incomplete_numbers_should_be_invalid
      assert !Parser.valid?("+54")
    end

    def test_numbers_with_unknown_area_codes_should_be_invalid
      assert  Parser.valid?("03861-22-4444")
      # There's no "3864" area code
      assert !Parser.valid?("03864-22-4444")
    end
  end
end