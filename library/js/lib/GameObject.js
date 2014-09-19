var GameObject, GameObjects;

GameObjects = {};

GameObject = (function() {
  function GameObject(loc) {
    this.id = Utils.uuid();
    GameObjects[this.id] = this;
  }

  GameObject.prototype.update = function() {};

  GameObject.prototype.destroy = function() {
    return delete GameObjects[this.id];
  };

  return GameObject;

})();
