module NT54
  class SpecialNumber
    extend Ambry::Model
    field :sequence, :comment, :comment_en
  end

  CSV.foreach(Pathname(__FILE__).dirname.join("special_numbers.csv"))  do |row|
    SpecialNumber.create Hash[[:sequence, :comment, :comment_en].zip(row)]
  end
end