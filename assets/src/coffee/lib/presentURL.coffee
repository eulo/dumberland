module.exports = class PresentURL

  count: 4
  presentURLs: ['https://www.youtube.com/watch?v=pJnT9F-yR1M', 'https://www.youtube.com/watch?v=qm97F1PtNrY', 'https://www.youtube.com/watch?v=TyUHEahjAdI',
				'https://www.youtube.com/watch?v=MQqprTh69V4', 'https://www.youtube.com/watch?v=-ymcULQZHiA']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]
