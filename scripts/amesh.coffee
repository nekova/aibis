cloudinary = require('cloudinary')

module.exports = (robot) ->
  robot.respond /amesh$/i, (msg) ->
    msg.send 'amesh'
    cloudinary.config
      cloud_name: process.env.CLOUD_NAME,
      api_key:    process.env.CLOUD_API_KEY,
      api_secret: process.env.CLOUD_API_SECRET

    msg.send (cloudinary.url "http://tokyo-ame.jwa.or.jp",
      type: "url2png", width: 800, height: 600
      sign_url: true
    )
