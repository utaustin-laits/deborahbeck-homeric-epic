<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">

        <title>Speech Presentation in Homeric Epic</title>

        <!-- Le styles -->
        <link href="/www/css/bootstrap.css" rel="stylesheet">
        <link href="/www/css/bootstrap-responsive.css" rel="stylesheet">
        <link href="/www/css/local.css" rel="stylesheet">

        {% block head %}{% endblock %}
        <script src="/www/js/script.js"></script>
        <!-- Google analytics for UA-68482108-1 see utlaits@gmail.com -->
        <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-68482108-1', 'auto');
  ga('send', 'pageview');

</script>
    </head>

    <body>

        {% block header %}
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">

                  <div id="inner-border">
                  <div id="inner-border2">
                  <div class="clearfix">


                    <div id="brand">
                    <a class="brand" href="/">Speech Presentation in Homeric Epic</a>
                    </div>

                    <div id="links">
                    <ul class="nav" id="main-nav">
			<li><a href="/search">Search</a></li>
			<li> || </li>
			<li><a href="/about">About</a></li>
			<li> || </li>
			<li><a href="/notes">User Notes</a></li>
			<li> || </li>
			<li><a href="/examples">Examples</a></li>
                    </ul>

                    </div>



                    </div><!-- clearfix -->
                    </div>
                    </div><!-- inner-border -->

                  </div>
                </div>
        </div>
        {% endblock %}
	<div class="container">
	{% block table_sub %}{% endblock %}
	</div>
	{% block table %}{% endblock %}
        <div class="container wrapper">
            {% block subheader %}{% endblock %}
            {% block main %}
            {% if msg %}<h3 class="msg">{{ msg }}</h3>{% endif %}
            {% block content %}

            {% endblock %}


            <footer>
            <hr>
            {% block footer %}
            <div class="pull-left">
            <a href="http://www.utexas.edu">The University of Texas at Austin </a>

            </div>
            <div class="pull-right">
            <a id="laits_img" href="http://www.utexas.edu/cola/laits/"></a>
            <a id="laits_credits" href="/about/credits">production team</a>

            </div>
            {% endblock %}
            </footer>

            {% endblock %}
        </div> <!-- /container -->

    </body>
</html>
