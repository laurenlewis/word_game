// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require websocket_rails/main

var dispatcher = new WebSocketRails('localhost:3000/websocket');
var channel = dispatcher.subscribe('updates'); 

dispatcher.on_open = function(data) {  
  console.log('Connection has been established: ', data);
  dispatcher.trigger('hello', 'Hello, there!');
}

// 'update' Event from the Server
channel.bind('update', function(msg) {  
  console.log(msg);
});

// 'new_round' Event from the Server
channel.bind('new_round', function(phrase) {
  // Replace .phrasebox inner html with the phrase
  $(".phrasebox").html(phrase);  

  // Show the phrase container and hide the start button
  $(".phrase_container").show();
  $(".start_container").hide();
});

$(document).ready(function() {
	$(".start_container").on("click", function() {
		dispatcher.trigger('start_round', 'Start round.');
	});

  $(".phrase_wrapper .btn").on("click", function() {
    dispatcher.trigger('start_round', 'Start round.');
  });
});

