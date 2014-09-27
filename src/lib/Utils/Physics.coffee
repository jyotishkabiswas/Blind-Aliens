Physics = 

    # sprite1 and sprite2 must have physicsBody property defined.
    # It needs to hold the locations of circles.
    collides: (sprite1, sprite2) ->
        circles1 = @calculateCircles(sprite1)
        circles2 = @calculateCircles(sprite2)
        for circle1 in circles1
            for circle2 in circles2
                if Math.pow(circle1.x-circle2.x,2)+Math.pow(circle1.y-circle2.y,2) <= Math.pow(circle1.radius+circle2.radius,2)
                    console.log circle1, circle2
                    return true
        return false

    calculateCircles: (sprite) ->
        result = []
        for circle in sprite.physicsBody
            dx = (circle.x - sprite.anchor.x) * sprite.body.width
            dy = (circle.y - sprite.anchor.y) * sprite.body.height
            r = Math.sqrt(dx*dx+dy*dy)
            rad = sprite.rotation + Math.PI - Math.atan2(dx, dy)
            new_dx = r*Math.sin(rad)
            new_dy = -r*Math.cos(rad)
            result.push {
                x: sprite.body.x + sprite.body.width * sprite.anchor.x + new_dx,
                y: sprite.body.y + sprite.body.height* sprite.anchor.y + new_dy,
                radius: circle.radius * sprite.scale.x
            }
        return result
