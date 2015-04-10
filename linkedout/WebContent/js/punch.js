$(document).ready(function() {
	$("#query_chosen").find("li").click(function() {
		var index = $(this).index() + 1;
		$.get("Punch?query=" + index, function(data) {
			$("#result").empty();
			$("#result").html(data);
		});
	});
});