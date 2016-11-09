people = {
  :me => 23,
  :brother => 18,
  :sister => 25

people.sort_by do |k|
  k[1]
end
# => [[:brother, "18"], [:me, "23"], [:sister, "25"]]

# => Symbol Fixnum
# => Symbol Fixnum


people.sort_by do |k,v|
  print "#{k.class} #{v.class}\n"
end
# => Symbol Fixnum
# => Symbol Fixnum
# => Symbol Fixnum


people = {
  :me => { :name => "hen", :age => 23 },
  :brother => { :name => "abb", :age => 18 },
  :sister => { :name => "ndd", :age => 25 }
}

people.sort_by do |k,v|
  v[:age]
end
#=> [[:brother, {:name=>"abb", :age=>18}], [:me, {:name=>"hen", :age=>23}], [:sister, {:name=>"ndd", :age=>25}]]

people.sort_by do |k,v|
  print "#{k.class} #{v.class}\n"
end
# => Symbol Hash
# => Symbol Hash
# => Symbol Hash