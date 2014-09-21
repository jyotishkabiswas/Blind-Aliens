class Player extends GameObject

    constructor: (@x, @y) ->
        @controls = game.input.keyboard.createCursorKeys()
        @sprite = game.add.sprite @x, @y, "player"
        game.physics.arcade.enable(@sprite)
        # @sprite.body.collideWorldBounds = true
        @sprite.anchor.x = .5
        @sprite.anchor.y = .75
        @i = 0
        @footstepCountdown = 3000
        @gunCountdown = 0
        @gun = game.add.audio "gunshot"
	
    update: ->
        # reset acceleration to start
        @sprite.body.acceleration.x = 0
        @sprite.body.acceleration.y = 0
   
        # check controls
        dx = 0
        dx = if @controls.left.isDown then dx - 1 else dx
        dx = if @controls.right.isDown then dx + 1 else dx
        dy = 0
        dy = if @controls.down.isDown then dy + 1 else dy
        dy = if @controls.up.isDown then dy - 1 else dy

        # adjust acceleration if controls used
        if dx == -1
            @sprite.body.acceleration.x = if @sprite.body.velocity.x > 0 then -600 else -300
        if dx == 1
            @sprite.body.acceleration.x = if @sprite.body.velocity.x < 0 then 600 else 300
        if dy == -1
            @sprite.body.acceleration.y = if @sprite.body.velocity.y > 0 then -600 else -300
        if dy == 1
            @sprite.body.acceleration.y = if @sprite.body.velocity.y < 0 then 600 else 300

        # drag if no controls in use
        @sprite.body.acceleration.x = -5 * @sprite.body.velocity.x if @sprite.body.acceleration.x == 0
        @sprite.body.acceleration.y = -5 * @sprite.body.velocity.y if @sprite.body.acceleration.y == 0

        # rotate sprite towards mouse and move around that periodically
        @i = @i + 1
        dx = @sprite.body.x + @sprite.body.width * @sprite.anchor.x - game.input.mousePointer.x
        dy = @sprite.body.y + @sprite.body.height * @sprite.anchor.y - game.input.mousePointer.y
        @sprite.angle = -100 + 180 * Math.atan2(dy, dx) / Math.PI + 15 * Math.sin(@i / 100.0)

        # create footstep sounds every once in a while
        @footstepCountdown = @footstepCountdown - Math.abs(@sprite.body.velocity.x) - Math.abs(@sprite.body.velocity.y)
        if @footstepCountdown < 0
            @footstepCountdown = 3000
            new Circle @sprite.body.x + @sprite.body.width * @sprite.anchor.x, @sprite.body.y + @sprite.body.height * @sprite.anchor.y, Math.max(Math.abs(@sprite.body.velocity.x), Math.abs(@sprite.body.velocity.y)) * 2

        # move sprite forward so footstep circles don't obscure player
        @sprite.bringToTop()
        
        # fire if the gun hasn't been used too recently
        @gunCountdown = @gunCountdown - 1 if @gunCountdown > 0
        if @gunCountdown == 0 and game.input.activePointer.isDown
            @gunCountdown = 250
            @gun.play()
            angle = @sprite.angle + Math.atan(.5 * @sprite.body.width / (.75 * @sprite.body.height))
            angle = angle * Math.PI / 180.0
            r = Math.sqrt(Math.pow(.5 * @sprite.body.width, 2) + Math.pow(.75 * @sprite.body.height, 2))
            new Circle @sprite.body.x + @sprite.body.width * @sprite.anchor.x + r * Math.sin(angle), @sprite.body.y + @sprite.body.height * @sprite.anchor.y - r * Math.cos(angle), 2000
        @sprite.angle = @sprite.angle + Math.max(@gunCountdown, 220) / 2.0 - 110

        # our own version of collision with the bounding box
        x = @sprite.body.x + @sprite.body.width * @sprite.anchor.x
        y = @sprite.body.y + @sprite.body.height * @sprite.anchor.y
        if x < 20
            @sprite.body.x = @sprite.body.x + 20 - x
            @sprite.body.velocity.x = 0
            @sprite.body.acceleration.x = 0
        if x > game.width - 20
            @sprite.body.x = @sprite.body.x - x + game.width - 20
            @sprite.body.velocity.x = 0
            @sprite.body.acceleration.x = 0
        if y < 20
            @sprite.body.y = @sprite.body.y + 20 - y
            @sprite.body.velocity.y = 0
            @sprite.body.acceleration.y = 0
        if y > game.height - 20
            @sprite.body.y = @sprite.body.y - y + game.height - 20
            @sprite.body.velocity.y = 0
            @sprite.body.acceleration.y = 0
    destroy: ->