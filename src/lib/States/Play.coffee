Play = ->
Play.prototype = {
    preload: ->
        game.load.image "background", "library/assets/background.png"
        game.load.image "player", "library/assets/player.png"
    create: ->
        game.physics.startSystem(Phaser.Physics.ARCADE)
        game.add.sprite 0, 0, "background"
        @player = new Player 50, 50

    update: ->
        @player.update()
}