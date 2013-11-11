$(function(){
	/*
	setInterval(function(){
		*/
		var ajaxURL = "/users/fetch_photo";

		$.ajax({
			url: ajaxURL,
			type: "GET",
			success: function(){

			},
			error: function(){
				console.log("社真の取得に失敗しました");
			}
		})/*
	}, 5000)
*/
})
