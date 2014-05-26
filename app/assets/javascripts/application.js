// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require best_in_place
//= require dataTables/jquery.dataTables
//= require bootstrap
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require modernizr
//= require masonry/jquery.loremimages.min
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js
//= require bootstrap-timepicker
//= require jquery.colorbox
//= require jquery.colorbox-pl
//= require tinymce

//= require_tree .


$(document).ready(function() {
  /* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  $('.best_in_place').bind('ajax:success', function(){ this.innerHTML = this.innerHTML.replace(/\n/g, '<br />') });

  
});
	 $(".confirm").on( 'click', function () {
    var user_trash = this
    alertify.confirm("Are you sure to delete", function (e)   {
        if (e) {
          
          window.location.href = user_trash.href
        } else {
          
        }
    });
    return false;
  });
function hasHtml5Validation () {
  return typeof document.createElement('input').checkValidity === 'function';
}
 
if (hasHtml5Validation()) {
  $('.validate-form').submit(function (e) {
    if (!this.checkValidity()) {
      e.preventDefault();
      $(this).addClass('invalid');
      $('#status').html('invalid');
    } else {
      $(this).addClass('valid');
      $('#status').html('submitted');
    }
  });
}


