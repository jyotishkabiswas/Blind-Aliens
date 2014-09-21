class Player extends GameObject

    constructor: (@x, @y) ->
        @controls = game.input.keyboard.createCursorKeys()
        @sprite = game.add.sprite @x, @y, "player"
        game.physics.arcade.enable(@sprite)
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.x = .5
        @sprite.anchor.y = .75
        @i = 0
        @footstepCountdown = 4000
        @gunCountdown = 0

    update: ->
        @sprite.body.acceleration.x = 0
        @sprite.body.acceleration.y = 0

        dx = 0
        dx = if @controls.left.isDown then dx - 1 else dx
        dx = if @controls.right.isDown then dx + 1 else dx
        dy = 0
        dy = if @controls.down.isDown then dy + 1 else dy
        dy = if @controls.up.isDown then dy - 1 else dy

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
        dx = @sprite.body.x + @sprite.body.width * @sprite.anchor.x - game.input.mousePointer.x
        dy = @sprite.body.y + @sprite.body.height * @sprite.anchor.y - game.input.mousePointer.y
        @sprite.angle = -105 + 180 * Math.atan2(dy, dx) / Math.PI + 15 * Math.sin(@i / 100.0)


        @footstepCountdown = @footstepCountdown - Math.abs(@sprite.body.velocity.x) - Math.abs(@sprite.body.velocity.y)
        if @footstepCountdown < 0
            @footstepCountdown = 4000
            new Circle @sprite.body.x + @sprite.body.width * @sprite.anchor.x, @sprite.body.y + @sprite.body.height * @sprite.anchor.y, Math.max(Math.abs(@sprite.body.velocity.x), Math.abs(@sprite.body.velocity.y)) * 2

        @sprite.bringToTop()
        
        @gunCountdown = @gunCountdown - 1 if @gunCountdown > 0
        if @gunCountdown == 0 and game.input.activePointer.isDown
            @gunCountdown = 250
            
        @sprite.angle = @sprite.angle + Math.max(@gunCountdown, 220) / 2.0 - 110
    destroy: ->