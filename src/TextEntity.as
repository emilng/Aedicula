package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;

	public class TextEntity extends Entity
	{
		private var _text:String;
		private var _label:Text;
		private var _size:int;

		public function TextEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			_label = new Text("", x, y);
			_label.color = 0xFFFFFF;
			_label.size = 16;

			this.graphic = _label;
		}

		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			_label.text = value;
		}

		public function get size():int
		{
			return _size;
		}

		public function set size(value:int):void
		{
			_size = value;
			_label.size = value;
		}
	}
}