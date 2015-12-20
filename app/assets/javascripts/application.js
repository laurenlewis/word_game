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
var roundSubmissions = [];
var roundPhrase = "";

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
  // Reset submissions for the new round
  roundSubmissions = [];
  roundPhrase = "";

  // Replace .phrasebox inner html with the phrase
  $(".phrasebox").html(phrase);
  roundPhrase = phrase;

  // Show the phrase container and hide the start button
  $(".phrase_container").show();
  $(".start_container").hide();
});

// 'add_phrase' Event from the Server
channel.bind('add_phrase', function(data) {  
  roundSubmissions.push(data);
});

// 'display_submissions' Event from the Server
channel.bind('display_submissions', function(msg) {  
  console.log("Display Submissions!");
});

$(document).ready(function() {
	$(".start_container").on("click", function() {
		dispatcher.trigger('start_round', 'Start round.');
	});

  $(".phrase_wrapper .btn").on("click", function(e) {
    e.preventDefault();
    var phraseEnding = $('#phrase_ending').val();
    var message = {
      'id': channel.connection_id,
      'phraseEnding': phraseEnding
    };

    // Send message and id to server
    dispatcher.trigger('submit_phrase_ending', message);

    // Change html of phrase container
    $(".phrase_container").html('Waiting on other players...');

    // $(".phrase_container").html(roundSubmissions);
  });
});

