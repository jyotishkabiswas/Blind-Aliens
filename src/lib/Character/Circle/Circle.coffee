Circles = []

class Circle extends GameObject

    constructor: (@x, @y, @r) ->
        @sprite = game.add.sprite @x, @y, "circle"
        @sprite.anchor.x = .5
        @sprite.anchor.y = .5
        @sprite.width = 10
        @sprite.height = 10
        @rad = @r 
        Circles.push @

    update: ->
        val = 3 + @sprite.width
        @sprite.width = val
        @sprite.height = val
        @sprite.alpha = 1.0 - val / @rad
        if @invalid()
            @destroy()
    invalid: ->
        @sprite.height > 2 * @rad
    destroy: ->
        @sprite.destroy()
        Circles = (circle for circle in Circles when circle != @)