class Play

    preload: ->
        game.load.image "shadowmask", "library/assets/shadowmask.png"
        game.load.image "background", "library/assets/background.png"
        game.load.image "side_shadows", "library/assets/side_shadows.png"
        game.load.image "player", "library/assets/player.png"
        game.load.image "circle", "library/assets/circle.png"
        game.load.image "bullet", "library/assets/bullet.png"
        game.load.spritesheet "enemy", "library/assets/alien_spreadsheet_300_344.png", 300, 344, 4
        game.load.audio "footstep", "library/assets/footstep.m4a"
        game.load.audio "gunshot", "library/assets/gunshot.wav"

    create: ->
        @GameState =
            playerLocation: null
            numAliens: 3
        @GameObjects = {}
        @sprites = game.add.group()
        @hud = game.add.group()
        game.physics.startSystem Phaser.Physics.ARCADE
        @sprites.create 0, 0, "background"

        player = new Player 50, 50, @
        
        for i in [1..3]
            alien = new Alien 150*i, 500, @
 
        @sprites.create 0, 0, "side_shadows"
        @score = 0
        @count = 0
        @scoreboard = game.add.text 16, 16, '0', { fontSize: '32px', fill: '#FFF'}

        @hud.add(@scoreboard)

    update: ->
        if 0 ==  @count % 20 
            @score = @score + 1
            @scoreboard.text = @score.toString()

        @count = @count + 1
        
        for k, v of @GameObjects
            v.update()

