class Alien extends GameObject

    @STATES:
        UNAWARE: "WAITING"
        AWARE:
            x: 0
            y: 0

    constructor: (x, y) ->
        super()
        @isAlien = true
        @MAX_SPEED = 600
        @state = @constructor.STATES.UNAWARE
        @sprite = game.add.sprite x, y, "circle"
        @sprite.scale.setTo 0.3, 0.3
        game.physics.arcade.enable @sprite
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.setTo 0.5,0.75
        @state = @constructor.STATES.UNAWARE

    update: ->
        @sprite.bringToTop()
        if @state is @constructor.STATES.UNAWARE
            @_randomWalk()
        else
            @_awareWalk()

    # Update velocity matrix with a randomly generated vector
    _randomWalk: ->

        d_theta = Math.random() * 2 * Math.PI
        @sprite.body.acceleration.x = @MAX_SPEED*0.5*Math.cos(d_theta)
        @sprite.body.acceleration.y = @MAX_SPEED*0.5*Math.sin(d_theta)

    _awareWalk: ->
        dx = @sprite.body.position.x - @state.x
        dy = @sprite.body.position.y - @state.y

        scalar = (dx*dx + dy*dy)/(@MAX_SPEED*@MAX_SPEED)

        @sprite.body.velocity.x = dx*scalar
        @sprite.body.velocity.y = dy*scalar

    destroy: ->
        @sprite.destroy()
        super()