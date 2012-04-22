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
		
		override public function begin():void
		{
			var level:Level = Level(add(new Level(DEFAULT_MAP)));

			var dataList:XMLList;
			var dataElement:XML;
			dataList = level.levelData.objects.playerStart;
			for each(dataElement in dataList) {
				add (new Player(int(dataElement.@x), int(dataElement.@y)));
			}
			super.begin();
		}
	}
}