module NT54
  class PhoneNumber

    attr_accessor :country_code, :area_code, :local_prefix, :local_number,
      :city, :province_code, :mobile, :special_sequence, :special

    def initialize
      [:country_code, :area_code, :local_prefix, :local_number, :special_sequence].each do |var|
        instance_variable_set :"@#{var}", ""
      end
    end

    def area
      @area ||= Area.get(area_code)
    rescue Ambry::NotFoundError
    end

    def mobile?
      !! mobile
    end

    def special
      @special ||= SpecialNumber.get(special_sequence)
    rescue Ambry::NotFoundError
    end

    def special?
      !! special
    end

    def format_international
      "+#{country_code} #{mobile? ? 9 : ''} (#{area_code}) #{local_prefix}-#{local_number}".squeeze(' ')
    end

    def format_international_sms
      "+#{country_code} (#{area_code}) #{local_prefix}-#{local_number}"
    end

    def format_national
      "(0#{area_code}) #{mobile? ? 15 : ''} #{local_prefix}-#{local_number}".squeeze(' ')
    end

    def format_local
      "#{mobile? ? 15 : ''} #{local_prefix}-#{local_number}".squeeze(' ')
    end

    def real_length
      area_code.length + local_prefix.length + local_number.length + special_sequence.length
    end

    def valid?
      if special? && real_length == 3
        return true
      end
      return false unless area_code
      return false unless area
      return false unless local_prefix.length >= 2
      return false unless local_number.length >= 3
      return false unless real_length == 10
      true
    end

    def fix!
      if real_length == 3 && special_sequence == ""
        @special_sequence = "#{area_code}#{local_prefix}"
        @area_code = ""
        @local_prefix = ""
        return self
      end

      @country_code = "54" if @country_code == ""
      # If we didn't dial an area code, then we don't really know how long the
      # prefix/local numbers are, so fake it.
      unless area_code
        until @local_number.length >= @local_prefix.length
          @local_number.insert(0, @local_prefix.slice!(-1))
        end
      end
      self
    end

  end
end