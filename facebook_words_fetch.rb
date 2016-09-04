require 'open-uri'
require 'rest-client'
require 'json'
require 'hashie'

access_token = 'ACCESS_TOKEN_HERE'
top_words_count = 100

words_to_filter = ["a", "able", "about", "across", "after", "all", "almost", "also", "am", "among", "an",
                  "and", "any", "are", "as", "at", "be", "because", "been", "but", "by", "can", "cannot",
                  "could", "dear", "did", "do", "does", "either", "else", "ever", "every", "for", "from",
                  "get", "got", "had", "has", "have", "he", "her", "hers", "him", "his", "how", "however",
                  "i", "if", "in", "into", "is", "it", "its", "just", "least", "let", "like", "likely", "may",
                  "me", "might", "most", "must", "my", "neither", "no", "nor", "not", "of", "off", "often",
                  "on", "only", "or", "other", "our", "own", "rather", "said", "say", "says", "she", "should",
                  "since", "so", "some", "than", "that", "the", "their", "them", "then", "there", "these",
                  "they", "this", "tis", "to", "too", "twas", "us", "wants", "was", "we", "were", "what",
                  "when", "where", "which", "while", "who", "whom", "why", "will", "with", "would", "yet", "you", "your","you're"]

user_words = {}

limit = 10 # Limit of recent posts to cover
minimum_word_length = 4 # Minimum length of the word to cover
uri = "https://graph.facebook.com/me/statuses?access_token=#{access_token}&limit=#{limit}"

response = RestClient.get(uri)
statuses_json = JSON.parse(response.body)

if statuses_json.keys.include? "error"
	puts "--- ERROR ---"
	puts statuses_json["error"]["message"]
	puts "Exiting . . ."
end

puts "Statuses: \n"

# Process and Count Frequency
statuses_json["data"].each do |status|
	# puts status["message"]
	message = status["message"].downcase

	# Remove all special characters (everything other than alphabets, numbers and spaces) from post
    raw_message =  message.gsub(/[^A-Za-z0-9\s]/, "")

    # Split post into words
	raw_words = raw_message.split(/[\s]+/)

 	# Iterate over each word and increase its frequency if it is not a word filter
 	raw_words.each do |raw_word|
 		# Skip words with length smaller than our minimum_word_length
 		next if raw_word.length < minimum_word_length

 		if !words_to_filter.include? raw_word
 			user_words[raw_word] = 0 if !user_words.keys.include? raw_word

 			user_words[raw_word] += 1
 		end
 	end
end

top_words = user_words.sort_by {|word, freq| [-freq, word]}[0..(top_words_count-1)]

top_words.each_with_index do |top_word, i|
	puts "Top #{i+1}: #{top_word[0]} (#{top_word[1]})"
end




















