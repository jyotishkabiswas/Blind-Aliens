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
			'Synopsis:\n
			You are trapped in a room with blind aliens.\n
			Sneak or run. Hide or shoot. Just stay alive.\n
			\n
			Controls:\n
			1. Move using W, A, S, D, or ↑, ←, ↓, →\n
			2. Run by holding W, A, S, D, or ↑, ←, ↓, →\n
			3. Direct your gun using the mouse\n
			4. Shoot by clicking your mouse\n
			3. Pause/resume by hitting spacebar',
			{font: '16px Arial', fill: '#bbbbbb', align: 'center'}
		);
		instructionsText.anchor.setTo(0.5, 0.5);
		return
	update: ->
		if game.input.activePointer.justPressed()
			game.state.start("play")
		return
