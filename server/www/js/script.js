var Dase = {};

$(document).ready(function() {
	$('a.sample').click(function(){
		$(this).next('div.sample-inner').toggle('300');
		$(this).toggleClass('activecolor');
	});
    $('div.sample-inner').hide();


	$('#select_attr').change(function (e) {
		var handler_url = '/search/' + $('#select_attr option:selected').attr('class') + '/count';
		var find = $('#select_attr option:selected').attr('class');
		if ($('#' + find).length > 0) {
		} else {
			$('select#order_search').append('<option id="' + find + '" value="' + find + '">"' + $('#select_attr option:selected').text() + '"</option>');
		}
		$.ajax({
			type: 'GET',
			data: {attr: $('#select_attr option:selected').attr('id')},
			url: handler_url,
			success: function (hresp) {
				$('#hresp').html(hresp);
			},
			error: function () {
			}
		});
	});

});
