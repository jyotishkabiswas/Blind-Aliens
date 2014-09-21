class ShadowMask extends GameObject

    constructor: (player) -> 
        @player = player 
        @x = @player.x - 800 
        @y = @player.y - 600
        @sprite = game.add.sprite @x, @y, "shadowmask" 
             
    update: ->
        @sprite.x = @player.sprite.x - 800
        @sprite.y = @player.sprite.y - 600
