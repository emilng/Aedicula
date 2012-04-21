package
{
	public class Assets
	{
		
		[Embed(source="assets/demon.png")]
		public static const DEMON:Class;
		
		[Embed (source = "assets/tilemap.png")]
		public static const TILE_SET:Class;
		
		[Embed (source = "assets/large-tiles.png")]
		public static const LARGE_TILE_SET:Class;
		
		public function Assets()
		{
		}
	}
}