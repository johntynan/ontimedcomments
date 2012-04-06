$ ->

	EMBEDLY_KEY = '9c42af027f6c11e1a40a4040d3dc5c07'

	SC.initialize
		client_id: "YOUR_CLIENT_ID"

	SC.whenStreamingReady ->
		sound = SC.stream 42164989,
			ontimedcomments: (comments) ->
				for comment in comments

					comment.timestamp = SC.Helper.millisecondsToHMS(comment.timestamp)

					$.getJSON "http://api.embed.ly/1/oembed?callback=?", key: EMBEDLY_KEY, url: comment.body, autoplay: true, maxwidth: 425, (data) ->

						if data.type == "photo"
							comment.media = "photo"
							comment.html = "<img src='#{ data.url }' />"
						else if data.type == "link"
							comment.media = "link"
							comment.html = "<a href='#{ data.url }' target='_blank'>#{ data.url }</a>"
						else if data.type == "video"
							comment.media = "video"
							comment.html = data.html
						else if data.type == "rich"
							comment.media = "rich"
							comment.html = data.html

						$('#comments').prepend ich.comment(comment)

			whileplaying: () ->
				$('.played').width (@position / @duration * 100) + '%'
			onfinish: () ->
				$('.finished').show()

			autoPlay: false
			volume: 100

		$('.play').click ->
			sound.play()
			false
