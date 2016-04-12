package tibia.input.staticaction
{
    import tibia.chat.*;

    public class ChatChannelShow extends StaticAction
    {
        private var m_ChannelID:int = -1;

        public function ChatChannelShow(param1:int, param2:String, param3:uint, param4:int)
        {
            super(param1, param2, param3, false);
            if (param4 != ChatStorage.MAIN_ADVERTISING_CHANNEL_ID && param4 != ChatStorage.ROOK_ADVERTISING_CHANNEL_ID && param4 != ChatStorage.HELP_CHANNEL_ID && param4 != ChatStorage.NPC_CHANNEL_ID && param4 != ChatStorage.PRIVATE_CHANNEL_ID && param4 != ChatStorage.SERVER_CHANNEL_ID && param4 != ChatStorage.LOCAL_CHANNEL_ID)
            {
                throw new ArgumentError("ChatChannelShow.ChatChannelShow: Invalid channel ID: " + param4);
            }
            this.m_ChannelID = param4;
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetChatStorage();
            var _loc_3:* = Tibia.s_GetChatWidget();
            if (_loc_2 != null && _loc_3 != null)
            {
                _loc_3.leftChannel = _loc_2.getChannel(this.m_ChannelID);
            }
            return;
        }// end function

    }
}
