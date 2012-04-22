package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	public class LevelButton extends Entity
	{
		public var level:int;
		
		private var _over:Graphic;
		private var _out:Graphic;
		
		public function LevelButton(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			_over = Image.createRect(80, 80, 0xFFFFFF, 0.2);
			_out = Image.createRect(80, 80, 0xFFFFFF, 0);
			this.graphic = _out;
		}
		
		override public function update():void 
		{
			var isOver:Boolean = (Input.mouseX > x && 
									Input.mouseX < x + 80 &&
									Input.mouseY > y && 
									Input.mouseY < y + 80);
			
			this.graphic = (isOver) ? _over : _out;
			if (isOver && Input.mousePressed)
			{
				trace("click level", level);
			}
			
		}
	}
}