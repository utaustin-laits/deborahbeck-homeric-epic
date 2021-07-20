{% extends "framework/bootstrap.tpl" %}

{% block content  %}

<div class="well">

<div class="container-fluid">
<div class="row-fluid">

<div class="span12">
<h1 class="center">User Notes</h1>

    <p>These user notes are intended to complement the <a href="/www/img/book_text.pdf" target="_blank">section of the book's introduction</a> that explains how the
    database was constructed. A series of screen shots under <a href="examples">examples</a> illustrate a few sample searches as a way of explaining 
    how the online interface works, and what kinds of searches it is most suited to explore. 
    </p>


<ul class="tips">
    <li><strong>The specific attributes</strong> of a given result of a particular search are presented in slightly varying orders, depending on which kind of view the user has selected.  The default view in which all search results are listed gives the work, the book number, the start and end verse, and the speaker(s) and addressee(s) of each speech.  If the user clicks on the "more" button below each search result, all the attributes will be listed.  If the user clicks on the "view" button, the same attributes will be given, but the sequence of some attributes will be different.  In particular, under the heading of "participants," the speaker and addressee are grouped under "role," the names of these actors are listed under "agent," and the genders of these characters are listed under "gender."  The "speech act" heading provides information about speech act type, subtype and move.  Speeches containing more than one move will have two sets of data given as "act 1" and "act 2."</li>
	<li><strong>Different verbs of speaking</strong> in non-direct and NF2 speech presentation are considered <strong>different speech acts</strong> (because that's the way I counted for NF1 direct), even though sometimes they are in fact different moves in the same speech.  However, the SAME speech verb repeated is treated as presenting a single speech, as in <em>Od.</em> 13.173-77, whose unity as a single speech is emphasized by the speech conclusion ὣς ἀγόρευ’ at 13.178.</li>
	<li><strong>tis</strong> as the identity of a speaker is in English characters; if the verse includes a partitive gentitive, the "Speaker" field will say  <em>tis Greek</em>  or <em>tis suitor</em>  etc.</li>
	<li><strong>tines</strong> is used for the plural of "tis"</li>
</ul>
<h3 class="center">Tips for using the Online Database</h3>
<ul class="tips">
	<li><strong>Attributes and Values:</strong> For several of the speech attributes (Book Number, Length, Start Verse, and End Verse), you can select a range of values.  For the remaining attributes, select a single value per attribute to include or omit in your search. The number in parentheses after the value represents the total number of speeches in the database with that value.</li>
	<li><strong>Include vs. Omit:</strong> For each selected value (or range of values), you may choose to either include or omit that value in the search results.  Make sure to select "include" or "omit" <strong><em>before</em></strong> selecting the value; the search engine is set to "include" by default. </li>
	<li><strong>Save a set of search results</strong> by bookmarking the url in your browser.</li>
	<li>There is <strong>no limit on the number of different attributes</strong> that can be selected for a search.  However, the more complex searches may take several seconds for the results to appear.</li>
</ul>

<h2 class="center">Glossary</h2>

<p id="gloss-intro">The glossary defines a small number of terms that are redefined in this database compared to their definitions in the book. It also gives very brief definitions of the most commonly used terms, to assist users in creating their searches. These definitions can be accessed anywhere on the site that you see the <a>&#x25BC; Glossary</a> link. If you click on that link, it will expand to display the definitions as given here. More extensive discussions of this terminology can be found in the <a href="/www/img/book_text.pdf" target="_blank">book's introduction</a>.</p>

<p><strong style="text-decoration: underline;">Gender and number of speakers and addressees</strong></p>
<p><em>General note:</em> Gender- and number-related terms are different from the ones I used in my FileMaker database and in the book. In my FileMaker database, I coded gender and number separately from one another. In the online version of the database, that approach proved to be unworkable, and number is a consistent quality of each character.  For instance, in FileMaker, I coded "Achilles" as "masc" if he were the only addressee, but "pl" if he and Patroclus were addressed together.  In this database, in contrast, "Achilles and Patroclus" as addressees are coded as "masc masc."  The several terms used for collective plurals are explained below.</p>
<ul class="glossary"> 
  <li><strong>masc</strong> = single masculine speaker or addressee</li> 
  <li><strong>fem</strong> = single feminine speaker or addressee</li>
  <li><strong>unspec (gender)</strong> = speaker or addressee whose gender is not stated and which is not clear from the context.<br>
      unspec is also used as the name of a speaker or addressee, where it may have various genders (masc, unspec, pl masc, pl unspec)</li>
  <li><strong>pl masc</strong> = a group of men, such as "Greeks" or "suitors (of Penelope)"</li>
  <li><strong>pl fem</strong> = a group of women, such as "maidservants" or "nymphs"</li>
  <li><strong>pl mixed</strong> = a group composed of both men and women, such as "gods" or "parents"</li>
  <li><strong>pl unspec</strong> = an addressee whose gender composition is unclear, but which context implies to be a group rather than an individual</li>
</ul>

<p><strong style="text-decoration: underline;">Levels of Narration:</strong> variables related to whether the narrator of a speech is a character or the main narrator.</p>
<ul class="glossary">
  <li><strong>NF1 = main narrator </strong></li>
  <li><strong>NF2 = character narrator</strong><br>
        NF2 speeches in <em>Odyssey</em> 9-12 have only "Odysseus/masc" in the "speaker of enclosing/gender" fields</li>
  <li><strong>NF3 = narrator is a character whose speech is presented within another chatracter's speech </strong><br>
        NF3 has as "enclosing speech" the NF1 speech, not the NF2 speech, but speeches that appear within speeches quoted by Odysseus in <em>Odyssey</em> 9-12 give the info on the NF2 speech in the "enclosing speech" fields</li>
  <li>NF1 + 2 is for speech where the narrator and narrative level are not clear (in Demodocus' songs in <em>Odyssey</em> 8 and the scar story in <em>Odyssey</em> 19); these do not have any "enclosing speech" information due to their unclear narrative level</li>
</ul>
	    
<p><strong style="text-decoration: underline;">Subordinate clause:</strong> any word or phrase grammatically dependent on a verb of speaking</p>

<p><strong style="text-decoration: underline;">Type of Speech Represented</strong></p>
<ul class="glossary">
  <li><strong>direct quotation:</strong> speech presented from the point of view of the speaker; deictic words reflect speaker’s perspective</li>
  <li><strong>indirect speech:</strong> speech presented from the point of view of the reporter; deictic words reflect reporter’s perspective</li>
  <li><strong>speech mention:</strong> speech presented from the point of view of the reporter; does not provide the specific words of the speech</li>
  <li><strong>FID:</strong> (Free Indirect Discourse) speech presentation that includes features of both direct quotation and indirect speech</li>
</ul>

<p><strong style="text-decoration: underline;">Speech Act Type</strong></p>
<ul class="glossary">
  <li><strong>directive:</strong> a speech act about action</li>
  <li><strong>assertive:</strong> a speech act about facts, tends to be oriented toward the speaker</li>
  <li><strong>expressive:</strong> a speech act about emotions</li>
  <li><strong>interrogative:</strong> a speech act about facts, tends to be oriented toward the addressee</li>
</ul>
    
<p><strong style="text-decoration: underline;">Speech Act Subtype:</strong> for definitions of speech act subtypes, see <a target="_blank" href="/www/img/book_text.pdf">Introduction,</a> pp. 14-18</p>
 
<p><strong style="text-decoration: underline;">Move</strong></p>
<ul class="glossary">
  <li><strong>initial:</strong> a speech act that begins a conversational exchange</li>
  <li><strong>reactive:</strong> a speech act that responds to a previous move</li>
  <li><strong>problematic:</strong> a speech act that responds to a previous move by challenging or disobeying it</li>
</ul>	
	

</div></div> 

</div></div>

</div>
{% endblock %}



