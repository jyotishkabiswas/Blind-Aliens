class Player extends GameObject

    constructor: (@x, @y) ->
        @controls = game.input.keyboard.createCursorKeys()
        @sprite = game.add.sprite @x, @y, "player"
        game.physics.arcade.enable(@sprite)
        @sprite.body.collideWorldBounds = true

    update: ->
        @sprite.body.velocity.x = 0
        @sprite.body.velocity.y = 0

        @sprite.body.velocity.x = -150 if @controls.left.isDown
        @sprite.body.velocity.x = 150 if @controls.right.isDown
        @sprite.body.velocity.y = 150 if @controls.down.isDown
        @sprite.body.velocity.y = -150 if @controls.up.isDown

    destroy: ->