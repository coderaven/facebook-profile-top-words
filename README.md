# facebook-profile-top-words
A Personal Facebook Profile Counter of your Most commonly used words (Written in Ruby - Inspired by the PHP Counterpart).

Get Access Token from Facebook:

	1. Hit URl : [Facebook Api Explorer](https://developers.facebook.com/tools/explorer/?method=GET&path=me%2Fstatuses&version=v2.2&)
	2. click on "Get Access Token" button
	3. Add "user_status" permission in pop-up (IMPORTANT)
	4. Copy access_token from Graph Explorer and replace in the variable access_token in the ruby file"

IMPORTANT: Access Tokens Expire in 2 Hours. Just hit the link and get a new one if it expires or if you are to use this in an application - make sure to authenticate properly. Though good luck making facebook approve the publishing of your app haha xD

run by: ruby facebook_words_fetch.rb

Settings you can change:
	1. Max Recent Status to cover
	2. Minimum Word Length of word to be included
	3. Words to filter