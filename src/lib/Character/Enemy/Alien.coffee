class Alien extends GameObject

    @STATES:
        UNAWARE: "WAITING"
        AWARE:
            x: 0
            y: 0

    constructor: (@x, @y) ->
        super()
        @state = @constructor.STATES.UNAWARE
        @sprite = game.add.sprite @x, @y, "player"
        game.physics.arcade.enable(@sprite)
        @sprite.body.collideWorldBounds = true
        @sprite.anchor.setTo(0.5,0.75)
        @state = @constructor.STATES.UNAWARE

    update: ->
        if @state is @constructor.STATES.UNAWARE
            @_randomWalk()
        else
            @_awareWalk()

    _randomWalk: ->

    _awareWalk: ->

    destroy: ->