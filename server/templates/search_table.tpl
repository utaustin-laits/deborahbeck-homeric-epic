{% extends "framework/bootstrap.tpl" %}

{% block content  %}
<script src="/www/js/unique.js"></script>

<div class="well" id="main_content" style="position:relative;background-color:whiteSmoke;">
<h3>New Search</h3>
<form action="/search/column" class="navbar-form" method="get" id="speech_search">
        <input type="submit" value="Search" style="position:absolute;top:10px;right:20px;" class="btn btn-inverse">
{% set count=0 %}
<div class="row">
        <div class="span3" id="sel_attr">
        <dl id="data_search">
        <div style="font-size:17px;font-weight:bold;">Select Attributes:</div>
	<form id="select_attr_form" action="">
		<select id="select_attr">
			<option value="selecting">Select One: </option>
			<option id="Work" class="work">Work </option>
			<option id="Book Number" class="book_number">Book Number </option>
			<option id="Start Verse" class="start_verse">Start Verse </option>
			<option id="End Verse" class="end_verse">End Verse </option>
			<option id="Length" class="length">Length </option>
			<option id="Speaker" class="speaker">Speaker </option>
			<option id="Speaker Gender" class="speaker_gender">Speaker Gender </option>
			<option id="Addressee" class="addressee">Addressee </option>
			<option id="Addressee Gender" class="addressee_gender">Addressee Gender </option>
			<option id="Verb of Speaking" class="verb_of_speaking">Verb of Speaking </option>
			<option id="Verse Number" class="verse_number">Verse Number</option>
			<option id="Subordinate Clause" class="subordinate_clause">Subordinate Clause </option>
			<option id="Narrative Level" class="narrative_level">Narrative Level </option>
			<option id="Type of Speech Represented" class="type_of_speech_repr">Type of Speech Represented </option>
			<option id="Speech Act Type" class="speech_act_type">Speech Act Type </option>
			<option id="Speech Act Subtype" class="speech_act_subtype">Speech Act Subtype </option>
			<option id="Move" class="move">Move </option>
			<option id="Start Verse of Enclosing" class="start_verse_of_enclosing">Start Verse of Enclosing </option>
			<option id="End Verse of Enclosing" class="end_verse_of_enclosing">End Verse of Enclosing </option>
			<option id="Length of Enclosing" class="length_of_enclosing">Length of Enclosing </option>
			<option id="Narrator of Enclosing" class="narrator_of_enclosing">Speaker of Enclosing </option>
			<option id="Narrator of Enclosing Gender" class="narrator_of_enclosing_gender">Speaker of Enclosing Gender </option>
			<option id="Addressee of Enclosing" class="addressee_of_enclosing">Addressee of Enclosing </option>
			<option id="Addressee of Enclosing Gender" class="addressee_of_enclosing_gender">Addressee of Enclosing Gender </option>
			<option id="Speech Act Type of Enclosing" class="speech_act_type_of_enclosing">Speech Act Type of Enclosing </option>
			<option id="Speech Act Subtype of Enclosing" class="speech_act_subtype_of_enclosing">Speech Act Subtype of Enclosing </option>
			<option id="Move of Enclosing" class="move_of_enclosing">Move of Enclosing </option>
			
		</select>
	</form>        
        </dl>
        </div> 
        <div class="span4" id="hresp"></div>
	<div class="span3" id="sel_order">
	<dl>
	<div id="search_title" style="font-size:17px;font-weight:bold; margin-bottom: 6px;">Your Selected Parameters:</div>
	{# <select id="order_search" name="order_search" style="margin-bottom:5px;"><option value="">Order Search By: </option></select> #}
	<div id="search_param"></div>
	</dl>
	</div>
</div>
</form>

<div class="inline-glossary">
			<a class="sample">&#x25BC;  Select multiple attributes</a>
				<div class="sample-inner">
				<p>For each additional attribute, select the new item from the attributes list, then select the attribute's value. "Your selected Parameters" lists each attribute/value pair that has been added.</p>
				</div>

			<a class="sample">&#x25BC; Glossary</a>
	    		<div class="sample-inner">
	    		<dl>
	    		<dt><span class="dt-style">Gender and number of speakers and addressees</span></dt>
	    		  <dd><strong>masc:</strong> single masculine speaker or addressee<br>
	    		      <strong>fem:</strong> single feminine speaker or addressee<br>
	    		      <strong>unspec (gender):</strong> speaker or addressee whose gender is not stated and which is not clear from the context. unspec is also used as the name of a speaker or addressee, where it may have various genders (masc, unspec, pl masc, pl unspec)<br>
	    			  <strong>pl masc:</strong> a group of men, such as "Greeks" or "suitors (of Penelope)"<br>
	    			  <strong>pl fem:</strong> a group of women, such as "maidservants" or "nymphs"<br>
	    			  <strong>pl mixed:</strong> a group composed of both men and women, such as "gods" or "parents"<br> 
	    			  <strong>pl unspec:</strong> an addressee whose gender composition is unclear, but which context implies to be a group rather than an individual</dd>
	    		<dt><span class="dt-style">Narrative Level:</span> variables related to whether the narrator of a speech is a character or the main narrator</dt>
	    		  <dd><strong>NF1:</strong> main narrator<br>
	    		      <strong>NF2:</strong> character narrator. NF2 speeches in <em>Odyssey</em> 9-12 have only "Odysseus/masc" in the "speaker of enclosing/gender" fields<br>
	    		      <strong>NF3:</strong> narrator is a character whose speech is presented within another character's speech. NF3 has as "enclosing speech" the NF1 speech, not the NF2 speech, but speeches that appear within speeches quoted by Odysseus in <em>Odyssey</em> 9-12 give the info on the NF2 speech in the "enclosing speech" fields<br>
	    		      <strong>NF1+2:</strong> speech where the narrator and narrative level are not clear (in Demodocus' songs in <em>Odyssey</em> 8 and the scar story in <em>Odyssey</em> 19); these do not have any "enclosing speech" information due to their unclear narrative level</dd>	    
	    		<dt><span class="dt-style">Subordinate clause</span></dt>  
	    		  <dd>any word or phrase grammatically dependent on a verb of speaking</dd>
	    		<dt><span class="dt-style">Type of Speech Represented</span></dt>
	    		  <dd><strong>direct quotation:</strong> speech presented from the point of view of the speaker; deictic words reflect speaker’s perspective<br>
					  <strong>indirect speech:</strong> speech presented from the point of view of the reporter; deictic words reflect reporter’s perspective<br>
    				  <strong>speech mention:</strong> speech presented from the point of view of the reporter; does not provide the specific words of the speech<br>
					  <strong>FID:</strong> free indirect discourse:  speech presentation that includes features of both direct quotation and indirect speech<br></dd>		
	    		<dt><span class="dt-style">Speech Act Type</span></dt>
	    		  <dd><strong>directive:</strong> a speech act about action<br>
					  <strong>assertive:</strong> a speech act about facts, tends to be oriented toward the speaker<br>
					  <strong>expressive:</strong> a speech act about emotions<br>
					  <strong>interrogative:</strong> a speech act about facts, tends to be oriented toward the addressee<br></dd>
				<dt><span class="dt-style">Speech Act Subtype</span></dt> 
					<dd>for definitions of speech act subtypes, see <a target="_blank" href="/www/img/book_text.pdf">Introduction,</a> pp. 14-18</dd>
	    		<dt><span class="dt-style">Move</span></dt>
	    		  <dd><strong>initial:</strong> a speech act that begins a conversational exchange<br>
					  <strong>reactive:</strong> a speech act that responds to a previous move<br>
					  <strong>problematic:</strong> a speech act that responds to a previous move by challenging or disobeying it</dd>		    		  	    		  	    		  	    		    	    		  
	    		</dl>
        		</div>
</div>


</div>

<!-- Main hero unit for a primary marketing message or call to action -->
<div id="main_content" style="position:relative;">
<div class="row pull-right" style="margin-right:10px;margin-bottom:10px;margin-top:4px">
{% if page != 1 %}
<a href='/search/column?page={{page-1}}{{view_link}}' id="page_prev" class="btn" style="margin-right:5px;">Prev Page</a>
{% endif %}
{% if page != total_pages and total != 0%}
<a href='/search/column?page={{page+1}}{{view_link}}' id="page_next" class="btn">Next Page</a>
{% endif %}
</div>
<div class="row" style="margin-left:0px;margin-bottom:10px;">
<h3 style="margin-top:4px;">
{% if total == 0 %}
Displaying 0 Total Speeches
{% elseif page!= total_pages %}
Displaying {{((page-1)*max)+1}}-{{(page*max)}} of {{total}} Total Speeches
{% else %}
Displaying {{((page-1)*max)+1}}-{{total}} of {{total}} Total Speeches
{% endif %}
(Total length: {{lines_total}} lines)
</h3>
</div>
{% set count=0 %}


{% set count=0 %}
    {% for res in result %}
	<div class="well">
		<b>{{loop.index + ((page-1)*max)}}.</b>
		<div class="view_btn"><a href='/search/display?id={{res[0].speech_id}}&num={{loop.index + ((page-1)*max)}}{{view_link}}' id="display_link" class="btn btn-inverse">View</a></div>
	<div class="row" style="margin-top:10px;">
	<div class="span6">
	{% for ord in order %}
		{% for item in res %}
			{% if item.attribute == ord %}
				{% if item.attribute == "notes" %}
				{% elseif (item.attribute == "work") or (item.attribute == "book_number") or (item.attribute == "start_verse") or (item.attribute == "end_verse") %}
					<div>{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "speech_text" %}
				{% elseif item.attribute == "type_of_speech_repr" %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "speech_act_subtype" %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "speech_act_type" %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "move" %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "addressee" %}
					<div>{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "speaker" %}
					<div>{{att_names[ord]}} : {{item.value}}</div>
				{% elseif item.attribute == "narrator_of_enclosing" %}
					<div class="{{item.speech_id}}" style="display:none;">Speaker of Enclosing : {{item.value}}</div>
				{% elseif item.attribute == "addressee_of_enclosing" %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% else %}
					<div class="{{item.speech_id}}" style="display:none;">{{att_names[ord]}} : {{item.value}}</div>
				{% endif %}
			{% endif %}
		{% endfor %}
	{% endfor %}
	
	{% for item in res %}

		{% if item.attribute=="book_number" %}	
		<!-- book number is arbitrary.. chosen because there is one book number per speech -->
			</div>
			<div class="span5"><div><b>Greek Text</b></div>{{speech_array[count]}}</div>
		{% endif %}
	{% endfor %}
	</div>
		<a href="" class="expand_result" id="{{res[0].speech_id}}" style="font-size:14px;">More</a>
	</div>
	{% set count=count+1 %}
    {% endfor %}
	<span id="get_total" class="{{total}}"></span>
<div class="row" style="margin-left:0px;margin-top:10px;">
{% if page != 1 %}
<a href='/search/column?page={{page-1}}{{view_link}}' id="page_prev" class="btn pull-left" style="margin-right:5px;">Prev Page</a>
{% endif %}
{% if page != total_pages and total != 0%}
<a href='/search/column?page={{page+1}}{{view_link}}' id="page_next" class="btn pull-right">Next Page</a>
{% endif %}
</div>
</div>
{% endblock %}
