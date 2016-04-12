package tibia.input.staticaction
{
    import tibia.chat.*;

    public class ChatChannelClose extends StaticAction
    {
        private var m_LeftChannel:Boolean = true;

        public function ChatChannelClose(param1:int, param2:String, param3:uint, param4:Boolean)
        {
            super(param1, param2, param3, false);
            this.m_LeftChannel = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetChatStorage();
            if (_loc_2 == null)
            {
                return;
            }
            var _loc_3:* = Tibia.s_GetChatWidget();
            if (_loc_3 == null)
            {
                return;
            }
            if (this.m_LeftChannel && _loc_3.leftChannel != null && _loc_3.leftChannel.closable)
            {
                _loc_2.leaveChannel(_loc_3.leftChannel);
            }
            else if (!this.m_LeftChannel && _loc_3.rightChannel != null)
            {
                _loc_3.rightChannel = null;
            }
            return;
        }// end function

    }
}
