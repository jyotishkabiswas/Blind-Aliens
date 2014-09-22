class Circle extends GameObject

    constructor: (x, y, @r, state) ->
        super(state)
        @sprite = game.add.sprite x, y, "circle"
        @sprite.anchor.x = .5
        @sprite.anchor.y = .5
        @sprite.width = 10
        @sprite.height = 10
        @r

    update: ->
        val = 1.06 * @sprite.width
        @sprite.width = val
        @sprite.height = val
        @sprite.alpha = 0.3 * (1.0 - (val / @r))
        if @invalid()
            @destroy()

    invalid: ->
        @sprite.height > 2 * @rad

    destroy: ->
        @sprite.destroy()
        @sfx.destroy()
        super()