class WebsocketGameController < WebsocketRails::BaseController  
  # Demo Event
  def handle_hello
  	WebsocketRails[:updates].trigger(:update, "hello from the server. i received the message "+message)
  end

  # Start New Round - provide phrase to users
  def start_new_round
  	controller_store[:submission_count] = 0
  	WebsocketRails[:updates].trigger(:new_round, get_random_phrase)
  end

  # Handle the submission of a phrase ending from the client
  def handle_phrase_submission
  	subscribers = WebsocketRails[:updates].subscribers
  	controller_store[:submission_count] += 1
  	WebsocketRails[:updates].trigger(:add_phrase, message)

  	# If the new number of submissions == the number of subscribers, send display_submissions
  	if (subscribers.length == controller_store[:submission_count])
  	  WebsocketRails[:updates].trigger(:display_submissions, 'display them')
  	end
  end

  private
  def get_random_phrase
  	phrases = [
  	  'There\'s an old phrase from Denmark. "She who punches cats..."', 
  	  'There\'s an old phrase from Italy. "He who punches ferrets..."', 
  	]
  	phrases.sample
  end
end 