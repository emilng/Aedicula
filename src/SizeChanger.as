package
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class SizeChanger extends Entity
	{
		public function SizeChanger(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.type = "sizeChanger";
			
			this.graphic = new Image(Assets.LARGE_TILE_SET, new Rectangle(80, 0, 80, 80));
			
			setHitbox(80, 80);
		}
	}
}