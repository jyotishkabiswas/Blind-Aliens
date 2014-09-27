class AmmoBox extends GameObject

    constructor: (x, y, state) ->
        super(state)

        @type = 'ammo'
        @sprite = game.add.sprite x, y, "ammo"
        @state.backdropPlayer.add @sprite
        @sprite.wrapper = @
        game.physics.arcade.enable @sprite
        @sprite.anchor.x = .5
        @sprite.anchor.y = .5

    update: ->

    destroy: ->
        @sprite.destroy()
        @state.GameState.numAmmoBoxes -= 1
        super()