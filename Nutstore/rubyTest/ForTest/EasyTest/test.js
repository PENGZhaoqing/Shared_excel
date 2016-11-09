var User =function(Name,password) {
  var Name =Name;
  var password=password;
 
  this.checkPassword = function(p){
	  if (password == p){
		  return true;
	  }else{
		  return false ;
	  };
  };
  
};

user=new User("elvis","123456");
alert(user.checkPassword("123456"));
//ture
