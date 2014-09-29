GameOver = 

    preload: ->
        return

    create: ->
        #game.add.sprite 0, 0, "background"
        titleText = game.add.text(
            game.world.centerX,
            150,
            "Blind Aliens",
            {font: '65px Arial', fill: '#ffffff', align: 'center'}
        )
        titleText.anchor.setTo 0.5, 0.5

        gameOverText = game.add.text(
            game.world.centerX,
            250,
            'Game Over!',
            {font: '32px Arial', fill: '#ff3333', align: 'center'}
        );
        gameOverText.anchor.setTo 0.5, 0.5
        scoreText = game.add.text(
            game.world.centerX,
            350,
            'Score: '+game.state.states.play.score,
            {font: '24px Arial', fill: '#dddddd', align: 'center'}
        );
        scoreText.anchor.setTo 0.5, 0.5

        return

    update: ->
        if game.input.activePointer.justPressed()
            game.state.start("menu")
        return