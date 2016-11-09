class Time
  
def self.parse(arg)
  s= arg.split
  s[0]=s[0].gsub!(/:/,".").to_f
  if s.size()>1 && s[1]=="pm"
    s[0]+=12  
  end
  
  hour=s[0].floor
  minute=((s[0]-hour)*100).round
  [0,1,2,3,4].each do |value|
    if((minute-value*15).abs<=7)
      s[1]=value
    end
  end
  s[0]=hour
  @@s=s
  return Time
end

def self.humanize()
  arg=@@s
  main=Hash.new
  number="one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve".split(",")
  [1,2,3,4,5,6,7,8,9,10,11,12].each do |value|
    main[value]=number[value-1]
  end
  sentence="About,About a quarter past,About half past,About a quarter til,About".split(",")
  if arg[0]==24&&arg[1]==0 
    return "About midnight"
  else
    # 大于12点的减去12
    arg[0]>12 ? (arg[0]-=12):()
    # 0点 就置于12点
    arg[0]==0 ? (arg[0]=12):()
    
    if rand(2)>0
      # 进下一个时间点
      arg[1]>=3 ? (arg[0]+=1):()
      return "#{sentence[arg[1]]} #{main[arg[0]]}"
    else
      # 时间进位
      arg[1]==4 ? (arg[0]+=1 && arg[1]=0):()
      return "#{sentence[0]} #{arg[0].to_s}:#{(arg[1]*15).to_s}#{ 0 if arg[1]==0}"
    end
  
  end  
end  

end

puts Time.parse("12:00 pm").humanize
puts Time.parse("12:00 am").humanize
puts Time.parse("10:47 pm").humanize
puts Time.parse("10:31 pm").humanize
puts Time.parse("10:07 pm").humanize
puts Time.parse("23:58").humanize
puts Time.parse("00:29").humanize
