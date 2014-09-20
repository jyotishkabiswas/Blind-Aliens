Play = ->
Play.prototype = {
	preload: ->
		game.load.image "background", "library/assets/background.png"
	create: ->
		game.add.sprite 0, 0, "background"
	update: ->
}