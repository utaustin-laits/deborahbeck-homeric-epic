{% extends "framework/bootstrap.tpl" %}

{% block content  %}

<div class="well">
<h2 class="center">Examples of Database Searches</h2>
<p class="center">Click on the search questions below for examples of how to use the search database.</p>
<p><strong>I'd like to find... </strong></p>
<div id="examples">

<a class="sample">&#x25BC; All speeches with <strong>free indirect speech</strong> presented by the <strong>main narrator</strong> in the <strong>Iliad</strong> <span style="color:#333333;">(searching with multiple attributes)</span></a> 
<div class="sample-inner">
    <div class="row">
    <div class="span11">
    
      <div class="row">
        <div class="span9"><p>You can perform a search for speeches that match multiple attributes. There are three attributes involved in this search: <strong>Type of Speech Represented</strong>, <strong>Narrative Level</strong>, and <strong>Work</strong>.  These attributes may be added to the search parameters in any order.</p></div>
        <div class="span1"></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>1. Select the first attribute & value:</strong> Under "Select Attribute", choose <em>Work</em>.  Under "Select a Value to Search By" choose and the value <em>Iliad</em>.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-1.png"><img class="double" src="/www/img/example1-1.png"></a><a target="_blank" href="/www/img/example1-2.png"><img class="double" src="/www/img/example1-2.png"></a></div>
      </div><hr>  
      <div class="row">
      	<div class="span4"><p>"Your Selected Parameters" shows the attribute & value that you have selected.  (You can remove an attribute from the search by clicking on the "X").</p></div>
      	<div class="span7"><a target="_blank" href="/www/img/example1-3.png"><img class="single" src="/www/img/example1-3.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>2. Select the next attribute & value:</strong> Under "Select Attribute", now choose <em>Narrative Level</em>. Select the value <em>NF1</em>, which represents the main narrator:</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-4.png"><img class="double" src="/www/img/example1-4crop.png"></a><a target="_blank" href="/www/img/example1-5.png"><img class="double" src="/www/img/example1-5.png"></a></div>
      </div><hr>
      <div class="row">
      	<div class="span4"><p>"Your Selected Parameters" shows the 2 sets of attributes & values that you have selected..</p></div>
      	<div class="span7"><a target="_blank" href="/www/img/example1-6.png"><img class="single" src="/www/img/example1-6.png"></a></div>
      </div><hr>      
      <div class="row">
        <div class="span4"><p><strong>3. Select the final attribute & value:</strong> Select the attribute <em>Type of Speech Represented</em> and the value <em>FID</em> for "free indirect speech":</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-7.png"><img class="double" src="/www/img/example1-7crop.png"></a><a target="_blank" href="/www/img/example1-8.png"><img class="double" src="/www/img/example1-8.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>4. Click search.</strong> You may have to wait a few seconds for the results to appear.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-9.png"><img class="single" src="/www/img/example1-9.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p>The results page will list the 10 speeches that match your search parameters. Click the "view" button next to a speech to see the full text and information about that speech.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-10.png"><img class="single" src="/www/img/example1-10crop.png"></a></div>
      </div><hr>       
      <div class="row">
        <div class="span4"><p>While viewing an individual speech entry, you can page through the rest of the results using the "Prev Speech" and "Next Speech" buttons, or return to the full set of results with the "All Results" button.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example1-11.png"><img class="single" src="/www/img/example1-11crop.png"></a></div>
      </div><hr>
    </div>
    </div>
</div>

