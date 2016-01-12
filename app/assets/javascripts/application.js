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

var scoreNeededToWin = 4;
var dispatcher = new WebSocketRails(sheltered-reef-4582.herokuapp.com);
var channel = dispatcher.subscribe('updates'); 
var roundSubmissions = [];
var roundPhrase = "";
var roundVotes = {};
var currentPlayers = [];


dispatcher.on_open = function(data) {  
  console.log('Connection has been established: ', data);
  dispatcher.trigger('hello', 'Hello, there from: '+data.connection_id);
  dispatcher.trigger('new_player', 'Hello player '+data.connection_id);
  $("#unique_id").append(data.connection_id.substring(0, 4));
}

$(document).ready(function() {
  // --- Start Button Click Event ---
	$(".start_container").on("click", function() {
		dispatcher.trigger('start_round', 'Start round.');
	});

  // --- Phrase Submission Click Event ---
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
    $(".dynamic_content").html('Waiting on other players...');
    $(".phrase_wrapper").hide();
  });

  // --- Vote Submission/Click Event ----
  $(".phrase_container").on("click", ".vote_btn", function(){
    var voteForId = $(this).val();

    // Hide Vote Buttons
    $('.vote_btn').hide();

    // Show Vote Counts
    $('.counter').show();

    // Send message about votes to server
    dispatcher.trigger('submit_vote', voteForId);
  });

  // --- Next Round Button Click Event ---
  $(".phrase_container").on("click", ".next_round", function() {
    dispatcher.trigger('start_round', 'Start round.');
  });

});

/**************************************
 * Below are all of our functions for 
 * handling messages from the server
 *************************************/

// - Handle 'update' Event from the Server
channel.bind('update', function(msg) {  
  console.log(msg);
});

// - Handle 'new_round' Event from the Server
channel.bind('new_round', function(phrase) {
  // Reset submissions for the new round
  roundSubmissions = [];
  roundPhrase = "";
  roundVotes = {};

  // Replace .phrasebox inner html with the phrase
  $(".phrasebox").html(phrase);
  roundPhrase = phrase;

  //Clear ".dynamic_content"
  $(".dynamic_content").html(""); 
  $("#phrase_ending").val("");
  $(".phrase_wrapper").show();

  // Show the phrase container and hide the start button
  $(".phrase_container").show();
  $(".start_container").hide();
});

// - Handle 'add_phrase' Event from the Server
channel.bind('add_phrase', function(data) {  
  roundSubmissions.push(data);
});

// - Handle 'display_submissions' Event from the Server
channel.bind('display_submissions', function(msg) {  
  console.log("Display Submissions!");
  $(".dynamic_content").html(""); 
  $(".dynamic_content").css('font-size', '30px');
  $(".dynamic_content").append(roundPhrase + '<br/>' + '<br/>');
    for(var i = 0; i < roundSubmissions.length; i++) {
      $(".dynamic_content").append("<span id='counter-"+roundSubmissions[i].id+"' class='counter'>0</span>");
      $(".dynamic_content").append("<button value='"+roundSubmissions[i].id+"'>Vote</button>" + '   ');
      $(".dynamic_content button").addClass("btn btn-default vote_btn");
      $(".dynamic_content").append(roundSubmissions[i].phraseEnding + '<br/>' + '<br/>');
    };
});

// - Handle 'update_vote_counts' Event from the Server
channel.bind('update_vote_counts', function(voteCounts) {
  for (key in voteCounts) {
    $('#counter-'+key).html(voteCounts[key]);
  }
  roundVotes = voteCounts;
});

channel.bind('compare_vote_counts', function(voteSaves) {


  // Initialize possible Winners
  var possibleWinner = null;
  var possibleWinnerScore = 0;
  var roundIsTied = false;

  for (key in roundVotes) {
    // Update the scorebox divs to reflect new total scores
    var currentScore = $('#consolebox-'+key+' .scorebox').html();
    var newScoreTotal = parseInt(currentScore) + roundVotes[key]; // current score + this new score
    $('#consolebox-'+key+' .scorebox').html(newScoreTotal);

    // Check to see if this is a possible winner
    if (newScoreTotal >= scoreNeededToWin && newScoreTotal > possibleWinnerScore) {
      possibleWinner = key;
      possibleWinnerScore = newScoreTotal;
      roundIsTied = false;
    } else if (newScoreTotal >= scoreNeededToWin && newScoreTotal == possibleWinnerScore) {
      roundIsTied = true;
    }
  }

  // Start Over OR Next Round - if no winner OR if tie
  if (possibleWinner !== null && roundIsTied === false) {
    // Show Congrats to Player_xxxx and Add .winnerbox to their consolebox
    $('#consolebox-'+possibleWinner).addClass("winnerbox");
    $(".dynamic_content").append("<div class='winner'>Congrats to Guest_"+possibleWinner.substring(0,4)+"!</div>");
  } else {
    console.log("Display Next Round Button");
    $(".dynamic_content").append("<a class='btn btn-default next_round disabled' href='#'>Next Round</a>");
    // $(".nextround").css('')
    setTimeout(function(){
      $(".next_round").removeClass("disabled");
    }, 5000);
  }
});

/*Got var players from handle_new_player method, at the top defined empty array currentPlayers.
Looping through, we're looking through currentPlayers(indexing) to see if players[i] is there. 
If not, the index value is -1, & it will add players[i] to the currentPlayers array, and then add a new div for that player.*/
channel.bind('announce_new_player', function(players) {
  console.log("Announced new player");
  for(var i = 0; i < players.length; i++) {
    if (currentPlayers.indexOf(players[i]) < 0) {
      currentPlayers.push(players[i]);
      $(".sidebar").append("<div id='consolebox-"+players[i]+"' class='consolebox'><div class='scorebox'>0</div><p class='player'>"+"Guest_"+players[i].substring(0, 4)+"</p></div>");
    }
  }
});
/*Similiar to above, just swapping players & currentPlayers since now players is a variable that contains the remaining players, 
whereas currentPlayers still contains the extra id(s) of the player who left. */
channel.bind('announce_player_exit', function(players) {
  for(var i = 0; i < currentPlayers.length; i++) {
    if (players.indexOf(currentPlayers[i]) < 0) {
      $("#consolebox-"+currentPlayers[i]).remove();
      currentPlayers.splice(i, 1);
    }
  }
}); 

window.onbeforeunload = function (e) {
  var message = "Please don't go!",
  e = e || window.event;
  // For IE and Firefox
  if (e) {
    e.returnValue = message;
  }

  // For Safari
  return message;
};
