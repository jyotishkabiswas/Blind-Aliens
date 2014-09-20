class Player extends GameObject

    constructor: ->
    	@sprite = game.add.sprite 0, 0, "player"
    	game.physics.arcade.enable(@sprite)
    	@sprite.body.collideWorldBounds = true

    update: ->
        @sprite.body.velocity.x = 0
        @sprite.body.velocity.y = 0

        if cursors.left.isDown
            @sprite.body.velocity.x = -150
        else if cursors.right.isDown
            @sprite.body.velocity.x = 150

        if cursors.up.isDown
            @sprite.body.velocity.y = 150
        else if cursors.down.isDown
            @sprite.body.velocity.y = -150

    destroy: ->