module.exports = class PresentURL

  count: 4
  presentURLs: ['http://dumberland.com/video/10', 'http://dumberland.com/video/12', 'http:/dumberland.com/video/13',
				'http://dumberland.com/video/14', 'http://dumberland.com/video/15']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]

  # Return URL for the video to append to our view. 
  getVid: (videoNumber) ->
    @videoURL
    
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '10'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '11'
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '12'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '13'
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '14'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '15'
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '16'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '17'
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '18'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '19'
    return @videoURL = 'VaAAnjt9orc' if videoNumber == '20'
    return @videoURL = 'VaAAnjt9orz' if videoNumber == '21'
    
#    if videoNumber == '10'
#        @videoURL = 'VaAAnjt9orc'
#    else if videoNumber == '11'    
#        @videoURL = 'VaAAnjt9orz'
#        
#    return @videoURL 
    
  
    