package
{
	import net.flashpunk.World;
	
	
	public class GameWorld extends World
	{
		[Embed(source = "assets/level_01.oel", mimeType = "application/octet-stream")] 
		private static const DEFAULT_MAP:Class;
		
		public function GameWorld()
		{
			super();
		}
		
		private var _keys:Array = [];
		public var collectedKey:GateKey;
		private var _gates:Array = [];

		override public function begin():void
		{
			var level:Level = Level(add(new Level(DEFAULT_MAP)));

			var dataList:XMLList;
			var dataElement:XML;

			dataList = level.levelData.objects.sizeChanger;
			for each(dataElement in dataList) {
				add (new SizeChanger(int(dataElement.@x), int(dataElement.@y)));
			}

			dataList = level.levelData.objects.gate;
			for each(dataElement in dataList) {
				var gate:Gate = new Gate(int(dataElement.@x), int(dataElement.@y));
				_gates.push(gate);
				add (gate);
			}

			dataList = level.levelData.objects.key;
			for each(dataElement in dataList) {
				var gateKey:GateKey = new GateKey(int(dataElement.@x), int(dataElement.@y));
				_keys.push(gateKey);
				add (gateKey);
			}

			dataList = level.levelData.objects.playerStart;
			for each(dataElement in dataList) {
				add (new Player(int(dataElement.@x), int(dataElement.@y)));
			}

			super.begin();
		}

		override public function update():void
		{
			super.update();

			if (collectedKey) {
				var keyIndex:int = _keys.indexOf(collectedKey);
				_keys.splice(keyIndex, 1);
				remove(collectedKey);
				collectedKey = null;

				if (_keys.length == 0) {
					for each (var gate:Gate in _gates) {
						remove(gate);
					}
					_gates.length = 0;
				}
			}
		}
	}
}