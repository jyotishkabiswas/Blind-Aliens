class Play

    preload: ->
        game.load.image "shadowmask", "library/assets/shadowmask.png"
        game.load.image "background", "library/assets/background.png"
        game.load.image "side_shadows", "library/assets/side_shadows.png"
        game.load.image "player", "library/assets/player.png"
        game.load.image "circle", "library/assets/circle.png"
        game.load.image "bullet", "library/assets/bullet.png"
        game.load.spritesheet "enemy", "library/assets/alien_spreadsheet_350_402.png", 350, 402, 4
        game.load.audio "footstep", "library/assets/footstep.m4a"
        game.load.audio "gunshot", "library/assets/gunshot.wav"

    create: ->
        @GameState =
            numAliens: 0
        @GameObjects = {}
        @backdropPlayer = game.add.group()
        @aliens = game.add.group()
        @shadows = game.add.group()
        @hud = game.add.group()
        game.physics.startSystem Phaser.Physics.ARCADE
        @backdropPlayer.create 0, 0, "background"
        player = new Player game.width / 2, game.height / 2, @
        
        for i in [1..2]
            @newAlien()
 
        @shadows.create 0, 0, "side_shadows"
        @score = 0
        @count = 0
        @scoreboard = game.add.text 16, 16, '0', { fontSize: '32px', fill: '#FFF'}
        @hud.add(@scoreboard)

    newAlien: ->
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
        new Alien x, y, @
        @GameState.numAliens += 1

    update: ->
        if 0 ==  @count % 20 
            @score = @score + 1
            @scoreboard.text = @score.toString()

        @count = @count + 1    
        if (@GameState.numAliens < 2 and Math.random() < 0.03) or (Math.random() < 0.0005 and @GameState.numAliens < 4)
            @newAlien()

        for k, v of @GameObjects
            v.update()

