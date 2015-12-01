module.exports = class PresentURL

  count: 4
  presentURLs: ['http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/video/10', 'http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/video/12', 'http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/video/13',
				'http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/video/14', 'http://ec2-52-64-211-113.ap-southeast-2.compute.amazonaws.com/video/15']

  constructor: () ->
	
	# Generate a random number btw 0 - 4	  	
  	@number = Math.floor(Math.random() * (@count - 0) + 0)
  	
  	# Use number to get the URL we need. 
  	# Pass all 3 back as a object.
  	@url = @presentURLs[@number]
