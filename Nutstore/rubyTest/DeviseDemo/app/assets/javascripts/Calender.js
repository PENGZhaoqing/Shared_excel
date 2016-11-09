var calender ={
  
  setup:function(){
	  
	  $('#movie_release_date_1i').html(calender.getYearOptions());
	  
	  $(calender.setDayOptions);
	  
	  $('#movie_release_date_2i').change(function(){
	      calender.setDayOptions();

	  });
	  
	  $('#movie_release_date_1i').change(function(){
	      calender.setDayOptions();
	  });
	  
  },
  
  setDayOptions: function (){
      var monthVal = $('#movie_release_date_2i').val();
	  var yearVal= $('#movie_release_date_1i').val();
      $('#movie_release_date_3i').html(calender.getDayOptions(monthVal,yearVal))
  },
  
  getDaysForMonthYear: function (month,year) {
	  
      daysInMonth = {
	          1: 31,
	          2: 28,
	          3: 31,
	          4: 30,
	          5: 31,
	          6: 30,
	          7: 31,
	          8: 31,
	          9: 30,
	          10: 31,
	          11: 30,
	          12: 31
	      };

	  if (month==2){
		  if((year%4==0&&year%100!=0)||(year%400==0)){
			  return 29;
		  }
	  }

    return daysInMonth[month];
  },

  getDayOptions: function (month,year){
    var dayOptions = '';
    var endDay = calender.getDaysForMonthYear(month,year);
    for(var currentDay = 1; currentDay <= endDay; currentDay++){
          dayOptions = dayOptions + calender.getOption(currentDay, currentDay);
      }
    return dayOptions;
  },

  getYearOptions: function (){
      var startYear = 1899;
      var endYear = 2016;
      var yearOptions = '';
      for(var currentYear = startYear; currentYear <= endYear; currentYear++){
          yearOptions = yearOptions + calender.getOption(currentYear, currentYear);
      }
	  this.initialize = function(){
		  return this.startYear;
	  }
      return yearOptions;
  },

  getOption: function (value, text){
    return '<option value="' + value + '">' + 
        text + 
        '</option>';
  }
	
};

$(document).ready(function(){
	$(calender.setup());
});
