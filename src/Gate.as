package
{
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Gate extends Entity
	{
		private var _color:String;

		public function Gate(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.type = "gate";
			
			this.graphic = new Image(Assets.TILE_SET, new Rectangle(0, 0, 20, 20));
				
			setHitbox(20, 20);
		}

		public function get color():String
		{
			return _color;
		}

		public function set color(value:String):void
		{
			_color = value;

			switch (value) {
				case "all":
					this.graphic = new Image(Assets.TILE_SET, new Rectangle(0, 0 , 20, 20));
					break;
				case "red":
					this.graphic = new Image(Assets.TILE_SET, new Rectangle(20, 0 , 20, 20));
					break;
				case "blue":
					this.graphic = new Image(Assets.TILE_SET, new Rectangle(40, 0 , 20, 20));
					break;
				case "yellow":
					this.graphic = new Image(Assets.TILE_SET, new Rectangle(60, 0 , 20, 20));
					break;
			}
		}
	}
}