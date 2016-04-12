package tibia.input.staticaction
{
    import tibia.input.*;
    import tibia.options.*;

    public class ChatSendText extends StaticAction
    {

        public function ChatSendText(param1:int, param2:String, param3:uint, param4:Boolean)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetOptions();
            if (_loc_2 == null)
            {
                return;
            }
            if (_loc_2.generalInputSetMode == MappingSet.CHAT_MODE_OFF)
            {
                _loc_2.generalInputSetMode = MappingSet.CHAT_MODE_TEMPORARY;
            }
            else
            {
                Tibia.s_GameActionFactory.createTalkAction(null, true).perform();
                if (_loc_2.generalInputSetMode == MappingSet.CHAT_MODE_TEMPORARY)
                {
                    _loc_2.generalInputSetMode = MappingSet.CHAT_MODE_OFF;
                }
            }
            return;
        }// end function

    }
}
