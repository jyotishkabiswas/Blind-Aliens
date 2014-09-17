var create, game, preload, update;

preload = function() {
  game.load.image("renderTest", "library/assets/mario.png");
};

create = function() {
  game.add.sprite(400 - 32, 300 - 32, "renderTest");
};

update = function() {};

game = new Phaser.Game(800, 600, Phaser.AUTO, "phaser-stage", {
  preload: preload,
  create: create,
  update: update
});
