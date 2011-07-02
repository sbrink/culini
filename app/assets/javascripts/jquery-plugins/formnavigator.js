(function($){

  $(document).bind('keydown', function(e) {
    if ((e.metaKey || e.ctrlKey) && e.which == 78) { // CTRL/META-N
      $('[accesskey="n"]:first').click();
      e.preventDefault();
    }
    if ((e.metaKey || e.ctrlKey) && e.which == 69) { // CTRL/META-E
      $('[accesskey="e"]:first').click()
      e.preventDefault();
    }
  })
  
  $.fn.formNavigator = function(){
    $(this).live('keydown', function(e) {
  
      var fields = $(this.form).find(':input:not(:hidden)');
      var index = fields.index(this);

      if((e.metaKey || e.ctrlKey) && e.which == 83) { // CTRL/META-S
        $(this.form).submit();
        e.preventDefault();
      }

      if(e.which === 27) { // ESCAPE
        $(this.form).find('.cancel:first').click();
        e.preventDefault();
      }

      if(e.which === 37) { // LEFT
        if (this.tagName == 'SELECT' && index > 0) { fields[index-1].focus(); }
      }

      if(e.which === 38) { // UP
        if ($(this).val().indexOf('\n') === -1 || $(this).val().indexOf('\n') > this.selectionStart) {
          if (!event.shiftKey && index > 0) { fields[index-1].focus(); }
        }
      }

      if(e.which === 39) { // RIGHT
        if (this.tagName == 'SELECT' && index < fields.length) { fields[index+1].focus(); }
      }

      if(e.which === 40) { // DOWN
        if (this.tagName != 'TEXTAREA' || $(this).val().indexOf('\n',this.selectionStart) === -1) {
          if (!event.shiftKey && index < fields.length) { fields[index+1].focus(); }
        }
      }
    });
  }


})(jQuery);

