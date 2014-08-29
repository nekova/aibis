cloudinary = require('cloudinary')

module.exports = (robot) ->
  robot.respond /amesh$/i, (msg) ->
    cloudinary.config
      cloud_name: process.env.CLOUD_NAME,
      api_key:    process.env.CLOUD_API_KEY,
      api_secret: process.env.CLOUD_API_SECRET

    msg.send (cloudinary.url "http://tokyo-ame.jwa.or.jp",
      type: "url2png", crop: "fill", width: 660, height: 420, gravity: "north"
      sign_url: true
    )
