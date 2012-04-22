package
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class GateKey extends Entity
	{
		public var color:String;
		
		public function GateKey(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.type = "key";
			
			this.graphic = new Image(Assets.TILE_SET, new Rectangle(20, 0 , 20, 20));
			
			setHitbox(20,20);
		}
		
		// return whether key is blocked
		public function push(direction:String):Boolean {
			var nextX:Number = x;
			var nextY:Number = y;
			
			switch(direction) {
				case "up":
					nextY -= height;
					break;
				case "down":
					nextY += height;
					break;
				case "left":
					nextX -= width;
					break;
				case "right":
					nextX += width;
					break;
			}
			
			if (!collide("solid", nextX, nextY) && !collide("gate", nextX, nextY) && !collide("key", nextX, nextY)) {
				x = nextX;
				y = nextY;
				return false;
			}
			return true;
		}
	}
}