package tibia.input.gameaction
{
   import tibia.input.IActionImpl;
   import tibia.game.BugReportWidget;
   import tibia.worldmap.WorldMapStorage;
   import tibia.chat.ChatStorage;
   import tibia.network.Connection;
   import mx.events.CloseEvent;
   import mx.resources.ResourceManager;
   import tibia.chat.MessageMode;
   
   public class SendBugReportActionImpl implements IActionImpl
   {
      
      private static const BUNDLE:String = "BugReportWidget";
       
      protected var m_SystemMessage = null;
      
      protected var m_Callback:Function = null;
      
      protected var m_UserMessage:String = null;
      
      public function SendBugReportActionImpl(param1:String = null, param2:* = null, param3:Function = null)
      {
         super();
         this.m_UserMessage = param1;
         this.m_SystemMessage = param2;
         this.m_Callback = param3;
      }
      
      public function perform(param1:Boolean = false) : void
      {
         var _loc3_:BugReportWidget = null;
         var _loc4_:String = null;
         var _loc5_:WorldMapStorage = null;
         var _loc6_:ChatStorage = null;
         var _loc2_:Connection = Tibia.s_GetConnection();
         if(_loc2_ != null && Boolean(_loc2_.allowBugreports) && Boolean(_loc2_.isGameRunning))
         {
            _loc3_ = new BugReportWidget();
            _loc3_.userMessage = this.m_UserMessage;
            _loc3_.systemMessage = this.m_SystemMessage;
            if(this.m_Callback != null)
            {
               _loc3_.addEventListener(CloseEvent.CLOSE,this.m_Callback);
            }
            _loc3_.show();
         }
         else
         {
            _loc4_ = null;
            if(_loc2_ != null && !_loc2_.allowBugreports && Boolean(_loc2_.isGameRunning))
            {
               _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"MSG_NOT_AUHTORIZED");
            }
            else
            {
               _loc4_ = ResourceManager.getInstance().getString(BUNDLE,"MSG_NOT_CONNECTED");
            }
            _loc5_ = Tibia.s_GetWorldMapStorage();
            if(_loc5_ != null)
            {
               _loc5_.addOnscreenMessage(MessageMode.MESSAGE_FAILURE,_loc4_);
            }
            _loc6_ = Tibia.s_GetChatStorage();
            if(_loc6_ != null)
            {
               _loc6_.addChannelMessage(-1,-1,null,0,MessageMode.MESSAGE_FAILURE,_loc4_);
            }
         }
      }
   }
}
