class User < ApplicationRecord

  has_many :bookings

  def self.define_method
    response = ""
    str1 = "abcd".split("")
    str2 = "bccd".split("")
    if !(str1.size == str2.size)
        response = "no"
    else
        str2.each do |b|
            if (str1.include? (b))
                str1.delete_at(str1.find_index(b))
            end
        end
         str1.blank? ? response = "yes" : response = "no"
    end
    puts response
  end

end
