window.search_params = {};

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
            window.search_params[id] = {
                logic: getUrlParameter('logic_' + id),
                val: getUrlParameter(id)
            };
        } else {
            window.search_params[id] = {
                logic: getUrlParameter('logic_' + id),
                val: getUrlParameter(id),
                val1: getUrlParameter(id + '1')
            };
        }
        draw_search();
    });
}

function removeElementsByQuerySelector(query) {
    document.querySelectorAll(query).forEach(function (elem) {
        elem.remove();
    });
}

function selectVal_onChange(el, column_name) {
    var selected = el.options[el.selectedIndex];

    var select_logic_val = document.getElementById('select_logic').value;
    var selected_val = selected.value;

    var params = window.search_params[column_name];
    if (params===undefined) {
        params = {};
    }
    window.search_params[column_name] = Object.assign(params, {
        logic: select_logic_val,
        val: selected_val
    });
    draw_search();
}

function selectVal1_onChange(el, column_name) {
    var selected = document.getElementById('select_val').options[document.getElementById('select_val').selectedIndex];

    var selected1 = el.options[el.selectedIndex];
    var select_logic_val = document.getElementById('select_logic').value;
    var selected_val = selected.value;
    var selected1_val = selected1.value;

    window.search_params[column_name] = {
        logic: select_logic_val,
        val: selected_val,
        val1: selected1_val
    };
    draw_search();
}

function removeSearchParam(id) {
    delete window.search_params[id];
    draw_search();
}

function draw_search() {
    removeElementsByQuerySelector('#hidden_inputs>*');
    removeElementsByQuerySelector('#search_param>*');
    var hidden_inputs = document.getElementById('hidden_inputs');
    var search_param_area = document.getElementById('search_param');
    Object.keys(id_to_param_name_mapping).forEach(function (id) {
        if (!(id in window.search_params)) {
            return;
        }
        var param = id_to_param_name_mapping[id];

        var search_val = window.search_params[id].val;
        var search_val1 = window.search_params[id].val1;
        if (!search_val) {
            search_val = search_val1;
            search_val1 = undefined;
        }
        if (window.search_params[id].val === window.search_params[id].val1) {
            search_val1 = undefined;
        }
        if (search_val1 !== undefined) {
            if (parseInt(window.search_params[id].val1) < parseInt(window.search_params[id].val)) {
                var temp = search_val;
                search_val = search_val1;
                search_val1 = temp;
            }
        }

        var input1 = document.createElement('input');
        input1.type = 'hidden';
        input1.name = id;
        input1.value = sanitizeHTML(search_val);
        hidden_inputs.appendChild(input1);

        var input2 = document.createElement('input');
        input2.type = 'hidden';
        input2.name = 'logic_' + id;
        input2.value = sanitizeHTML(window.search_params[id].logic);
        hidden_inputs.appendChild(input2);

        if (search_val1) {
            var input3 = document.createElement('input');
            input3.type = 'hidden';
            input3.name = id + '1';
            input3.value = sanitizeHTML(search_val1);
            hidden_inputs.appendChild(input3);
        }

        var button = document.createElement('button');
        button.classList.add('child_' + id, 'icon_remove');
        button.style.float = 'right';
        button.textContent = 'x';
        button.onclick = function () {
            removeSearchParam(id);
        }
        search_param_area.appendChild(button);

        var text_content = param + " : ";
        if (window.search_params[id].logic == "omit") {
            text_content += "Omit ";
        }
        text_content += search_val;
        if (search_val1 !== undefined) {
            text_content += "-" + search_val1;
        }
        var dt = document.createElement('dt');
        dt.classList.add('child_' + id);
        dt.style.marginBottom = '10px';
        dt.textContent = sanitizeHTML(text_content);
        search_param_area.appendChild(dt);

    });
}

document.addEventListener("DOMContentLoaded", function () {
    preload_selected_search_params();

});
