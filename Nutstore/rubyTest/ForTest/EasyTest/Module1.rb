class BinaryTree
  include Enumerable
 
  def initialize
    @root=TreeNode.new
    @array=[]
  end
  
  def << (data)
    @root.push(data)
  end
  
  def empty?
    if @root.content
      return false
    else 
      return true
    end
  end
  
  class TreeNode
    attr_accessor :content
    attr_accessor :right
    attr_accessor :left
    
    def push(value)
      if self.content==nil
        self.left =TreeNode.new
        self.right =TreeNode.new
        self.content =value 
        print "#{value} is set \n"
      else
        if self.content>=value
          puts "#{value} is compared with #{self.content} \n"
          self.left.push(value)
          
        else
          puts "#{value} is compared with #{self.content} \n"
          self.left.push(value)
         
        end
      end
    end 
  end
  
  
  def tranversal(node)
    if node.content==nil
      return
    else 
      @array<< node.content
      tranversal(node.left)
      tranversal(node.right)
    end
  end
  
  def each
    tranversal(@root)
    @array.each do |value|
      yield value
    end
  end 
end

Tree=BinaryTree.new
Tree<<(5)
Tree<<(4)
Tree<<(9)
Tree<<(8)
Tree<<(1)
Tree<<(2)
puts Tree.empty?

Tree.each do |value| 
    print "#{value},"
  end
# puts Tree.methods.respond_to? :any?
Tree.all? do |value|
    value>0
  end
#=> 5 is set 
#=> 4 is compared with 5 
#=> 4 is set 
#=> 9 is compared with 5 
#=> 9 is compared with 4 
#=> 9 is set 
#=> 8 is compared with 5 
#=> 8 is compared with 4 
#=> 8 is compared with 9 
#=> 8 is set 
#=> 1 is compared with 5 
#=> 1 is compared with 4 
#=> 1 is compared with 9 
#=> 1 is compared with 8 
#=> 1 is set 
#=> 2 is compared with 5 
#=> 2 is compared with 4 
#=> 2 is compared with 9 
#=> 2 is compared with 8 
#=> 2 is compared with 1 
#=> 2 is set 
#=> false
#=> 5,4,9,8,1,2,
