package tibia.game
{
   public class SpritesAsset extends Asset
   {
       
      private var m_FirstSpriteID:uint = 0;
      
      public function SpritesAsset(param1:String, param2:int, param3:uint)
      {
         super(param1,param2);
         if((param3 & 2147483648) != 0)
         {
            throw new ArgumentError("SpritesAsset.SpritesAsset: Invalid sprite ID " + param3 + ".");
         }
         this.m_FirstSpriteID = param3;
      }
      
      public function get firstSpriteID() : uint
      {
         return this.m_FirstSpriteID;
      }
   }
}
