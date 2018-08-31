class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    str_num = "0"
    self.each do |el|
      str_num += el.to_s
    end 
    str_num.to_i.hash
  end
end

class String
  def hash
    str_num = ""
    self.chars.each do |letter|
      str_num += letter.ord.to_s
    end 
    str_num.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sorted = self.sort_by { |k, v| k }
    sorted.flatten!
    str_num = ""
    sorted.each do |el|
      if el.is_a?(Symbol)
        str_num << convert_symbol(el).to_s
      elsif el.is_a?(String)
        str_num << el.ord.to_s
      else 
        str_num << el.to_s
      end  
    end 
    str_num.to_i.hash
  end
  
  def convert_symbol(symbol)
    symbol.to_s.ord ** 2
  end 
  
end
