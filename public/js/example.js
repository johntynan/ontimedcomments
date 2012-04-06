SC.initialize({
  client_id: "YOUR_CLIENT_ID"
});

SC.whenStreamingReady(function() {
  SC.stream(TRACK_ID, {
    ontimedcomments: function(comments) {
      var comment, _i, _len;

      for (_i = 0, _len = comments.length; _i < _len; _i++) {
        comment = comments[_i];

        $.getJSON("http://api.embed.ly/1/oembed?callback=?", {
          key: EMBEDLY_KEY,
          url: comment.body
        }, function(data) {
          // Now do something awesome with the data embed.ly returns. ;-)
        });
      }
    }
  });
});
