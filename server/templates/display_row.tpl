{% extends "framework/bootstrap.tpl" %}

{% block content  %}
<!-- Main hero unit for a primary marketing message or call to action -->
<div class="well" id="main_content" style="position:relative;">
<div style="position:absolute;top:20px;right:20px;">
{% if num-1!=0 %}
<a href="/search/display?num={{num-1}}{{view_link}}&total={{total}}" class="btn">Prev Speech</a>
{% endif %}
{% if num+1>total %}
{% else %}
<a href="/search/display?num={{num+1}}{{view_link}}&total={{total}}" class="btn">Next Speech</a>
{% endif %}
<a href='/search/column?{{view_link}}' class="btn btn-inverse" style="margin-left:10px;">All Results</a>
</div>
{% set count=0 %}
<div class="row" style="margin-left:0px;">

<div class="span6">
<h1 style="font-size:20px;">Speech</h1>
<div class="row">
<table class="span6 table table-bordered table-condensed table-striped" style="margin-top:5px;">
	<span id="edit_id" class="{{item.id}}"></span>
	{% for ord in order %}
		{% for key,value in item %}
			{% if ord == key %}
				{% if key == "speech_text" %}
				{% elseif key == "notes" %}
				{% else %}
					<tr><th>{{att_names[ord]}}</th><td>{{value}}</td></tr>
				{% endif %}
			{% endif %}
		{% endfor %} 
	{% endfor %}
</table>
</div>
<h2 style="font-size:20px;">Participants</h2>
<div class="row">
<table class="span6 table table-bordered table-condensed table-striped">
	<tr>
	<th>Role</th>
	<th>Agent</th>
	<th>Gender</th>
	</tr>
	{% for ord in order %}
		{% for agent,list in agent_list %}
			{% for item in list %}
				{% if loop.index == 1 %}
					{% set gender = item %}
				{% else %}
					{% if ord == item %}
					<tr>
						{% if item == "addressee" %}
							<td>Addressee</td>
						{% elseif item == "addressee_of_enclosing" %}
							<td>Addressee of Enclosing</td>
						{% elseif item == "narrator_of_enclosing" %}
							<td>Speaker of Enclosing</td>
						{% elseif item == "speaker" %}
							<td>Speaker</td>
						{% endif %}
						<td>{{agent}}</td>
						<td>{{gender}}</td>
					</tr>
					{% endif %}
				{% endif %}
			{% endfor %}
		{% endfor %}
	{% endfor %}
</table>
</div>
<h3 style="font-size:20px;">Speech Act</h3>
<div class="row">
<table class="span6 table table-bordered table-condensed table-striped">
	{% for section in sections %}
		<tr><th style="text-decoration:underline;">Act {{loop.index}}</th></tr>
		<tr><th>Speech Act Type</th><td>{{section.speech_act_type}}</td></tr>
		<tr><th>Speech Act Subtype</th><td>{{section.speech_act_subtype}}</td></tr>
		<tr><th>Move</th><td>{{section.move}}</td></tr>
	{% endfor %}
</table>
</div>

<div class="inline-glossary">
			<a class="sample">&#x25BC; Glossary</a>
	    		<div class="sample-inner" id="display-row">
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

<div class="span5 speech_text">
	<div style="margin:10px;">
	{% for text in texts %}
		{% if text.line_num <= 0 %}
			{% if text.speech_text == "" %}
				{% if text.line_num == 0 %}
                                        <br>
                                {% endif %}
			{% else %}
				{{text.speech_text}}<br>
				{% if text.line_num == 0 %}
					<br>
				{% endif %}
			{% endif %}
		{% elseif text.line_num % 5 != 0 %}
			{% if (text.line_num >= item.start_verse) and (text.line_num <= item.end_verse) %}
                                {{text.speech_text}}<br>
                        {% endif %}
		{% else %}
			{% if (text.line_num >= item.start_verse) and (text.line_num <= item.end_verse) %}
				{{text.speech_text}} <span style="margin-right:40px;">&nbsp </span>{{text.line_num}}<br>
			{% endif %}
		{% endif %}
	{% endfor %}
	</div>
</div>
</div>
</div>

{% endblock %}
