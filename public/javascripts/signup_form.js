function verifyLoginLoad() {
  jQuery('#user_login').removeClass('available unavailable valid validated invalid checking').addClass('checking');
  jQuery('#url-check').html('<p><span class="checking"><%= _('Checking availability of login name...') %></span></p>');
}

function verifyLoginAjax(value) {
  verifyLoginLoad();

  jQuery.get(
    "/account/check_valid_name",
    {'identifier': encodeURIComponent(value)},
    function(request){
      jQuery('#user_login').removeClass('checking');
      jQuery("#url-check").html(request);
    }
  );
}

jQuery(document).ready(function(){
  jQuery("#user_login").blur(function(){
    verifyLoginAjax(this.value);
  });
});
