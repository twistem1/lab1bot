require 'telegram/bot'

TOKEN = '13520872:AAEwpmHxhTuk-mwZKcYarMdmMPjoo'

QUESTION = ["I do not become defensive when criticized.", "I can stay calm under pressure.", "I handle setbacks effectively.", "I manage anxiety, stress, anger, and fear in pursuit of a goal.", "I utilize criticism and other feedback for growth.", "I am positive.", "I maintain a sense of humor.", "I try to see things from another’s perspective.", "I recognize how my behavior affects others."]
$i =0
$chatid = 0
$res = 0
Telegram::Bot::Client.run(TOKEN) do |bot|

	bot.listen do |message|
		kb = [
      				Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Strongly Agree', callback_data: '1'),
      				Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Agree', callback_data: '2'),
      				Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Neither Agree Nor Disagree', callback_data: '3'),
      				Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Disagree', callback_data: '4'),
      				Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Strongly Disagree', callback_data: '5'),
    			]
    	define_singleton_method ("survey") {
    		if $i <= 8
	    		if $chatid != 0
	    			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
	    			bot.api.send_message(chat_id: $chatid, text: QUESTION[$i], reply_markup: markup)
	    			$i += 1
	    		else 

	    			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
	    			bot.api.send_message(chat_id: message.chat.id, text: QUESTION[$i], reply_markup: markup)
	    			$i += 1
	    		end
	    	end
    	}

		case message
		when Telegram::Bot::Types::CallbackQuery
    			# Here you can handle your callbacks from inline buttons
    			if message.data == '1'
    				survey
    				$res += 1
    			elsif message.data == '2'
    				survey
    				$res += 2
    			elsif message.data == '3'
    				survey
    				$res += 3
    			elsif message.data == '4'
    				survey
    			elsif message.data == '5'
    				survey
    				
    			end
  			when Telegram::Bot::Types::Message
  				survey
  				$chatid = message.chat.id
  			end
		end
	end
