Utils = {}

Utils.uuid = ->

    'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) ->
        r = Math.random() * 16 | 0
        v = if c is 'x' then r else (r & 0x3|0x8)
        v.toString(16)
    )

Utils.dist = (a, b) ->
    dx = a.x - b.x
    dy = a.y - b.y
    Math.sqrt(dx*dx + dy*dy)