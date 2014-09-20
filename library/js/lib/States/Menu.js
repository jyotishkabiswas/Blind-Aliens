var Menu;

Menu = function() {};

Menu.prototype = {
  preload: function() {},
  create: function() {
    var instructionsText, titleText;
    titleText = game.add.text(game.world.centerX, 150, "Blind Aliens", {
      font: '65px Arial',
      fill: '#ffffff',
      align: 'center'
    });
    titleText.anchor.setTo(0.5, 0.5);
    instructionsText = game.add.text(game.world.centerX, 300, 'Click anywhere to play the game', {
      font: '16px Arial',
      fill: '#bbbbbb',
      align: 'center'
    });
    instructionsText.anchor.setTo(0.5, 0.5);
  },
  update: function() {
    if (game.input.activePointer.justPressed()) {
      game.state.start("play");
    }
  }
};
