class Class
  def attr_accessor_with_history(attr_name)
    
    attr_reader attr_name
    
    self.class_eval %Q{
      def #{attr_name}_history
        @#{attr_name}_history 
      end
    }
    
    self.class_eval %Q{
      def #{attr_name}=(new_value)
        @#{attr_name} =new_value
        @#{attr_name}_history ||= [nil] # shortcut, compare to your line
        @#{attr_name}_history << new_value
      end
    }
  end
end

class Example
  attr_accessor_with_history :foo
end

a = Example.new; a.foo = 2; a.foo = "test"; 
puts a.foo_history # => [nil, 2, "test"]

