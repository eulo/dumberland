module.exports = class PresentURL

  count: 4
  presentURLs: ['http://localhost/video/10', 'http://localhost/video/12', 'http://localhost/video/13',
				'http://localhost/video/14', 'http://localhost/video/15']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]
