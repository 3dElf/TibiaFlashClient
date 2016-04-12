package tibia.input.gameaction
{
    import tibia.chat.*;
    import tibia.input.*;
    import tibia.network.*;

    public class TalkActionImpl extends Object implements IActionImpl
    {
        protected var m_AutoSend:Boolean = false;
        private var m_ChannelID:int = -1;
        protected var m_Text:String = null;
        static const CURRENT_CHANNEL_ID:int = -1;

        public function TalkActionImpl(param1:String, param2:Boolean, param3:int = -1)
        {
            var _loc_4:* = null;
            if (param1 != null)
            {
                this.m_Text = param1.replace("/^s+/", "").replace("/s+$/", " ");
            }
            else
            {
                _loc_4 = Tibia.s_GetChatWidget();
                if (_loc_4 != null)
                {
                    this.m_Text = _loc_4.text;
                }
            }
            this.m_AutoSend = param2;
            this.m_ChannelID = param3;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = Tibia.s_GetChatWidget();
            var _loc_3:* = Tibia.s_GetChatStorage();
            var _loc_4:* = Tibia.s_GetCommunication();
            if (_loc_2 == null || _loc_3 == null || _loc_4 == null || this.m_Text == null)
            {
                return;
            }
            if (this.m_ChannelID != CURRENT_CHANNEL_ID)
            {
                _loc_2.leftChannel = _loc_3.getChannel(this.m_ChannelID);
            }
            _loc_2.text = this.m_Text;
            if (this.m_AutoSend)
            {
                var _loc_5:* = _loc_2;
                _loc_5.ns_chat_internal::onChatSend();
            }
            return;
        }// end function

    }
}
