$(function(){
	var ajaxURL = "/users/fetch_photo";
	setInterval(function(){
	  $.ajax({
	    url: ajaxURL,
	    type: "GET",
	    success: function(){
	    },
	    error: function(){
	      console.log("社真の取得に失敗しました");
	    }
	  })
    }, 5000)
})
