document.addEventListener('DOMContentLoaded', function () {
	var sampleLinks = document.querySelectorAll('a.sample');
	sampleLinks.forEach(function (sampleLink) {
		sampleLink.addEventListener('click', function () {
			var sampleInner = this.nextElementSibling;
			sampleInner.classList.toggle('sample-inner');
			sampleInner.style.display = sampleInner.style.display === 'none' ? '' : 'none';
			this.classList.toggle('activecolor');
		});
	});

	var sampleInnerDivs = document.querySelectorAll('div.sample-inner');
	sampleInnerDivs.forEach(function (sampleInnerDiv) {
		sampleInnerDiv.style.display = 'none';
	});

	var selectAttr = document.getElementById('select_attr');
	if (selectAttr) {
		selectAttr.addEventListener('change', function (e) {
			var selectedOption = this.options[this.selectedIndex];
			var handler_url = '/search/' + selectedOption.getAttribute('class') + '/count?' + new URLSearchParams({
				attr: selectedOption.getAttribute('id'),
			});

			fetch(handler_url, {
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
				},
			})
				.then(function (response) {
					return response.text();
				})
				.then(function (hresp) {
					document.getElementById('hresp').innerHTML = hresp;
				})
				.catch(function (error) {
					console.error('Error:', error);
				});
		});
	}
});
