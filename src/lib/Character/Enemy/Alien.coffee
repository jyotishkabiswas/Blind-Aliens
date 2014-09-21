class Alien extends GameObject

    @STATES:
        UNAWARE: "WAITING"
        AWARE:
            x: 0
            y: 0

    constructor: (x, y) ->
        super()
        @type = 'alien'
        @MAX_SPEED = 200
        @MAX_ACCELERATION = 500
        @state = @constructor.STATES.UNAWARE
        @sprite = game.add.sprite x, y, "alien"
        @sprite.scale.setTo 0.3, 0.3
        game.physics.arcade.enable @sprite
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.setTo 0.5,0.75
        @state = @constructor.STATES.UNAWARE

    update: ->
        @sprite.bringToTop()
        for k, v of GameObjects
            if v.type == 'bullet'
                game.physics.arcade.collide @sprite, v.sprite, @destroy, null, @
            else
                game.physics.arcade.collide @sprite, v.sprite
        if GameState.playerLocation?
            @state = GameState.playerLocation
        else
            @state = @constructor.STATES.UNAWARE
        if @state is @constructor.STATES.UNAWARE
            @_randomWalk()
        else
            @_awareWalk()

    # Update velocity matrix with a randomly generated vector
    _randomWalk: ->

        d_theta = Math.random() * 2 * Math.PI

        @sprite.body.acceleration.x = @MAX_ACCELERATION*0.5*Math.cos(d_theta)
        @sprite.body.acceleration.y = @MAX_ACCELERATION*0.5*Math.sin(d_theta)

    _awareWalk: ->

        distance = Utils.dist @sprite.position, @state

        if distance < @sprite.width
            GameState.playerLocation = null
            return

        dx = @state.x - @sprite.body.position.x
        dy = @state.y - @sprite.body.position.y

        angle = (dx*dx + dy*dy)/(@MAX_SPEED*@MAX_SPEED)

        @sprite.body.velocity.x = @MAX_SPEED*dx/distance
        @sprite.body.velocity.y = @MAX_SPEED*dy/distance

    destroy: ->
        @sprite.destroy()
        super()
