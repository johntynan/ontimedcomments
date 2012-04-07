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

						comment.media = data.type

						switch data.type
							when "photo"
								comment.html = "<img src='#{ data.url }' />"
							when "link"
								comment.html = "<a href='#{ data.url }' target='_blank'>#{ data.url }</a>"
							when "video"
								comment.html = data.html
							when "rich"
								comment.html = data.html

						$('#comments').prepend ich.comment(comment)
						$('#comments').find('li:first').fadeIn('slow')

			whileplaying: () ->
				$('.played').width (@position / @duration * 100) + '%'
			autoLoad: true
			autoPlay: false
			volume: 100

		sound.onPosition 78000, () -> $('.finished').fadeIn()

		$('.play').click ->
			sound.play()
			false
