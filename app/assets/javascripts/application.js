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
//= require jquery.facebox
//= require jquery.timepicker.js

$(function() {

    $('header #bookmark').click(function() {
	if (parseInt($(this).css('top')) == 0) {
	    $(this).animate({ top: '-20px' });
	    $('header #search-bar').animate({ height: "toggle" });
	} else {
	    $(this).animate({ top: 0 });
	    $('header #search-bar').animate({ height: "toggle"});
	}
    });

    var img = $('#user_image').val();
    $('.img').attr("src", '/assets/'+ img);

    $('#user_image').change(function () {
	var img = $('#user_image').val();
	$('.img').attr("src", '/assets/' + img);
    });

});
