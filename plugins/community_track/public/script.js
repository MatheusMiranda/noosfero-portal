(function($, undefined) {
  $(document).ready(function() {
    $('.track-cards-steps').on('click', function(evt) {
      var step = $(this);
      var should_show_content = JSON.parse(step.attr('data-show-content'));

      if (should_show_content) {
        var content = step.parent().children('.track-cards-content');
        content.toggle();
      } else {
        var link = step.children('.track-cards-steps-url');
        window.location.href = link.attr('href');
      }
    });
  });
}) (jQuery);