<a class="sample">&#x25BC; All speeches with statements presented by <strong>characters</strong> in all modes of speech presentation <strong>except direct quotation</strong> <span style="color:#333333;">(searching with the "omit" function)</span></a>
<div class="sample-inner">
    <div class="row">
    <div class="span11">
      <div class="row">
        <div class="span9"><p>You can search for speeches that don't match a particular value by selecting the "omit" option before selecting the value. This search involves the attributes <strong>Narrative Level</strong> and <strong>Type of Speech Represented</strong>.</p></div>
        <div class="span1"></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>1. Select the first attribute & value:</strong> Under "Select Attribute", choose <em>Narrative Level</em> and select the value <em>NF2</em> which represents characters:</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example2-1.png"><img class="double" src="/www/img/example2-1crop.png"></a><a target="_blank" href="/www/img/example2-2.png.png"><img class="double" src="/www/img/example2-2.png"></a></div>
      </div><hr>  
      <div class="row">
      	<div class="span4"><p>"Your Selected Parameters" shows the attribute & value that you have selected.  (You can remove an attribute from the search by clicking on the "X").</p></div>
      	<div class="span7"><a target="_blank" href="/www/img/example2-3.png"><img class="single" src="/www/img/example2-3.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>2. Select the next attribute & omit the selected value:</strong> Under "Select Attribute", now choose the attribute <em>Type of Speech Represented</em>. Under "Select a Value to Search By", first select <em>omit</em>, then select the value <em>direct quotation</em>.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example2-4.png"><img class="triple" src="/www/img/example2-4crop.png"></a><a target="_blank" href="/www/img/example2-5.png"><img class="triple" src="/www/img/example2-5.png"></a><a target="_blank" href="/www/img/example2-6.png"><img class="triple" src="/www/img/example2-6.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p>"Your Selected Parameters" shows the attributes and values that have been selected. The second value indicates the "Omit" option.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example2-7.png"><img class="single" src="/www/img/example2-7.png"></a></div>
      </div><hr>   
       <div class="row">
        <div class="span4"><p><strong>4. Click search.</strong> You may have to wait a few seconds for the results to appear. The results page will show the 718 speeches that match these parameters. Click the "view" button next to a speech to see the full text and information about that speech.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example2-8.png"><img class="single" src="/www/img/example2-8crop.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p>While viewing an individual record, you can page through the list of results using the "Prev Speech" and "Next Speech" buttons or return to the full set of results with the "All Results" button.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example2-9.png"><img class="single" src="/www/img/example2-9crop.png"></a></div>
      </div><hr>
      </div>
    </div>
</div>

<a class="sample">&#x25BC; All speeches <strong>longer than 10 lines</strong> spoken by <strong>Hector</strong> <span style="color:#333333;">(searching with a range of values)</span></a>
<div class="sample-inner">
    <div class="row">
    <div class="span11">
      <div class="row">
        <div class="span9"><p>For certain attributes involving numbers, you can search over a range of values. This search involves the attributes <strong>Length</strong> and <strong>Speaker</strong>.</p></div>
        <div class="span1"></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>1. Select the first attribute & value:</strong> Under "Select Attribute", choose <em>Length</em>. To enter the range of vaules, select <em>11</em> for the first value and <em>1471</em> (the highest available option) for the second value:</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example3-1.png"><img class="triple" src="/www/img/example3-1crop.png"></a><a target="_blank" href="/www/img/example3-2.png"><img class="triple" src="/www/img/example3-2.png"></a><a target="_blank" href="/www/img/example3-3.png"><img class="triple" src="/www/img/example3-3crop.png"></a></div>
      </div><hr>  
      <div class="row">
      	<div class="span4"><p>"Your Selected Parameters" shows the attribute & value that you have selected, with the range indicated. (You can remove an attribute from the search by clicking on the "X".)</p></div>
      	<div class="span7"><a target="_blank" href="/www/img/example3-4.png"><img class="single" src="/www/img/example3-4.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p><strong>2. Select the next attribute & omit the selected value:</strong> Under "Select Attribute", now choose the attribute <em>Speaker</em> and the value <em>Hector</em>:</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example3-5.png"><img class="double" src="/www/img/example3-5crop.png"></a><a target="_blank" href="/www/img/example3-6.png"><img class="double" src="/www/img/example3-6.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p>"Your Selected Parameters" shows the attributes and values that have been chosen. Click "search".  You may have to wait a few seconds for the results to appear.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example3-7.png"><img class="single" src="/www/img/example3-7.png"></a></div>
      </div><hr>
      <div class="row">
        <div class="span4"><p>The results page will show the 16 speeches that match these parameters. Click the "view" button next to a speech to see the full text and information about that speech.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example3-8.png"><img class="single" src="/www/img/example3-8crop.png"></a></div>
      </div><hr>      
      <div class="row">
        <div class="span4"><p>While viewing an individual record, you can page through the list of results using the "Prev Speech" and "Next Speech" buttons or return to the full set of results with the "All Results" button.</p></div>
        <div class="span7"><a target="_blank" href="/www/img/example3-9.png"><img class="single" src="/www/img/example3-9crop.png"></a></div>
      </div><hr>   
  </div><!-- .span11 -->      
    </div>
    </div><!-- .sample-inner -->
</div><!-- #examples -->

</div>

{% endblock %}
