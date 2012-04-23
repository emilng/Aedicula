package
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	
	public class GameWorld extends World
	{

		
		public function GameWorld()
		{
			super();
		}
		
		private var _keys:Array = [];
		public var collectedKey:GateKey;
		private var _endGates:Array = [];
		private var _gateColors:Object = {};
		public var hasWon:Boolean = false;
		private var _winImage:Entity;
		private var _titleImage:Entity;
		public var hideText:Boolean = false;
		private var _texts:Array = [];
		public var levelNum:int;

		override public function begin():void
		{
			reset(0);
			super.begin();
		}

		public function reset(levelNum:int):void {
			this.levelNum = levelNum;
			this.removeAll();

			_keys = [];
			collectedKey = null;
			_endGates = [];
			_gateColors = {};
			hasWon = false;
			hideText = false;
			_texts = [];

			var levelClass:Class;

			switch(levelNum) {
				case 1:
					levelClass = Assets.LEVEL_01;
					break;
				case 2:
					levelClass = Assets.LEVEL_02;
					break;
				case 3:
					levelClass = Assets.LEVEL_03;
					break;
				case 4:
					levelClass = Assets.LEVEL_04;
					break;
				default:
					levelClass = Assets.MENU;
					break;
			}

			var level:Level = Level(add(new Level(levelClass)));

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

			dataList = level.levelData.objects.levelSelect;
			for each(dataElement in dataList) {
				var levelButton:LevelButton = new LevelButton(int(dataElement.@x), int(dataElement.@y));
				levelButton.level = int(dataElement.@level);
				add (levelButton);
			}

			dataList = level.levelData.objects.playerStart;
			for each(dataElement in dataList) {
				add (new Player(int(dataElement.@x), int(dataElement.@y)));
			}

			dataList = level.levelData.objects.win;
			for each(dataElement in dataList) {
				add (new WinEntity(int(dataElement.@x), int(dataElement.@y)));
			}

			dataList = level.levelData.objects.instructions;
			for each(dataElement in dataList) {
				var textEntity:TextEntity = new TextEntity(int(dataElement.@x), int(dataElement.@y));
				textEntity.text = dataElement.@verbiage;
				textEntity.size = int(dataElement.@size);
				_texts.push(textEntity);
				add (textEntity);
			}

			_winImage = new Entity(200, 280, new Image(Assets.WIN));
			_winImage.visible = false;
			add(_winImage);

			if (levelNum == 0) {
				_titleImage = new Entity(162, 180, new Image(Assets.TITLE));
				add(_titleImage);
			} else {
				add(new MenuButton(500, 0));
				add(new ResetButton(580, 0));
			}
		}

		override public function update():void
		{
			super.update();

			if (collectedKey) {
				var keyColor:String = collectedKey.color;
				if (keyColor == "all") {
					removeKey(_keys, collectedKey);
				} else {
					removeKey(_gateColors[keyColor].keys, collectedKey);
				}
				collectedKey = null;

				openGates(_keys, _endGates);
				if (keyColor != "all") {
					openGates(_gateColors[keyColor].keys, _gateColors[keyColor].gates);
				}
			}

			if (hasWon) {
				_winImage.visible = true;
				if (Input.mousePressed) {
					reset(0);
				}
			}

			if (hideText) {
				for each (var textEntity:TextEntity in _texts) {
					textEntity.visible = false;
				}
			}
		}

		private function removeKey(keys:Array, key:GateKey):void {
			var keyIndex:int = keys.indexOf(key);
			if (keyIndex >= 0) {
				keys.splice(keyIndex, 1);
			}
			if (keys) {
				keyIndex = _keys.indexOf(key);
				if (keyIndex >= 0) {
					_keys.splice(keyIndex, 1);
				}
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