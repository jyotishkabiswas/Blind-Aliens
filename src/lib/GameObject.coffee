GameObjects = {}

class GameObject

    constructor: (loc) ->
        @id = Utils.uuid()
        GameObjects[@id] = @

    update: ->

    destroy: ->

        delete GameObjects[@id]