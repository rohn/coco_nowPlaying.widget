apiKey = 'your api key'   # put your last.fm api key here

# get the last(latest) playing track
command: "curl -sS 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=CoCoDT&api_key=#{apiKey}&limit=1&extended=1&format=json'"


# set the refresh frequency (in milliseconds)
refreshFrequency: 2000

# make the output
render: (outputSong) -> """
  <div id='cocoTunes'></div>
"""

update: (outputSong, domEl) ->
  dom = $(domEl)
  data = JSON.parse outputSong

  html = ""

  track = data.recenttracks.track[0]

  if track isnt undefined
    theArtist = track.artist
    theArtistName = theArtist.name
    theTrack = track.name
    html += "<div class='text'>"
    html += "<div class='artist'>" + theArtistName + "</div>"
    html += "<div class='title'>" + theTrack + "</div> "
    html += "</div>"
  else
    html += "<div class='text'>...waiting</div>"

  $('#cocoTunes').html(html)



style: """
  bottom: 0px
  right: 0px
  color: #fff
  margin: 0
  background: transparent;

  #cocoTunes
    background-image: url(coco_nowPlaying.widget/img/left.png)
    background-position: left
    background-repeat: no-repeat
    height: 20px
    float: left
    padding-left: 68px

  .text
    height: 22px
    float: left
    display: block
    line-height: 26px
    color: #fff
    font-family: 'Myriad Pro'
    font-size: 12px
    background-color: #000

  .title
    font-weight: bold
    color: #fff
    margin: 0px
    height: 22px
    float: left
    margin-right: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

  .artist
    opacity: 0.6;
    padding: 0px
    height: 22px
    width: auto
    float: left
    max-width: none
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis
"""