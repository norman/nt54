module NT54
  class Area
    extend Ambry::Model
    field :code, :city, :province_code, :comment, :lat, :lng

    def province
      Province.get(province_code)
    end
  end

  CSV.foreach(Pathname(__FILE__).dirname.join("areas.csv"))  do |row|
    Area.create Hash[[:code, :city, :province_code, :comment].zip(row)]
  end

end
