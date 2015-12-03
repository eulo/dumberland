module.exports = class PresentURL

  count: 4
  presentURLs: ['http://52.64.226.45/video/10', 'http://52.64.226.45/video/12', 'http:/52.64.226.45//video/13',
				'http://52.64.226.45/video/14', 'http://52.64.226.45/video/15']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]
