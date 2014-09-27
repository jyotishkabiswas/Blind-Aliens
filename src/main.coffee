debugging = false
game = new Phaser.Game 800, 600, Phaser.AUTO, "phaser-stage"
game.state.add "menu", Menu
game.state.add "play", Play
game.state.add "game_over", GameOver
game.state.start "menu"
