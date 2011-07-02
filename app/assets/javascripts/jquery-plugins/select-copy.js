
jQuery.fn.selectCopy = function(options) {
  var options = jQuery.extend( {
    always_overwrite: false,
    downcase: true,
    umlaute: 'true', 
    limit: /[^a-z0-9-]/g
  },options);

  $(this[0]).bind("keydown keypress keyup", function(e){
    var str = $(this).val()
    if (options.downcase) { str= str.toLowerCase(); }
    if (options.umlaute)  { str= str.replace(/ü/g,'ue').replace(/ä/g,'ae').replace(/ö/g,'oe').replace(/ß/g,'ss') }
    if (options.limit != false) { str = str.replace(options.limit,''); }
    $(options.target).val(str);
  })

};
