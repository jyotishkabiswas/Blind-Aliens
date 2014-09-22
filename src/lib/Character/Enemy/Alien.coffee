class Alien extends GameObject

    constructor: (x, y, state) ->
        super(state)
        @type = 'alien'
        @MAX_SPEED = 200
        @MAX_ACCELERATION = 500
        @sprite = game.add.sprite x, y, "enemy"
        @sprite.wrapper = @
        @sprite.scale.setTo 0.3, 0.3
        game.physics.arcade.enable @sprite
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.setTo 0.5,0.5

    update: ->
        @sprite.bringToTop()
        for k, v of @state.GameObjects
            if v.type == 'bullet'
                game.physics.arcade.collide @sprite, v.sprite, @_hitByBullet, null, @
            else
                game.physics.arcade.collide @sprite, v.sprite
        if @state.GameState.playerLocation?
            @_awareWalk()
        else
            @_randomWalk()

    _hitByBullet: (a, b) ->
        a.wrapper.destroy()
        b.wrapper.destroy()

    # Accelerate at a random angle by @MAX_ACCELERATION
    _randomWalk: ->

        d_theta = Math.random() * 2 * Math.PI

        @sprite.body.acceleration.x = @MAX_ACCELERATION*0.5*Math.cos(d_theta)
        @sprite.body.acceleration.y = @MAX_ACCELERATION*0.5*Math.sin(d_theta)


    _awareWalk: ->

        dest = @state.GameState.playerLocation
        distance = Utils.dist @sprite.position, dest
        if distance < @sprite.width
            @state.GameState.playerLocation = null
            return

        dx = dest.x - @sprite.body.position.x
        dy = dest.y - @sprite.body.position.y

        @sprite.body.velocity.x = @MAX_SPEED*dx/distance
        @sprite.body.velocity.y = @MAX_SPEED*dy/distance

    destroy: ->
        @state.GameState.numAliens -= 1
        @sprite.destroy()
        super()