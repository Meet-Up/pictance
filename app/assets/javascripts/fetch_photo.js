$(function(){
	var ajaxURL = "/users/fetch_photo";
	setInterval(function(){
	  $.ajax({
	    url: ajaxURL,
	    type: "GET",
	    success: function(data) {
	    	$('#current-photo').attr('src', data.photo.photo_url);
	    	$('.progress-now').width(data.progress + "%");
	    	var percentage = Math.floor(Math.random() * 40 + 60);
	    	$('#percent-number').text(percentage);
	    	if(data.progress === 100) {
	    		setTimeout(function() {
	    			// window.location = '	'
	    		}, 3000);
	    	}
	    },
	    error: function(){
	      console.log("社真の取得に失敗しました");
	    }
	  });
    }, 5000)
});
