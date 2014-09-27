class Bullet extends GameObject

    constructor: (x, y, angle, state) ->
        super(state)
        @type = 'bullet'
        @sprite = game.add.sprite x, y, "bullet"
        @sprite.wrapper = @
        @sprite.anchor.x = .5
        @sprite.anchor.y = .5
        @sprite.scale.setTo 0.4, 0.4
        @sprite.tint = 0xffffff
        game.physics.arcade.enable @sprite
        @sprite.body.checkWorldBounds = true
        @sprite.events.onOutOfBounds.add(@destroy, @)

        @BULLET_SPEED = 1000

        velocity =
            x: @BULLET_SPEED * Math.cos(angle)
            y: @BULLET_SPEED * Math.sin(angle)

        @sprite.body.velocity = velocity

    update: ->
        @sprite.bringToTop()

    destroy: ->
        @sprite.destroy()
        super()
