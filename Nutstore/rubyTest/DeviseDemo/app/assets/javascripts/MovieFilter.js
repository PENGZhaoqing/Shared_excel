var MovieListFilter ={
  filter_adult: function(){
	  var table = document.getElementById("movies");
	  var rows = table.getElementsByTagName("tr");
	
	  for(var i=1;i<rows.length;i++){
		  
	  	  var ele=$(rows[i]).find("td").eq(2);
		  
		  var re=/^G|PG$/;
		  var flag=re.test(ele.text());
		  
		  if ($(this).is(':checked')){
			  
			  if(flag==true){
				  $(rows[i]).hide();
			  }else{
			 	  $(rows[i]).show();	
			  };
		  }else {
			  $(rows[i]).show();	
		  };
	  };
  },
  setup: function (){
  	var lableAndCheckbox=
	  $('<lable for ="filter"> Only movies suitable for children</lable>'+'<input type ="checkbox" id ="filter" />');
	  lableAndCheckbox.insertBefore('#movies');
	  $('#filter').change(MovieListFilter.filter_adult);
	   //alert('hello')
  }
};

$(document).ready(function(){
	MovieListFilter.setup()
})