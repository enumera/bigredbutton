


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

	          hours = hours + ' hours ';
	          minutes = minutes + ' minutes';
	          seconds = parseInt(seconds) + ' seconds';
	          // console.log("hours : " + hours + "minutes : " + minutes + "seconds : "+ seconds)
	          $('#clock_message').text('The clock is running!');
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
      // $('.new_note').fadeOut();
      // $('.new_note').fadeOut();
      $('#time_record_header').text("Task some time");
    };
   

  $(document.body).on("click",'#bigredbutton', function(){
  	// alert("you pressed the button!")
  	
  	if ($('#operation').val() == "update"){
	
  		stopClock();
  		// $('#bigredbutton').removeClass("blue");
  		// $('#bigredbutton').addClass("red");
  	
  	};	
  });

  $(document.body).on("change", '#Task', function(){
   	var taskSelected = $(this).val();
   	var taskText = $('#Task option:selected').text();
   	console.log($(this).text());
   	// alert("task selected id is "+taskSelected);
   	$('#note_task_id').val(taskSelected);
   	$('.new_task').fadeOut();
	$('.select_a_task').fadeOut();
	$('#note_content').prop('disabled', false);
	$('#note_content').prop('placeholder', 'Add something...');
	$('#note_message').fadeOut();
	$('#task_prompt').fadeOut();
	$('#time_record_header').text(taskText);
	$.getJSON("/notes/index?task_id="+taskSelected, function(data){
		console.log(data);
		$.each(data, function(i, note){
			// console.log(data[note]);
			$('ul#notes').append('<li class="well well-lg wrapword">'+ note.content + "<br><sm>" +' created at: '+ note.created_at + '</sm></li>');
		});
	});

  });

});