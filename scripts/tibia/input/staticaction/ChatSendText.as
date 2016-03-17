package tibia.input.staticaction
{
   import tibia.chat.ChatWidget;
   import tibia.options.OptionsStorage;
   import tibia.input.MappingSet;
   
   public class ChatSendText extends StaticAction
   {
       
      public function ChatSendText(param1:int, param2:String, param3:uint, param4:Boolean)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function perform(param1:Boolean = false) : void
      {
         var _loc3_:ChatWidget = null;
         var _loc2_:OptionsStorage = Tibia.s_GetOptions();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.generalInputSetMode == MappingSet.CHAT_MODE_OFF)
         {
            _loc2_.generalInputSetMode = MappingSet.CHAT_MODE_TEMPORARY;
         }
         else
         {
            _loc3_ = Tibia.s_GetChatWidget();
            if(_loc3_ != null)
            {
               _loc3_.onChatSend();
            }
            if(_loc2_.generalInputSetMode == MappingSet.CHAT_MODE_TEMPORARY)
            {
               _loc2_.generalInputSetMode = MappingSet.CHAT_MODE_OFF;
            }
         }
      }
   }
}
