$(function(){
	var ajaxURL = "/users/fetch_photo";

	var lastImage;

	setInterval(function(){
	  $.ajax({
	    url: ajaxURL,
	    type: "GET",
	    success: function(data) {
	    	if(data.progress >= 100) {
	    		setTimeout(function() {
	    			window.location = '/users/ranking';
	    		}, 3000);
	    	}
	    	if(data.photo.photo_url == lastImage) {
	    		return;
	    	}
	    	lastImage = data.photo.photo_url;
	    	$('#current-photo').attr('src', data.photo.photo_url);
	    	$('.progress-now').width(data.progress + "%");
	    	var percentage = Math.floor(Math.random() * 40 + 60);
	    	$('#percent-number').text(percentage);
	    	$('.percent-friendly').removeClass('hidden');
	    },
	    error: function(){
	      console.log("社真の取得に失敗しました");
	    }
	  });
    }, 5000)
});
