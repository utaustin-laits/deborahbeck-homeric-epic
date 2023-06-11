{% extends "framework/bootstrap.tpl" %}

{% block content  %}

<div class="well">
  <div class="container-fluid">
  <div class="row-fluid">
  
<div class="span8" id="about_site">
    <h2 class="center">About the Database</h2>

    <p>Digital humanities have rich and largely unexplored potential for philological research in Classics.  
    I hope that making my database of all the speeches presented in the Homeric epics available online 
    will offer a specific example of how new technological tools can enable Classicists to develop 
    innovative and fruitful approaches to the enduring questions that are central to our discipline.  
    My book, <a href="http://utpress.utexas.edu/index.php/books/becspe" target="_blank"></em>Speech Presentation in Homeric Epic</em></a> 
    (University of Texas Press, 2012), explores how various ways of depicting speech shape the narratives in the Homeric poems; 
    similarly, this database and the kinds of questions it allowed me to ask has shaped the scholarly 
    narrative in my book. I hope that making it directly available to all will shape future scholarly 
    inquiries, and that users of the database will tell me how they have used it and what kinds of 
    questions it has helped them to explore. 
    </p>

    <p>The origins of the database, as a personal research tool developed incrementally over a long period 
    of time, led the design in somewhat different directions than it would have gone if broad user-friendliness 
    had been a top priority from the beginning.  I hope that this online database - unlike my personal 
    FileMaker 9-generated version - is clear and straightforward to use, for which I owe warm thanks to the 
    <a href="http://www.utexas.edu/cola/laits/" target="_blank">LAITS</a> staff who prepared it for online use, 
    especially Gavin Sellers and Lauren Moore. Moreover, some aspects of the data are formatted differently for the online interface than they were in 
    my FileMaker version; this means that some searches that appear in my book cannot be exactly replicated 
    with the online database. Some kinds of multi-field searches are not yet available at the time of 
    release (July 2013), but we expect to make more kinds of functionality gradually available. If you have 
    requests or suggestions about this, please email me at 
    <a href="mailto:database@utlists.utexas.edu ">database@utlists.utexas.edu</a> - we are eager to make 
    the database as responsive as we can to users' needs.  The database has been proofread to a high, 
    but not a perfect, standard of accuracy.  
    </p>
    
    <p>The <a href="notes">user notes</a> are intended to complement the section of the book's introduction that explains how the 
    database was constructed (introduction available <a href="/www/img/book_text.pdf" target="_blank">here</a>).
    A series of screen shots under <a href="examples">examples</a> illustrate a few sample searches as a way of explaining 
    how the online interface works, and what kinds of searches it is most suited to explore. 
    </p>
    
    <h2 class="center">Raw Data and Source Code</h2>

    <p class="large_font">The project's raw data is available for download as part of our GitHub repository, at 
    <a href="https://github.com/utaustin-laits/deborahbeck-homeric-epic">https://github.com/utaustin-laits/deborahbeck-homeric-epic</a></p>
    
    <h2 class="center">Comments, Questions, Suggestions</h2>

    <p class="large_font">Please contact Dr. Deborah Beck at <a href="mailto:database@utlists.utexas.edu">database@utlists.utexas.edu</a></p>
</div><!-- span8 -->
    
<div class="span4" id="about_book">
  <div class="span_inner">
  <a href="http://utpress.utexas.edu/index.php/books/becspe" target="_blank"><img alt="Book Cover" src="/www/img/book_cover.jpg" id="book_cover"></a>
  <blockquote class="speech">
      <p>"This book represents an original approach to Homeric speech, makes excellent new points ... and offers data no one has previously presented."</p>
      <small>Ruth Scodel, D. R. Shackleton Bailey Collegiate Professor of Greek and Latin, University of Michigan</small>
  </blockquote>
  </div>
</div><!-- span4 -->

</div></div>
</div><!-- well -->



{% endblock %}
