class Class
  def attr_accessor_custom(attr_name)
    self.class_eval %Q(
    
    def #{attr_name};
      @#{attr_name};
    end
    
    ) 
    self.class_eval %Q(
    
    def #{attr_name}=(value);
      @#{attr_name}=value;
    end
    
    ) 
  end
end

class Example
  attr_accessor_custom :foo
end

a = Example.new;
a.foo = 2; 
puts a.foo # => 2
