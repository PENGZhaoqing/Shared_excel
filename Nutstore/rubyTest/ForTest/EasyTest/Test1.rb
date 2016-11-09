class Class
  def attr_accessor_custom(attr_name)
    attr_reader attr_name
    attr_writer attr_name
  end
end

class Example
  attr_accessor_custom :foo
end


a = Example.new;
a.foo = 2; 
puts a.foo # => 2

# a.class # => Example
# Example.class # => Class
# Example.attr_accessor_custom(:attr) # => nil
