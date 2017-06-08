package tibia.input.gameaction
{
    import mx.events.*;
    import mx.resources.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.network.*;
    import tibia.worldmap.*;

    public class SendBugReportActionImpl extends Object implements IActionImpl
    {
        protected var m_BugCategory:int = 3;
        protected var m_SystemMessage:Object = null;
        protected var m_UserMessage:String = null;
        protected var m_Callback:Function = null;
        private static const BUNDLE:String = "BugReportWidget";

        public function SendBugReportActionImpl(param1:String = null, param2 = null, param3:Function = null, param4:int = -1)
        {
            this.m_UserMessage = param1;
            this.m_SystemMessage = param2;
            this.m_Callback = param3;
            if (param4 > -1)
            {
                this.m_BugCategory = param4;
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_2 != null && _loc_2.allowBugreports && _loc_2.isGameRunning)
            {
                _loc_3 = new BugReportWidget();
                _loc_3.userMessage = this.m_UserMessage;
                _loc_3.bugInformation = this.m_SystemMessage;
                _loc_3.category = this.m_BugCategory;
                if (this.m_Callback != null)
                {
                    _loc_3.addEventListener(CloseEvent.CLOSE, this.m_Callback);
                }
                _loc_3.show();
            }
            else
            {
                _loc_4 = null;
                if (_loc_2 != null && !_loc_2.allowBugreports && _loc_2.isGameRunning)
                {
                    _loc_4 = ResourceManager.getInstance().getString(BUNDLE, "MSG_NOT_AUHTORIZED");
                }
                else
                {
                    _loc_4 = ResourceManager.getInstance().getString(BUNDLE, "MSG_NOT_CONNECTED");
                }
                _loc_5 = Tibia.s_GetWorldMapStorage();
                if (_loc_5 != null)
                {
                    _loc_5.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, _loc_4);
                }
                _loc_6 = Tibia.s_GetChatStorage();
                if (_loc_6 != null)
                {
                    _loc_6.addChannelMessage(-1, -1, null, 0, MessageMode.MESSAGE_FAILURE, _loc_4);
                }
            }
            return;
        }// end function

    }
}
