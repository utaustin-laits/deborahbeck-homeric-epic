{% block content %}
<dl id="unique">
<div style="font-size:17px;font-weight:bold;">Select a Value to Search By:</div>
<div id="optional"></div>
<div>
<select id="select_logic" class="logic_{{column_name}}" style="margin-bottom:5px;"><option value="include">Include</option><option value="omit">Omit</option></select>
</div>
<div>
<select id="select_val">
<option value="">Select a Value</option>
{% for key,value in sub %}
<option id="{{column_name}}" class="{{attr}}" value="{{key}}">{{key}} ({{value}})</option>
{% endfor %}
</select>
{% if (column_name == "book_number") or (column_name == "length") or (column_name == "start_verse") or (column_name == "end_verse") %}
</div>
<div style="margin-left:95px;margin-top:5px;margin-bottom:5px;"> to </div>
<div>
<select id="select_val1">
<option value="">Select a Value</option>
{% for key,value in sub %}
<option id="{{column_name}}1" class="{{attr}}" value="{{key}}">{{key}} ({{value}})</option>
{% endfor %}
</select>
{% endif %}
</div>
</dl>
{% endblock %}
