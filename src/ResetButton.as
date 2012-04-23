package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class ResetButton extends Entity
	{
		private var _label:Text;
		
		public function ResetButton(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			_label = new Text("RESET");
			_label.color = 0xFFFFFF;
			_label.size = 20;
			
			this.graphic = _label;
		}
		
		override public function update():void 
		{
			var isOver:Boolean = (Input.mouseX > x && 
				Input.mouseX < x + 80 &&
				Input.mouseY > y && 
				Input.mouseY < y + 80);
			
			if (isOver && Input.mousePressed)
			{
				(FP.world as GameWorld).reset((FP.world as GameWorld).levelNum);
			}
		}
	}
}