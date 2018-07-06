require 'byebug'
class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |name|
      sym = name.to_sym
      define_method(sym) do
        instance_variable_get("@#{name}")
      end
      
      var = "#{name}=".to_sym
      define_method(var) do |value|
        instance_variable_set("@#{name}", value)
      end
    end 
    
  end
end
