class GameObject

    constructor: (@state) ->
        @isAlien = false
        @id = Utils.uuid()
        @state.GameObjects[@id] = @

    update: ->

    destroy: ->
        delete @state.GameObjects[@id]