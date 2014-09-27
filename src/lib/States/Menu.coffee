Menu =

	preload: ->
		game.load.image "background", "library/assets/background.png"
	create: ->
		game.add.sprite 0, 0, "background"
		titleText = game.add.text(
			game.world.centerX,
			150,
			"Blind Aliens",
			{font: '65px Arial', fill: '#ffffff', align: 'center'}
		)
		titleText.anchor.setTo(0.5,0.5)

		clickToStartText = game.add.text(
			game.world.centerX,
			250,
			'Click anywhere to play the game',
			{font: '24px Arial', fill: '#ff7777', align: 'center'}
		);
		clickToStartText.anchor.setTo(0.5, 0.5);

		instructionsText = game.add.text(
			game.world.centerX,
			400,
			'Instructions:\n
			1. Move slowly so that the aliens can\'t hear you\n
			2. Move fast to run away, risking to be heard by the aliens\n
			3. Shoot the aliens twice to kill them, while being heard by them\n\n
			Controls:\n
			1. W, A, S, D, or ↑, ←, ↓, →, to move around\n
			2. Left mouse click for shooting at the wanted position\n
			3. Spacebar for pause/resume the game',
			{font: '16px Arial', fill: '#bbbbbb', align: 'center'}
		);
		instructionsText.anchor.setTo(0.5, 0.5);
		return
	update: ->
		if game.input.activePointer.justPressed()
			game.state.start("play")
		return