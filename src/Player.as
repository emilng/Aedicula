package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class Player extends Entity
	{
		
		private var _smallPlayer:Graphic;
		private var _largePlayer:Graphic;
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.graphic = Image.createRect(80, 80, 0xFF0000);
			
			setHitbox(80,80);
		}
		
		override public function update():void 
		{
			
			if (Input.released("up")) 		{
				y -= height;
			}
			if (Input.released("down")) 	{
				y += height;
			}
			if (Input.released("left")) 	{
				x -= width;
			}
			if (Input.released("right")) 	{
				x += width;
			}
			
		}
	}
}