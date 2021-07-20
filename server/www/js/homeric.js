var prev = 0;
var range_count = 0;

$('a.expand_result').click(function () {
    var result_id = $(this).attr('id');
    if ($('#' + result_id).text() == "More") {
        $('.' + result_id).css('display', 'block');
        $('#' + result_id).text('Less');
    } else {
        $('.' + result_id).css('display', 'none');
        $('#' + result_id).text('More');
    }
    return false;
});

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

$('a#display_link').click(function () {
    $(this).attr('href', $(this).attr('href') + '&total=' + $('#get_total').attr('class'));
});

