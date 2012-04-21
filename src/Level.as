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
		public var LevelData:XML;
		
		
		
		public function Level(xml:Class)
		{
			_large_tiles = new Tilemap(Assets.LARGE_TILE_SET, 640, 640, 80, 80);
			_small_tiles = new Tilemap(Assets.TILE_SET, 640, 640, 20, 20);
			_grid = new Grid(640, 640, 20, 20);
			
			graphic = _large_tiles;
//			graphic = new Graphiclist(_large_tiles);//, _small_tiles);
			
			type = "level";
			
			loadLevel(xml, _large_tiles, "large_tiles");
		}
		
		private function loadLevel(xml:Class, tiles:Tilemap, setName:String, grid:*= null):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			dataList = xmlData[setName].tile;
			trace(dataList);
			for each (dataElement in dataList) 
			{
				trace(int(dataElement.@x),int(dataElement.@y));
				tiles.setTile(int(dataElement.@x), 
								int(dataElement.@y),
								int(dataElement.@tx));
			}
			dataList = xmlData.tiles.solids;
			trace(dataList);
			if (grid)
			{
				for each (dataElement in dataList) 
				{
					grid.setTile(int(dataElement.@x), 
						int(dataElement.@y),
						(int(dataElement.@tx) == 1));
				}
			}
		}
	}
}