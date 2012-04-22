package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity
	{
		
		private var _smallPlayer:Graphic;
		private var _largePlayer:Graphic;
		
		private var _isSizeChanging:Boolean = false;
		private var _isLarge:Boolean = true;
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			_smallPlayer = Image.createRect(20, 20, 0xFF0000);
			_largePlayer = Image.createRect(80, 80, 0xFF0000);
			
			this.graphic = _largePlayer;
			
			setHitbox(80,80);
		}
		
		override public function update():void 
		{
			var previousX:Number = x;
			var previousY:Number = y;
			var nextX:Number = x;
			var nextY:Number = y;
			
			var dir:String = "";

			if (Input.released("up")) 		{
				nextY -= height;
				dir = "up";
			}
			if (Input.released("down")) 	{
				nextY += height;
				dir = "down";
			}
			if (Input.released("left")) 	{
				nextX -= width;
				dir = "left";
			}
			if (Input.released("right")) 	{
				nextX += width;
				dir = "right";
			}
			
			var gateKey:GateKey = (collide("key", nextX, nextY) as GateKey);
			var blocked:Boolean = false;
			if (gateKey) {
				if (_isLarge) {
					(FP.world as GameWorld).collectedKey = gateKey;
				} else {
					blocked = gateKey.push(dir);
				}
			}

			if (!collide("solid", nextX, nextY) && !collide("gate", nextX, nextY) && !blocked) {
				x = nextX;
				y = nextY;
			}

			var sizeChanger:Entity = collide("sizeChanger", x, y);
			if (sizeChanger) {
				if (!_isSizeChanging) {
					_isSizeChanging = true;
					if (_isLarge) {
						this.graphic = _smallPlayer;
						if (previousX < x) {
							x = sizeChanger.x;
						} else if (previousX > x) {
							x = sizeChanger.x + 60;
						} else {
							x = sizeChanger.x + 20;
						}
						if (previousY < y) {
							y = sizeChanger.y;
						} else if (previousY > y) {
							y = sizeChanger.y + 60;
						} else {
							y = sizeChanger.y + 20;
						}
						setHitbox(20,20);
					} else {
						this.graphic =_largePlayer;
						x = sizeChanger.x;
						y = sizeChanger.y;
						setHitbox(80,80);
					}
					_isLarge = !_isLarge;
				}
			} else {
				_isSizeChanging = false;
			}
		}
	}
}