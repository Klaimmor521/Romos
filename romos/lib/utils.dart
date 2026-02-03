bool checkCollision(character, block)
{
  final hitbox = character.hitbox;
  
  final scaleX = character.scale.x;
  final scaleY = character.scale.y;

  // Умножаем отступы и размеры на масштаб (scale)!
  final characterX = character.position.x + (hitbox.offsetX * scaleX);
  final characterY = character.position.y + (hitbox.offsetY * scaleY);
  final characterWidth = hitbox.width * scaleX;
  final characterHeight = hitbox.height * scaleY;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  return (
    characterY < blockY + blockHeight &&
    characterY + characterHeight > blockY &&
    characterX < blockX + blockWidth &&
    characterX + characterWidth > blockX
  );
}