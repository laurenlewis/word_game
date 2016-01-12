class WebsocketGameController < WebsocketRails::BaseController  
  # Demo Event
  def handle_hello
  	WebsocketRails[:updates].trigger(:update, "hello from the server. i received the message "+message)
  end

  # Start New Round - provide phrase to users
  def start_new_round
    # Update Round Number
    if controller_store.has_key?(:round_number)
      controller_store[:round_number] = controller_store[:round_number] + 1
    else
      controller_store[:round_number] = 0
    end

    # Reset Round Variables
  	controller_store[:submission_count] = 0
  	controller_store[:total_votes_for_round] = 0
  	controller_store[:vote_counts] = {}
  	WebsocketRails[:updates].trigger(:new_round, get_random_phrase)
  end

  # Handle the submission of a phrase ending from the client
  def handle_phrase_submission
  	# Update the count of the submissions for this round
  	controller_store[:submission_count] += 1

  	# Send the message (id and phrase) back to the channel for everyone to have it
  	WebsocketRails[:updates].trigger(:add_phrase, message)

  	# Get list of connections to the 'updates' channel
  	connections = WebsocketRails[:updates].subscribers
  	# If the new number of submissions == the number of subscribers, send display_submissions
  	if (connections.length == controller_store[:submission_count])
  	  WebsocketRails[:updates].trigger(:display_submissions, 'display them')
  	end
  end

  # Handle the submission of a single vote. message = connection_id for the phrase
  def handle_vote_submission
  	# Update vote_count hash to tally this vote
  	if controller_store[:vote_counts].has_key?(message)
  	  controller_store[:vote_counts][message] = controller_store[:vote_counts][message] + 1
  	else
  	  controller_store[:vote_counts][message] = 1
  	end

  	# Send update_vote_counts event with the vote_count hash
  	WebsocketRails[:updates].trigger(:update_vote_counts, controller_store[:vote_counts])

    # Get list of connections to the 'updates' channel
    connections = WebsocketRails[:updates].subscribers

  	# Update the count of the votes for this round
  	controller_store[:total_votes_for_round] += 1
  	if (connections.length == controller_store[:total_votes_for_round])
  	  WebsocketRails[:updates].trigger(:compare_vote_counts, controller_store[:total_votes_for_round])
  	end
  end

  def handle_new_player
    connections = WebsocketRails[:updates].subscribers
    players = []
    for i in 0...connections.length
      players.push(connections[i].id)
    end
    WebsocketRails[:updates].trigger(:announce_new_player, players)
  end

  def handle_player_exit

    connections = WebsocketRails[:updates].subscribers
    players = []
    for i in 0...connections.length
      players.push(connections[i].id)
    end
    WebsocketRails[:updates].trigger(:announce_player_exit, players)
  end

  private
  def get_random_phrase
  	phrases = [
  	  'My sagely old uncle used to say: "She who offers an apple..."', 
  	  'My sagely old aunt used to say: "He who fears clocks..."', 
  	  'My sagely old neighbor used to say: "She who hopes for the pumpkins..."',
      'My sagely old grandma used to say: "He who follows pebbles..."',
      'My sagely old grandpa used to say: "She who ignores her shadow..."',
      'My sagely old professor used to say: "He who chases death..."',
      'My sagely old mailman used to say: "She who abandons ignorance..."',
      'My sagely old librarian used to say: "He who steps on love..."',
      'My sagely old cat used to say: "She who squints at the mice..."',
      'My sagely old uncle used to say: "He who drinks with a snake..."'
  	]
  	# phrases[controller_store[:round_number]] 
    phrases.sample
  end
end 