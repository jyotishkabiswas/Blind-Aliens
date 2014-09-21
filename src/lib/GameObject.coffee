GameObjects = {}

class GameObject

    constructor: ->
        @isAlien = false
        @id = Utils.uuid()
        GameObjects[@id] = @

    update: ->

    destroy: ->
        delete GameObjects[@id]