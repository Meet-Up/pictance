$(function(){
	var ajaxURL = "/users/fetch_photo";
	setInterval(function(){
	  $.ajax({
	    url: ajaxURL,
	    type: "GET",
	    success: function(data) {
	    	$('#current-photo').attr('src', data.photo_url);
	    	var percentage = Math.floor(Math.random() * 40 + 60);
	    	$('#percent-number').text(percentage);
	    },
	    error: function(){
	      console.log("社真の取得に失敗しました");
	    }
	  });
    }, 5000)
});
