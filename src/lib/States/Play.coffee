class Play

    preload: ->
        game.load.image "background", "library/assets/background.png"
        game.load.image "player", "library/assets/player.png"
        game.load.image "circle", "library/assets/circle.png"
        game.load.audio "footstep", "library/assets/footstep.wav"
        game.load.audio "gunshot", "library/assets/gunshot.wav"

    create: ->
        game.physics.startSystem(Phaser.Physics.ARCADE)
        game.add.sprite 0, 0, "background"
        player = new Player 50, 50
        for i in [1..3]
            alien = new Alien 150*i, 500

    update: ->
        for k, v of GameObjects
            v.update()