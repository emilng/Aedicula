package
{
	public class Assets
	{
		
//		[Embed(source="assets/demon.png")]
//		public static const DEMON:Class;
		
		[Embed(source = "assets/menu.oel", mimeType = "application/octet-stream")] 
		public static const MENU:Class;

		[Embed(source = "assets/level_01.oel", mimeType = "application/octet-stream")] 
		public static const LEVEL_01:Class;

		[Embed (source = "assets/tilemap.png")]
		public static const TILE_SET:Class;

		[Embed (source = "assets/large-tiles.png")]
		public static const LARGE_TILE_SET:Class;

		[Embed (source = "assets/win.png")]
		public static const WIN:Class;

		public function Assets()
		{
		}
	}
}