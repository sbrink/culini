//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-plugins/formnavigator
//= require jquery-plugins/facebox
//= require jquery-plugins/autogrowtextarea

function check_days(name,type) {
  $('#'+name+'_monday')   .attr('checked', (type == "weekend") ? "" : "checked");
  $('#'+name+'_tuesday')  .attr('checked', (type == "weekend") ? "" : "checked");
  $('#'+name+'_wednesday').attr('checked', (type == "weekend") ? "" : "checked");
  $('#'+name+'_thursday') .attr('checked', (type == "weekend") ? "" : "checked");
  $('#'+name+'_friday')   .attr('checked', (type == "weekend") ? "" : "checked");
  $('#'+name+'_saturday') .attr('checked', (type == "workday") ? "" : "checked");
  $('#'+name+'_sunday')   .attr('checked', (type == "workday") ? "" : "checked");
  $('#'+name+'_holiday')  .attr('checked', (type == "workday") ? "" : "checked");
}

$(document).ready(function () {
  var csrf_token = $('meta[name=csrf-token]').attr('content'),
      csrf_param = $('meta[name=csrf-param]').attr('content');

  // load cart  
  $.ajax({ url: $('meta[name=shop_url]').attr('content')+"/cart", dataType: 'script', type: 'GET' });
  
	//$("#categories").sortable({ items: 'tr', axis: 'y', handle: '.reorder'});
	$("ul.sortable[data-sortable]").sortable({ 
	  axis: 'y',
	  update: function(event, ui) {
      $.ajax({ type: "POST",
          url: '/'+$(this).attr('data-sortable')+'/sort',
          data: '_method=put&'+csrf_param+'='+csrf_token+'&'+$(this).sortable('serialize')
      });
    }
	});

	$("table.sortable[data-sortable]").sortable({ 
	  axis: 'y',
	  items: 'tr',
	  containment: 'parent',
	  update: function(event, ui) {
      $.ajax({ type: "POST",
          url: '/'+$(this).attr('data-sortable')+'/sort',
          data: '_method=put&'+csrf_param+'='+csrf_token+'&'+$(this).sortable('serialize')
      });
    }
	});

  $("td[data-href]").live('click', function () {
    $.ajax({ type: $(this).attr('data-method')||'GET', url: $(this).attr('data-href') });
  });
  
  
   
  $("#cart_and_hours").resizable({ maxWidth: 302, minWidth: 302, minHeight: 180 });
  
  
  $('.checkout').live('click',function (e) {
    if ($('.cart_article').length == 0) {
      alert('Warenkorb leer!');
      e.preventDefault();
    }  
  });


  
  $(document).mouseup(function(e) {
      if($(e.target).parents(".cart").length==0) {
          $('.cart_extras_cart_article').hide();
      }
  });            
  
  $('#order_postcode').blur(function() {
    if($('#order_city').val() == "") {
      $.getJSON('checkout/search.json?postcode='+$('#order_postcode').val(), function(data) {
        $('#order_city').val(data.city);
      });
    }
  });

  
  // 
  // Datepicker
  // 
  $.datepicker.regional['de'] = {
		closeText: 'schließen',
		prevText: '&#x3c;zurück',
		nextText: 'Vor&#x3e;',
		currentText: 'heute',
		monthNames: ['Januar','Februar','März','April','Mai','Juni',
		'Juli','August','September','Oktober','November','Dezember'],
		monthNamesShort: ['Jan','Feb','Mär','Apr','Mai','Jun',
		'Jul','Aug','Sep','Okt','Nov','Dez'],
		dayNames: ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
		dayNamesShort: ['So','Mo','Di','Mi','Do','Fr','Sa'],
		dayNamesMin: ['So','Mo','Di','Mi','Do','Fr','Sa'],
		weekHeader: 'Wo',
		dateFormat: 'yy-mm-dd',
		firstDay: 1,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['de']);

  $("#datepicker").datepicker({ 
    altField: '#reservation_booked_on', 
    altFormat: 'yy-mm-dd',
    minDate: "0",
    maxDate: "+1y",
    defaultDate: $('#reservation_booked_on').val()
  });

		

  $("#category_category_image_id").change(function () {
    if ($(this).val() === "") {
     $('#category_image').removeClass('category_image');
     $('#category_image').css('background-image',''); 
    } else {
     $('#category_image').addClass('category_image');
     $('#category_image').css('background-image','url(/system/category_images/'+$(this).val()+'/original.jpg)'); 
    }
  }).change();
  
  
  
  

  if ($("#order_status").length == 1) {
    $('#order_status').append('jo');

    function timedRefresh(timeoutPeriod) {
      $.getJSON($(this).attr('data-url'), function(data) {
        
        $('#order_status').append(data.status_id);
      });
      setTimeout(timedRefresh,1000);
    }
    timedRefresh(1000);
  
  }
 
 $('#order_address_details, #category_description').autoGrow();
;});


