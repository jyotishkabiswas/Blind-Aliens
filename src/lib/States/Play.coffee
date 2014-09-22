class Play

    preload: ->
        game.load.image "shadowmask", "library/assets/shadowmask.png"
        game.load.image "background", "library/assets/background.png"
        game.load.image "side_shadows", "library/assets/side_shadows.png"
        game.load.image "player", "library/assets/player.png"
        game.load.image "circle", "library/assets/circle.png"
        game.load.spritesheet "enemy", "library/assets/alien_spreadsheet_300_344.png", 300, 344, 4
        game.load.audio "footstep", "library/assets/footstep.m4a"
        game.load.audio "gunshot", "library/assets/gunshot.wav"

    create: ->
        @GameState =
            playerLocation: null
            numAliens: 3
        @GameObjects = {}
        game.physics.startSystem Phaser.Physics.ARCADE
        game.add.sprite 0, 0, "background"
        player = new Player 50, 50, @

        for i in [1..3]
            alien = new Alien 150*i, 500, @
        game.add.sprite 0, 0, "side_shadows"
    update: ->
        for k, v of @GameObjects
            v.update()
