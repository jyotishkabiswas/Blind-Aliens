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
			500,
			'Click anywhere to play the game',
			{font: '24px Arial', fill: '#ff7777', align: 'center'}
		);
		clickToStartText.anchor.setTo(0.5, 0.5);

		instructionsText = game.add.text(
			game.world.centerX,
			350,
			'You are trapped in a room with blind aliens.\n
			Sneak or run. Hide or shoot. Just stay alive.\n
			\n
			Controls:\n
			1. Move using W, A, S, D, or ↑, ←, ↓, →\n
			3. Use your mouse to aim and shoot\n
			3. Pause/resume by hitting spacebar',
			{font: '24px Arial', fill: '#bbbbbb', align: 'center'}
		);
		instructionsText.anchor.setTo(0.5, 0.5);
		return
	update: ->
		if game.input.activePointer.justPressed()
			game.state.start("play")
		return
