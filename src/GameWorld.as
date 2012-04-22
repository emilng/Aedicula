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
		private var _endGates:Array = [];
		private var _gateColors:Object = {};

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
				gate.color = dataElement.@color;
				if (gate.color == "all") {
					_endGates.push(gate);
				}
				addGate(gate);
				add (gate);
			}

			dataList = level.levelData.objects.key;
			for each(dataElement in dataList) {
				var gateKey:GateKey = new GateKey(int(dataElement.@x), int(dataElement.@y));
				gateKey.color = dataElement.@color;
				_keys.push(gateKey);
				addKey(gateKey);
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
				var keyColor:String = collectedKey.color;
				removeKey(_gateColors[keyColor].keys, collectedKey);
				collectedKey = null;

				openGates(_keys, _endGates);
				openGates(_gateColors[keyColor].keys, _gateColors[keyColor].gates);
			}
		}

		private function removeKey(keys:Array, key:GateKey):void {
			var keyIndex:int = keys.indexOf(key);
			keys.splice(keyIndex, 1);
			if (keys) {
				keyIndex = _keys.indexOf(key);
				_keys.splice(keyIndex, 1);
			}
			remove(key);
		}

		private function addKey(key:GateKey):void {
			if (key.color != "all") {
				if (_gateColors.hasOwnProperty(key.color)) {
					if (_gateColors[key.color].hasOwnProperty("keys")) {
						_gateColors[key.color].keys.push(key);
					} else {
						_gateColors[key.color].keys = [key];
					}
				} else {
					_gateColors[key.color] = {keys:[key]};
				}
			}
		}

		private function addGate(gate:Gate):void {
			if (gate.color != "all") {
				if (_gateColors.hasOwnProperty(gate.color)) {
					if (_gateColors[gate.color].hasOwnProperty("gates")) {
						_gateColors[gate.color].gates.push(gate);
					} else {
						_gateColors[gate.color].gates = [gate];
					}
				} else {
					_gateColors[gate.color] = {gates:[gate]};
				}
			}
		}

		private function openGates(keys:Array, gates:Array):void {
			if (keys &&
				keys.length == 0 &&
				gates &&
				gates.length > 0) {
				for each (var gate:Gate in gates) {
					remove(gate);
				}
				gates.length = 0;
			}
		}
	}
}