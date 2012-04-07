(function() {
  $(function() {
    var EMBEDLY_KEY;
    EMBEDLY_KEY = '9c42af027f6c11e1a40a4040d3dc5c07';
    SC.initialize({
      client_id: "YOUR_CLIENT_ID"
    });
    return SC.whenStreamingReady(function() {
      var sound;
      sound = SC.stream(42164989, {
        ontimedcomments: function(comments) {
          var comment, _i, _len, _results;
          _results = [];
          for (_i = 0, _len = comments.length; _i < _len; _i++) {
            comment = comments[_i];
            comment.timestamp = SC.Helper.millisecondsToHMS(comment.timestamp);
            _results.push($.getJSON("http://api.embed.ly/1/oembed?callback=?", {
              key: EMBEDLY_KEY,
              url: comment.body,
              autoplay: true,
              maxwidth: 425
            }, function(data) {
              comment.media = data.type;
              switch (data.type) {
                case "photo":
                  comment.html = "<img src='" + data.url + "' />";
                  break;
                case "link":
                  comment.html = "<a href='" + data.url + "' target='_blank'>" + data.url + "</a>";
                  break;
                case "video":
                  comment.html = data.html;
                  break;
                case "rich":
                  comment.html = data.html;
              }
              $('#comments').prepend(ich.comment(comment));
              return $('#comments').find('li:first').fadeIn('slow');
            }));
          }
          return _results;
        },
        whileplaying: function() {
          return $('.played').width((this.position / this.duration * 100) + '%');
        },
        autoLoad: true,
        autoPlay: false,
        volume: 100
      });
      sound.onPosition(78000, function() {
        return $('.finished').fadeIn();
      });
      return $('.play').click(function() {
        sound.play();
        return false;
      });
    });
  });
}).call(this);
