package
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Gate extends Entity
	{
		public var color:String;

		public function Gate(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.type = "gate";
			
			this.graphic = new Image(Assets.TILE_SET, new Rectangle(0, 0, 20, 20));
				
			setHitbox(20, 20);
		}
	}
}