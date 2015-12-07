module.exports = class PresentURL

  count: 4
  presentURLs: ['http://dumberland.com/video/xdqtanxr', 'http://dumberland.com/video/onolhvkc', 'http:/dumberland.com/video/sizvhcic',
				'http://dumberland.com/video/chgkxoxc', 'http://dumberland.com/video/kqydmrlu']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]

  # Return URL for the video to append to our view. 
  getVid: (videoCode) ->
    @videoNum
    
    return @videoNum = '148047051' if videoCode == 'xdqtanxr'
    return @videoNum = '148047049' if videoCode == 'onolhvkc'
    return @videoNum = '148047050' if videoCode == 'sizvhcic'
    return @videoNum = '148047048' if videoCode == 'chgkxoxc'
    return @videoNum = '148047052' if videoCode == 'kqydmrlu'
    return @videoNum = 'VaAAnjt9orz' if videoCode == '15'
    return @videoNum = 'VaAAnjt9orc' if videoCode == '16'
    return @videoNum = 'VaAAnjt9orz' if videoCode == '17'
    return @videoNum = 'VaAAnjt9orc' if videoCode == '18'
    return @videoNum = 'VaAAnjt9orz' if videoCode == '19'
    return @videoNum = 'VaAAnjt9orc' if videoCode == '20'
    return @videoNum = 'VaAAnjt9orz' if videoCode == '21'
    
#    if videoNumber == '10'
#        @videoURL = 'VaAAnjt9orc'
#    else if videoNumber == '11'    
#        @videoURL = 'VaAAnjt9orz'
#        
#    return @videoURL 
    
  
    