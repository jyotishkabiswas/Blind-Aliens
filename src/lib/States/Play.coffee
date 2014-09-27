class Play

    pauseText = null

    preload: ->
        game.load.image "shadowmask", "library/assets/shadowmask.png"
        game.load.image "background", "library/assets/background.png"
        game.load.image "side_shadows", "library/assets/side_shadows.png"
        game.load.image "player", "library/assets/player.png"
        game.load.image "circle", "library/assets/circle.png"
        game.load.image "bullet", "library/assets/bullet.png"
        game.load.image "ammo", "library/assets/ammo.png"
        game.load.spritesheet "enemy", "library/assets/alien_spreadsheet_350_402.png", 350, 402, 4
        game.load.audio "footstep", "library/assets/footstep.m4a"
        game.load.audio "gunshot", "library/assets/gunshot.wav"

    create: ->
        @GameState =
            numAliens: 0
            numAmmoBoxes: 0
        @GameObjects = {}
        @backdropPlayer = game.add.group()
        @aliens = game.add.group()
        @shadows = game.add.group()
        @hud = game.add.group()
        game.physics.startSystem Phaser.Physics.ARCADE
        @backdropPlayer.create 0, 0, "background"
        player = new Player game.width / 2, game.height / 2, @
        
        ammo = new AmmoBox 100, 100, @
        @shadows.create 0, 0, "side_shadows"
        @score = 0
        @count = 0
        @scoreboard = game.add.text 16, 16, 'Score: 0', { fontSize: '32px', fill: '#FFF'}
        @hud.add(@scoreboard)

        Play.pauseText = game.add.text(
            game.world.centerX,
            game.world.centerY,
            "",
            { font: "bold 32px Arial", fill: "#ffffff", align: "center" }
        )
        Play.pauseText.anchor.setTo 0.5, 0.5
        game.input.keyboard.onDownCallback = @pauseOrResume
        return


    newAlien: (big) ->
        v = Math.random() * 2 * (game.width + game.height)
        if v < game.width
            x = v
            y = -40
        else if v < 2 * game.width
            x = v - game.width
            y = 40 + game.height
        else if v < 2 * game.width + game.height
            y = v - 2 * game.width
            x = -40
        else
            y = v - (2 * game.width + game.height)
            x = 40 + game.width
        new Alien x, y, @, big
        @GameState.numAliens += 1

    newAmmoBox: ->
        x = Math.random() * game.width
        y = Math.random() * game.height
 
        new AmmoBox x, y, @
        @GameState.numAmmoBoxes += 1

    update: ->
        if 0 ==  @count % 20 
            @score = @score + 1
            @scoreboard.text = "Score: " + @score.toString()

        if 0 == @count % 100
            if @GameState.numAmmoBoxes < 5
                @newAmmoBox()

        @count = @count + 1

        minAliens = @score / 400 + 2
        maxAliens = @score / 200 + 2
        if (@GameState.numAliens < minAliens and Math.random() < 0.03) or (Math.random() < 0.0005 and @GameState.numAliens < maxAliens)
            big = Math.round ((Math.random() * @score / 1000)) 
            @newAlien(big)

        for k, v of @GameObjects
            v.update()
    destroy: ->
        game.input.keyboard.onDownCallback = null

    pauseOrResume: ->
        if game.state.current == "play" && game.input.keyboard.justPressed(Phaser.Keyboard.SPACEBAR)
            if !(@lastClick?) || game.time.now - @lastClick > 50
                @lastClick = game.time.now
                if game.paused
                    game.paused = false
                    Play.pauseText.text = ""
                else
                    Play.pauseText.text = "Game Paused"
                    game.paused = true
        return

