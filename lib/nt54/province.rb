module NT54
  class Province
    extend Ambry::Model
    field :code, :name

    def areas
      Area.find {|x| x.province_code == code}
    end
  end

  CSV.foreach(Pathname(__FILE__).dirname.join("provinces.csv"))  do |row|
    Province.create Hash[[:code, :name].zip(row)]
  end
end
