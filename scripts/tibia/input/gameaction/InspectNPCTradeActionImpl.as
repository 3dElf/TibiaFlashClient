package tibia.input.gameaction
{
   import tibia.input.IActionImpl;
   import tibia.network.Connection;
   import tibia.appearances.AppearanceTypeRef;
   
   public class InspectNPCTradeActionImpl implements IActionImpl
   {
       
      protected var m_Object:AppearanceTypeRef = null;
      
      public function InspectNPCTradeActionImpl(param1:AppearanceTypeRef)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("InspectNPCTradeActionImpl.InspectNPCTradeActionImpl: Invalid obejct.");
         }
         this.m_Object = param1;
      }
      
      public function perform(param1:Boolean = false) : void
      {
         var _loc2_:Connection = Tibia.s_GetConnection();
         if(_loc2_ != null && Boolean(_loc2_.isGameRunning))
         {
            _loc2_.sendCINSPECTNPCTRADE(this.m_Object.ID,this.m_Object.data);
         }
      }
   }
}
