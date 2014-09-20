Menu = ->
Menu.prototype = {
	preload: ->
		# game.load.image "renderTest", "library/assets/mario.png"
	create: ->
		# game.add.sprite 400 - 32, 300 - 32, "renderTest"
		titleText = game.add.text(
			game.world.centerX,
			150,
			"Blind Aliens",
			{font: '65px Arial', fill: '#ffffff', align: 'center'}
		)
		titleText.anchor.setTo(0.5,0.5)

		instructionsText = game.add.text(
			game.world.centerX,
			300,
			'Click anywhere to play the game',
			{font: '16px Arial', fill: '#bbbbbb', align: 'center'}
		);
		instructionsText.anchor.setTo(0.5, 0.5);
		return
	update: ->
		if game.input.activePointer.justPressed()
			game.state.start("play")
		return
}