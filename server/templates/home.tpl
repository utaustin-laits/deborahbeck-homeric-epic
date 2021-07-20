
{% extends "framework/bootstrap.tpl" %}

{% block header %}{% endblock %}

{% block main %}
<div class="navbar clearfix" id="home">
  <div class="navbar-inner">
  <div class="container">
    <div id="inner-border">
    <div id="inner-border2">
      <div class="clearfix">
  	<a class="main" href="#">
        <span id="subtitle">A Companion Website & Database for</span>  	
        Speech<br>
        Presentation<br>
        in<br>
        Homeric<br>
        Epic<br>
  	</a>
      </div>
      
      <ul class="nav" id="main-nav">
          <li><a href="/search">Search</a></li>
          <li>||</li>
          <li><a href="/about">About</a></li>
          <li>||</li>
	  <li><a href="/notes">User Notes</a></li>
	  <li>||</li>
	  <li><a href="/examples">Examples</a></li>
      </ul>
    <img id="quote" alt="quote" src="/www/img/quote.png">
    <div id="splash_background"><img id="face" alt="face" src="/www/img/face.png"></div>
    
    </div>
    </div>
  </div>
  </div>
</div><!-- home -->

{% endblock %}


