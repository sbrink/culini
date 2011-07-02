$(document).ready ->

  #
  # Form navigation
  #
  $(':input:not(.ui-autocomplete-input)').formNavigator()

  #
  # Form error handling
  #
  $('.field_with_errors input')
    .focus(-> $(this).parent().parent().find('.error').css('visibility','visible'))
    .blur(-> $(this).parent().parent().find('.error').css('visibility','hidden'))

  #
  # Focus
  #
  if $('.field_with_errors').length == 0
    $('.focus').focus();
  else
    $('.field_with_errors input').first().focus();

  #
  # Checkbox
  #
  $('input[type=checkbox][data-href]').click ->
    $.ajax
      url: $(this).attr('data-href'),
      data: csrf_param+'='+csrf_token+'&character[enabled]='+$(this).attr('checked'),
      type: 'PUT'

  #
  # Flash fader
  #
  setTimeout(
    -> $(".flash").fadeOut("slow", -> $(this).remove()), 
    2000
  )

  $.getScript(
    ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js',
    ->
      pageTracker = _gat._getTracker($('meta[name="ga-ua"]').attr('content'))
      pageTracker._trackPageview()
  )