package tibia.game
{
   import loader.asset.Cache;
   
   public class SpritesAsset extends Asset
   {
       
      private var m_FirstSpriteID:uint = 0;
      
      public function SpritesAsset(param1:Cache, param2:String, param3:int, param4:uint)
      {
         super(param1,param2,param3);
         if((param4 & 2147483648) != 0)
         {
            throw new ArgumentError("SpritesAsset.SpritesAsset: Invalid sprite ID " + param4 + ".");
         }
         this.m_FirstSpriteID = param4;
      }
      
      public function get firstSpriteID() : uint
      {
         return this.m_FirstSpriteID;
      }
   }
}
