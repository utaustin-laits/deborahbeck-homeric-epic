var Dase = {};

$(document).ready(function() {
	Dase.initToggle('target');
	Dase.initToggleCheck();

    Dase.initToggleSample();         
    
    $('div.sample-inner').hide();
});



Dase.initToggleCheck = function() {
	var checked = false;
	$('#toggle_check').click(function() {
		if (checked) {
			$('table#items').find('input[type="checkbox"]').attr('checked',false);
			checked = false;
		} else {
			$('table#items').find('input[type="checkbox"]').attr('checked',true);
			checked = true;
		}
		return false;
	});
};



Dase.initToggle = function(id) {
	$('#'+id).find('a[class="toggle"]').click(function() {
		var id = $(this).attr('id');
		var tar = id.replace('toggle','target');
		$('#'+tar).toggle();
		return false;
	});	
};


Dase.initToggleSample = function() {
	$('div.sample-inner').hide();
    $('a.sample').click(function(){
    	$(this).next('div.sample-inner').toggle('300');
    	$(this).toggleClass('activecolor');
    });
};

