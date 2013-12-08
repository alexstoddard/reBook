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
//= require jquery.timepicker.js
//= require jquery-ui-1.10.3.custom.js
//= require fancybox


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

    var img = $('#imgsection #user_image').val();
    $('#imgsection .img').attr("src", '/assets/'+ img);

    $('#imgsection #user_image').change(function () {
	var img = $('#imgsection #user_image').val();
	$('#imgsection .img').attr("src", '/assets/' + img);
    });

});
