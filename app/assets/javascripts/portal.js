//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-plugins/formnavigator
//= require application

$(document).ready(function () {   
    
  $("#q").autocomplete({
		source: function(request, response) {
			$.ajax({
				url: "/search/autocomplete",
				dataType: "json",
				data: {
					q: request.term
				},
				success: function(data) {
				  //data.length
					response($.map(data, function(item) {
						return {
							label: (item.postcode ? item.postcode+ " " : "") + item.city + (item.area ? " ("+item.area+")" : ""),
							value: (item.postcode ? item.postcode+ " " : "") + item.city + (item.area ? " ("+item.area+")" : "")
						}
						this.menu.first();
					}))
				}
			})
		},
		minLength: 1,
		open: function() { 
    	var	menu = $(this).data("autocomplete").menu;
    	menu.activate($.Event({ type: "mouseenter" }), menu.element.children().first() );
		},
		select: function(event, ui) {
		  //var item = ui.item.data( "item.autocomplete" ),
		  //$(this).form.submit();
		  this.value = ui.item.label
		  self.close( event );
		  $(this.form).submit();

		  //$("#q").form.submit();
		  //$.inspect(this.value);
			//alert(ui.item ? ("Selected: " + ui.item.label) : "Nothing selected, input was " + this.value);
		}
	});
    

    $('#navigation li').hover(  
      function () { $('ul', this).slideDown(50); $('> a', this).addClass('selected'); },
      function () { $('ul', this).slideUp(50); $('> a', this).removeClass('selected'); }
    );  
  
});
