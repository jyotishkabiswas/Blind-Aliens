class Player extends GameObject

    constructor: (@x, @y) ->
        super()
        cursors = game.input.keyboard.createCursorKeys()

        @controls = {}
        @controls.left = cursors.left
        @controls.down = cursors.down
        @controls.right = cursors.right
        @controls.up = cursors.up
        @controls.W = game.input.keyboard.addKey Phaser.Keyboard.W
        @controls.A = game.input.keyboard.addKey Phaser.Keyboard.A
        @controls.S = game.input.keyboard.addKey Phaser.Keyboard.S
        @controls.D = game.input.keyboard.addKey Phaser.Keyboard.D

        @sprite = game.add.sprite @x, @y, "player"
        game.physics.arcade.enable(@sprite)
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.setTo(0.5,0.75)
        @i = 0

    update: ->
        @sprite.body.acceleration.x = 0
        @sprite.body.acceleration.y = 0

        dx = 0
        dx = if @controls.left.isDown or @controls.A.isDown then dx - 1 else dx
        dx = if @controls.right.isDown or @controls.D.isDown then dx + 1 else dx
        dy = 0
        dy = if @controls.down.isDown or @controls.S.isDown then dy + 1 else dy
        dy = if @controls.up.isDown or @controls.W.isDown then dy - 1 else dy

        if dx == -1
            @sprite.body.acceleration.x = if @sprite.body.velocity.x > 0 then -600 else -300
        if dx == 1
            @sprite.body.acceleration.x = if @sprite.body.velocity.x < 0 then 600 else 300
        if dy == -1
            @sprite.body.acceleration.y = if @sprite.body.velocity.y > 0 then -600 else -300
        if dy == 1
            @sprite.body.acceleration.y = if @sprite.body.velocity.y < 0 then 600 else 300
        @sprite.body.acceleration.x = -5 * @sprite.body.velocity.x if @sprite.body.acceleration.x == 0
        @sprite.body.acceleration.y = -5 * @sprite.body.velocity.y if @sprite.body.acceleration.y == 0

        @i = @i + 1
        dx = @sprite.body.x - game.input.mousePointer.x
        dy = @sprite.body.y - game.input.mousePointer.y
        @sprite.angle = -105 + 180 * Math.atan2(dy, dx) / Math.PI + 15 * Math.sin(@i / 100.0)

    destroy: ->