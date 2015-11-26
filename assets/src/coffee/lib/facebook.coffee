module.exports = ->
  ga 'send','event','Button Clicks','facebook.com'
  FB.ui
    method: 'share',
    href: 'http://dumberland.com/',
    title: 'Dumberland',
    link: 'http://dumberland.com/',
    picture: 'http://dumberland.com/assets/img/fb_share_img.png',
    description: 'Give the gift of surprise this Christmas. Send a Dumb Present from the Christmas Dumberland.'
