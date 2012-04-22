package
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class WinEntity extends Entity
	{
		public function WinEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			this.type = "win";
				
			setHitbox(20, 20);
		}
		
	}
}