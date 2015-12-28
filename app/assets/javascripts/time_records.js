


$(document).ready(function(){

	  var clock = function(){
	      var d = new Date;
	      var timeStart = d.getTime();
	      // console.log(timeStart);
	      $('#hours').text('');
	      $('#minutes').text('');
	      $('#seconds').text('');

	      sessionClock = setInterval(function() {
	          var x = new Date();
	          var timeNow = x.getTime();
	          var timeDiff = timeNow - timeStart;

	          var days = Math.floor(timeDiff / (1000 * 3600 * 24)); 
	          timeDiff = timeDiff - days * (1000 * 3600 * 24)
	          var hours = Math.floor(timeDiff / (1000 * 3600 ));
	          timeDiff = timeDiff - hours * (1000 * 3600 );
	          var minutes = Math.floor(timeDiff / (1000 * 60 ));
	          timeDiff = timeDiff - minutes * (1000 * 60 )
	          var seconds = timeDiff / (1000 );

	          minutes = ' : ' + minutes;
	          seconds = ' : ' + parseInt(seconds);
	          // console.log("hours : " + hours + "minutes : " + minutes + "seconds : "+ seconds)
	          
	          $('#hours').text(hours);
	          $('#minutes').text(minutes);
	          $('#seconds').text(seconds);

	    }, 33);
	};

	var stopClock = function(){
  		clearInterval(sessionClock);

	};



  if ($('#operation').val()=="update"){

      clock();
    };
   

  $(document.body).on("click",'#bigredbutton', function(){
  	// alert("you pressed the button!")
  	
  	if ($('#operation').val() == "update"){
	
  		stopClock();
  		$('#bigredbutton').removeClass("blue");
  		$('#bigredbutton').addClass("red");
  	
  	};	
  });

});