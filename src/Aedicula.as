package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Aedicula extends Engine
	{
		private var _gameWorld:GameWorld;
		
		public function Aedicula()
		{
			super(640, 640, 60, false);
			
			Input.define("up", Key.UP, Key.W);
			Input.define("down", Key.DOWN, Key.S);
			Input.define("left", Key.LEFT, Key.A);
			Input.define("right", Key.RIGHT, Key.D);
			
			_gameWorld = new GameWorld();
			
			FP.screen.color = 0xFFFFFF;
			FP.engine = this;
			FP.world = _gameWorld as World;
		}
	}
}