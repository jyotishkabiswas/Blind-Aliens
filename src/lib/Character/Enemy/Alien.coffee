class Alien extends GameObject

    constructor: (x, y, state) ->
        super(state)

        @type = 'alien'

        #unclear whether we use score right now, but it's in here
        @SCORE_VALUE = 1000

        #various sprite details
        @sprite = game.add.sprite x, y, "enemy"
        @sprite.wrapper = @
        @sprite.scale.setTo 0.3, 0.3
        game.physics.arcade.enable @sprite
        @sprite.animations.add "crawl"
        @crawl = @sprite.play "crawl", 8, true
        @sprite.anchor.setTo 0.5,0.5
        @sprite.alpha = 1

        # of lives left for this alien
        @alive = 2

        # how many frames the alien must still be stunned from a gunshot
        @stunCountdown = 0
        
        # start the alien facing into the middle
        centerx = 200 + Math.random() * (game.width - 400)
        centery = 200 + Math.random() * (game.height - 400)
        x = @sprite.body.x + @sprite.width / 2
        y = @sprite.body.y + @sprite.height / 2
        @sprite.angle = (180 / Math.PI * Math.atan2 (centerx - x), -(centery - y))
        
        # how many frames the alien will remember that you exist after he doesn't find you
        @soundCountdown = 0
        
        # how many frames the alien will continue doing its current action
        @moveCountdown = 0

        # the current action (should we turn? go forward?)
        @dtheta = 0
        @dr = 0

        # twice the number of times the alien will return into the middle of the board if he does not find you before he decides to leave
        @returnQuantity = 10

        # 1 iff the alien is investigating a sound
        @locationNotTouched = 0

        # the location of the sound
        @locationx = 0
        @locationy = 0

    update: ->
        # redraw to top
        @sprite.bringToTop()

        # if too far off the field, the alien leaves
        x = @sprite.body.x + @sprite.width / 2
        y = @sprite.body.y + @sprite.height / 2
        if (x < -100 or y < -100 or x > game.width + 100 or y > game.height + 100)
            @destroy()

        # this part describes what happens if the alien is not dying
        if @alive > 0
            # see if the alien got shot
            for k, v of @state.GameObjects
                if v.type == 'bullet'
                    game.physics.arcade.collide @sprite, v.sprite, null, @_hitByBullet, @
            
            # add drag to alien motion
            @sprite.body.velocity.x *= .97
            @sprite.body.velocity.y *= .97

            # count down all of the timers
            @moveCountdown = @moveCountdown - 1 if @moveCountdown > 0
            @soundCountdown = @soundCountdown - 1 if @soundCountdown > 0
            if @stunCountdown > 0
                @stunCountdown = @stunCountdown - 1
                @crawl.isPaused = false if @stunCountdown <= 0
            
            # if the alien is not stunned, it should do something
            else
                @_walk()

        # this is essentially just a dying animation
        else
            @sprite.body.acceleration.x = 0
            @sprite.body.acceleration.y = 0
            @sprite.body.velocity.x *= .97
            @sprite.body.velocity.y *= .97
            @sprite.alpha = @sprite.alpha - 0.01
            @crawl.isPaused = true
            @destroy() if @sprite.alpha <= 0

    _hitByBullet: (a, b) ->
        # player gets points for the hit
        a.wrapper.state.score = a.wrapper.state.score + a.wrapper.SCORE_VALUE / 2

        # stun the alien
        a.wrapper.crawl.isPaused = true
        a.wrapper.stunCountdown = 60

        # take one life
        a.wrapper.alive = a.wrapper.alive - 1

        # color the alien darker green
        a.tint = 0x005500

        # make the bullet push the alien
        a.body.velocity.x += b.body.velocity.x / 5
        a.body.velocity.y += b.body.velocity.y / 5
        a.body.acceleration.x = 0
        a.body.acceleration.y = 0

        # delete the bullet
        b.wrapper.destroy()

        # return false so that normal collision between the bullet and alien doesn't run
        false

    _walk: ->
        # if in the middle of an action, continue as appropriate
        if @moveCountdown > 0
            @sprite.angle += @dtheta
            xComponent = Math.sin (@sprite.angle * Math.PI / 180)
            yComponent = Math.cos (@sprite.angle * Math.PI / 180)
            # the alien is slower if already half dead
            multiplier = if @alive == 2 then 2 else 1.7
            @sprite.body.velocity.x = @dr * xComponent * 100 * @alive
            @sprite.body.velocity.y = -@dr * yComponent * 100 * @alive
        # start a new action
        else
            @sprite.body.acceleration.x = 0
            @sprite.body.acceleration.y = 0
            
            # the null hypothesis is that we want random motion for random duration
            # each move is either rotation or forward motion
            @moveCountdown = Math.random() * 20 + 15
            @dtheta = if Math.random() > .33 then Math.random() * 4 - 2 else 0
            @dr = if @dtheta == 0 then 0.8 + Math.random() * .2 else 0

            # if the alien is too close to the edge, turn back
            x = @sprite.body.x + @sprite.width / 2
            y = @sprite.body.y + @sprite.height / 2
            if (x < 0 or y < 0 or x > game.width or y > game.height) and (@returnQuantity > 0 or @soundCountdown > 0)
                # if the alien knows you are there, he won't stop turning back
                # if he doesn't, he might leave after some number of tries
                @returnQuantity += if @soundCountdown == 0 then -1 else 1
                if @returnQuantity % 2 == 1
                    # to return, first turn
                    centerx = 200 + Math.random() * (game.width - 400)
                    centery = 200 + Math.random() * (game.height - 400)
                    @_target centerx, centery
                else
                    # after that, move
                    @dtheta = 0
                    @dr = 0.8 + Math.random() * .2
            # if the alien is investigating a sound, do the following instead of the above
            if @locationNotTouched == 1
                # turn towards the sound source
                @_target @locationx, @locationy
                # while also moving forward
                @dr = if @moveCountdown < 70 then 1 else 0.5
                # also turn faster than normal
                @dtheta *= 2
                # recalculate every 5 turns
                @moveCountdown = 5
                # if close to the sound source, stop looking
                @locationNotTouched = 0 if (x - @locationx) * (x - @locationx) + (y - @locationy) * (y - @locationy) <= 100 * 100
                # remember that the player exists instead of gradually forgetting
                @soundCountdown = @soundCountdown + 1

    # this function creates an action that will turn the alien towards the input coordinates
    _target: (targetx, targety) ->
        x = @sprite.body.x + @sprite.width / 2
        y = @sprite.body.y + @sprite.height / 2
        @dtheta = 1
        @dr = 0
        ang = (180 / Math.PI * Math.atan2 (targetx - x), -(targety - y))
        @moveCountdown = ((ang - @sprite.angle) + 360) % 360
        @dtheta = -1 if @moveCountdown > 180
        @moveCountdown = 360 - @moveCountdown if @moveCountdown > 180

    # this function reports a sound to the alien and has him act upon it iff the sound is close enough to hear
    hear: (noisex, noisey, vol) ->
        x = @sprite.body.x + @sprite.width / 2
        y = @sprite.body.y + @sprite.height / 2
        if (x - noisex) * (x - noisex) + (y - noisey) * (y - noisey) <= vol * vol
            @locationx = noisex + Math.random() * 200 - 100
            @locationy = noisey + Math.random() * 200 - 100
            @locationNotTouched = 1
            @soundCountdown = 5000

    # cleanup
    destroy: ->
        @state.GameState.numAliens -= 1
        @sprite.destroy()
        super()