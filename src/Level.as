package
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class Level extends Entity
	{
		
		private var _small_tiles:Tilemap;
		private var _large_tiles:Tilemap;
		private var _grid:Grid;
		public var levelData:XML;
		
		
		
		public function Level(xml:Class)
		{
			_large_tiles = new Tilemap(Assets.LARGE_TILE_SET, 640, 640, 80, 80);
			_small_tiles = new Tilemap(Assets.TILE_SET, 640, 640, 20, 20);
			_grid = new Grid(640, 640, 20, 20);
			
			graphic = new Graphiclist(_large_tiles, _small_tiles);
			
			this.mask = _grid;
			this.type = "solid";
			
			loadLevel(xml);
			
			var dataList:XMLList;
			var dataElement:XML;
			dataList = levelData.large_tiles.tile;
			for each (dataElement in dataList) 
			{
				_large_tiles.setTile(int(dataElement.@x), 
					int(dataElement.@y),
					int(dataElement.@tx));
			}
			
			dataList = levelData.small_tiles.tile;
			for each (dataElement in dataList) 
			{
				_small_tiles.setTile(int(dataElement.@x), 
					int(dataElement.@y),
					int(dataElement.@tx));
			}

			_grid.loadFromString(levelData.solids.toString(),"");
			
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			levelData = new XML(dataString);
		}
	}
}