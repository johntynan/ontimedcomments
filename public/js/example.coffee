SC.initialize
	client_id: "YOUR_CLIENT_ID"

SC.whenStreamingReady ->
	SC.stream TRACK_ID,
		ontimedcomments: (comments) ->
			for comment in comments
				$.getJSON "http://api.embed.ly/1/oembed?callback=?", key: EMBEDLY_KEY, url: comment.body, (data) ->
					# now do something with the embed.ly data
