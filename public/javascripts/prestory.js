/*
*	Augments the skills of avatar	
*/
function updateModel(url, data) {
	if(!data) data = "";
	$.ajax({
			url: url,
			dataType: "json",
			type: "GET",
			processData: false,
			contentType: "application/json",
			data: data,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("X-Http-Method-Override", "PUT");
			}
		});
}

$(document).ready(function(){

	var prestorySelect = $("#prestorySelect");

	// select onChange
	/*
	prestorySelect.change(function () { 
    	
	}).trigger('change');
	*/
	
	$('.hideRlDescription').hide();

	$(".expand").click(function(){
		$('#rlDescription' + $(this).attr("id")).toggle();		
	});


});