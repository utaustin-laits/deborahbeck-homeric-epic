document.addEventListener("DOMContentLoaded", function () {

    function sanitizeHTML(text) {
        var element = document.createElement('div');
        element.innerText = text;
        return element.innerHTML;
    }

    var id_to_param_name_mapping = {
        "work": "Work",
        "book_number": "Book Number",
        "start_verse": "Start Verse",
        "end_verse": "End Verse",
        "length": "Length",
        "speaker": "Speaker",
        "speaker_gender": "Speaker Gender",
        "addressee": "Addressee",
        "addressee_gender": "Addressee Gender",
        "verb_of_speaking": "Verb of Speaking",
        "verse_number": "Verse Number",
        "subordinate_clause": "Subordinate Clause",
        "narrative_level": "Narrative Level",
        "type_of_speech_repr": "Type of Speech Represented",
        "speech_act_type": "Speech Act Type",
        "speech_act_subtype": "Speech Act Subtype",
        "move": "Move",
        "start_verse_of_enclosing": "Start Verse of Enclosing",
        "end_verse_of_enclosing": "End Verse of Enclosing",
        "length_of_enclosing": "Length of Enclosing",
        "narrator_of_enclosing": "Speaker of Enclosing",
        "narrator_of_enclosing_gender": "Speaker of Enclosing Gender",
        "addressee_of_enclosing": "Addressee of Enclosing",
        "addressee_of_enclosing_gender": "Addressee of Enclosing Gender",
        "speech_act_type_of_enclosing": "Speech Act Type of Enclosing",
        "speech_act_subtype_of_enclosing": "Speech Act Subtype of Enclosing",
        "move_of_enclosing": "Move of Enclosing"
    };

    $(document).on('change', '#select_val', function () {
        var selected = $('#select_val option:selected');
        var this_id = selected.attr('id');
        var param = selected.attr('class');
        // check if the field is already under search paramters
        $('form#speech_search').find('#child_' + this_id).remove();
        var select_logic_val = $('#select_logic').val();
        var selected_val = selected.val();
        var select_logic_class = $('#select_logic').attr('class');
        begin_search_change(this_id, select_logic_val, selected_val);
    });

    function begin_search_change(this_id, select_logic_val, selected_val) {
        var select_logic_class = 'logic_' + this_id;
        var param = id_to_param_name_mapping[this_id];
        if (select_logic_val == "include") {
            $('#search_param').append("<button id='child_" + this_id + "' class='icon_remove' style='float:right;'>x</button><dt id='child_" + this_id + "' style='margin-bottom:10px;'>" + param + " : " + sanitizeHTML(selected_val) + "</dt>");
        } else {
            $('#search_param').append("<button id='child_" + this_id + "' class='icon_remove' style='float:right;'>x</button><dt id='child_" + this_id + "' style='margin-bottom:10px;'>" + param + " : Omit " + sanitizeHTML(selected_val) + "</dt>");
        }
        $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + this_id + '" value="' + sanitizeHTML(selected_val) + '"/>');
        $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + select_logic_class + '" value="' + sanitizeHTML(select_logic_val) + '"/>');
        $('button#child_' + this_id).click(function (event) {
            event.preventDefault();
            $('select#order_search').find('#child_' + this_id).remove();
            $('form#speech_search').find('#child_' + this_id).remove();
        });
    };

    $(document).on('change', '#select_val1', function () {
        var selected = $('#select_val option:selected');
        var this_id = selected.attr('id');
        var param = selected.attr('class');
        $('form#speech_search').find('#child_' + this_id).remove();
        var selected1 = $('#select_val1 option:selected');
        var this_id1 = selected1.attr('id');
        var select_logic_val = $('#select_logic').val();
        var selected_val = selected.val();
        var select_logic_class = $('#select_logic').attr('class');
        var selected1_val = selected1.val();
        end_search_change(this_id, this_id1, select_logic_val, selected_val, selected1_val);
    });

    function end_search_change(this_id, this_id1, select_logic_val, selected_val, selected1_val) {
        var select_logic_class = 'logic_' + this_id;
        var param = id_to_param_name_mapping[this_id];
        $('#search_param').append("<button id='child_" + this_id + "' class='icon_remove' style='float:right;'>x</button><dt id='child_" + this_id + "' style='margin-bottom:10px;'>" + param + " : " + sanitizeHTML(selected_val) + "</dt>");
        $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + this_id + '" value="' + sanitizeHTML(selected_val) + '"/>');
        $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + select_logic_class + '" value="' + sanitizeHTML(select_logic_val) + '"/>');
        $('button#child_' + this_id).click(function (event) {
            event.preventDefault();
            $('select#order_search').find('#child_' + this_id).remove();
            $('form#speech_search').find('#child_' + this_id).remove();
            range_count = 0;
        });
        if (parseInt(selected1_val) == parseInt(selected_val)) {
        } else if (parseInt(selected1_val) > parseInt(selected_val)) {
            $('input#child_' + this_id1).remove();
            if (select_logic_val == "include") {
                $('dt#child_' + this_id).text(param + " : " + sanitizeHTML(selected_val) + "-" + sanitizeHTML(selected1_val));
            } else {
                $('dt#child_' + this_id).text(param + " : Omit " + sanitizeHTML(selected_val) + "-" + sanitizeHTML(selected1_val));
            }
            $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + this_id + 1 + '" value="' + sanitizeHTML(selected1_val) + '"/>');
        } else {
            $('form#speech_search').find('#child_' + this_id).remove();
            $('input#child_' + this_id1).remove();
            $('#search_param').append("<button id='child_" + this_id + "' class='icon_remove' style='float:right;'>x</button><dt id='child_" + this_id + "' style='margin-bottom:10px;'>" + param + " : " + sanitizeHTML(selected1_val) + "</dt>");
            $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + this_id + '" value="' + sanitizeHTML(selected1_val) + '"/>');
            $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + select_logic_class + '" value="' + sanitizeHTML(select_logic_val) + '"/>');
            $('button#child_' + this_id).click(function (event) {
                event.preventDefault();
                $('select#order_search').find('#child_' + this_id).remove();
                $('form#speech_search').find('#child_' + this_id).remove();
                range_count = 0;
            });
            if (select_logic_val == "include") {
                $('dt#child_' + this_id).text(param + " : " + sanitizeHTML(selected1_val) + "-" + sanitizeHTML(selected_val));
            } else {
                $('dt#child_' + this_id).text(param + " : Omit " + sanitizeHTML(selected1_val) + "-" + sanitizeHTML(selected_val));
            }
            $('form#speech_search').append('<input id="child_' + this_id + '" type="hidden" name="' + this_id + 1 + '" value="' + sanitizeHTML(selected_val) + '"/>');
        }
    };

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? null : decodeURIComponent(results[1].replace(/\+/g, ' '));
    };

    function preload_selected_search_params() {
        Object.keys(id_to_param_name_mapping).forEach(function (id) {
            if (getUrlParameter(id) == null) {
                return;
            }

            if (getUrlParameter(id + '1') == null) {
                begin_search_change(id, getUrlParameter('logic_' + id), getUrlParameter(id));
            } else {
                end_search_change(id, id + '1', getUrlParameter('logic_' + id), getUrlParameter(id), getUrlParameter(id + '1'));
            }
        });
    }

    preload_selected_search_params();

});
