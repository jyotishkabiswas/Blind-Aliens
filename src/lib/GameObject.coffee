GameObjects = {}

class GameObject

    constructor: () ->
        @id = Utils.uuid()
        GameObjects[@id] = @

    update: ->

    destroy: ->
        delete GameObjects[@id]