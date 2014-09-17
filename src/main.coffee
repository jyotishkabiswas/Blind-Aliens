preload = ->
  game.load.image "renderTest", "library/assets/mario.png"
  return

create = ->
  game.add.sprite 400 - 32, 300 - 32, "renderTest"
  return

update = ->

game = new Phaser.Game(800, 600, Phaser.AUTO, "phaser-stage",
  preload: preload
  create: create
  update: update
)