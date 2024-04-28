bool checkCollision(player, block)
{
  final hitbox = player.hitbox;
  final playerX = player.position.x + hitbox.offsetX;
  final playerY = player.position.y + hitbox.offsetY;
  final playerWidth = hitbox.width;
  final playerHeight = hitbox.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  return 
  (
    playerY < blockWidth + blockHeight && 
    playerY + playerHeight > blockY &&
    playerX < blockX + blockWidth &&
    playerX + playerWidth > blockX
  );
}