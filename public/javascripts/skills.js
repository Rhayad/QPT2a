/*
*	Augments the skills of avatar	
*/
function updateModel(url, data) {
	if(!data) data = "";
	$.ajax({
			url: url,
			dataType: "json",
			type: "POST",
			processData: false,
			contentType: "application/json",
			data: data,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("X-Http-Method-Override", "PUT");
			}
		});
}

$(document).ready(function(){

	var skillInput = $("#inputSkill");
	skillInput.hide();
	skillButton = $(".buttonSkillUp");
	skillButton.hide();

	// add Buttons
	strengthSkill 		= $("#strengthSkill");
	abilitySkill 		= $("#abilitySkill");
	enduranceSkill 		= $("#enduranceSkill");
	intelligenceSkill 	= $("#intelligenceSkill");

	// Spans
	spanStrength 		= $("#spanStrength");
	spanAbility 		= $("#spanAbility");
	spanIntelligence 	= $("#spanIntelligence");
	spanEndurance 		= $("#spanEndurance");

	if(skillInput.val()) {
		skillButton.show("slow");
		skillInput.show();
	}

	// Increase span-value++ onClick
	skillButton.click(function() {
		skillInputValue = parseInt(skillInput.val())
		if(skillInputValue == 0) {
			skillButton.hide("slow");
			return false;
		}

		// Show new value in span
		prevSpan = $(this).prev("span");
		innerSpanHtmlValue = prevSpan.html();
		add = parseInt(innerSpanHtmlValue) + 1;
		prevSpan.html(add);

		// Decrease skillPoints
		skillInput.val(skillInputValue - 1);
		updateModel("http://localhost:3000/decreasepoints/", "");
			
		// Increase skill
		skill = $(this).attr("id");
		sendData = '{ "skillPoint" : { "value" : "'+skill+'"} }';
		updateModel("http://localhost:3000/addSkill/", sendData);
	});
});