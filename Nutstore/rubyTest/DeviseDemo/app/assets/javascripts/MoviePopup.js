$(document).ready(function(){
	  
	  $("#myModal").on("show.bs.modal", function(e) {
	      var link = $(e.relatedTarget);
		  
	      $(this).find(".modal-body").load(link.attr("href"),function(data,status,xhr){
			  if (status=="success"){
				  // $("#myModalLabel").html("Movie Details");
				  $(this).html($(data).find("p").text());
				  $("#myModal #nextStep").attr("href",$(data).find("a").attr("href"));

			  }else{
				  alert('Ajax request error');
			  }
			  
	      });
	  });
	  
  })
  

 
  
  
  
  
  

