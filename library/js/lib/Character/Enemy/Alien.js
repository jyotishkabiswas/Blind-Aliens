var Alien,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Alien = (function(_super) {
  __extends(Alien, _super);

  function Alien(loc) {}

  Alien.prototype.update = function() {};

  Alien.prototype.destroy = function() {};

  return Alien;

})(GameCharacter);
