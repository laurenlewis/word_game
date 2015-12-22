class WebsocketGameController < WebsocketRails::BaseController  
  # Demo Event
  def handle_hello
  	WebsocketRails[:updates].trigger(:update, "hello from the server. i received the message "+message)
  end

  # Start New Round - provide phrase to users
  def start_new_round
  	controller_store[:submission_count] = 0
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
  end

  private
  def get_random_phrase
  	phrases = [
  	  'There\'s an old saying from Denmark. "She who offers an apple..."', 
  	  'There\'s an old saying from Italy. "He who punches cats..."', 
  	  'There\'s an old saying from Mozambique. "She who hopes for the pumpkins..."'
  	]
  	phrases.sample
  end
end 