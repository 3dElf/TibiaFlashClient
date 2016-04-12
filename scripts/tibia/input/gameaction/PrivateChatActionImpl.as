package tibia.input.gameaction
{
    import mx.events.*;
    import mx.resources.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.widgetClasses.*;
    import tibia.network.*;

    public class PrivateChatActionImpl extends Object implements IActionImpl
    {
        protected var m_Type:int = -1;
        protected var m_ChannelID:int = -1;
        protected var m_Name:String = null;
        private static const BUNDLE:String = "ChatWidget";
        public static const CHAT_CHANNEL_NO_CHANNEL:int = -1;
        public static const CHAT_CHANNEL_INVITE:int = 1;
        public static const OPEN_CHAT_CHANNEL:int = 0;
        public static const OPEN_MESSAGE_CHANNEL:int = 3;
        public static const CHAT_CHANNEL_EXCLUDE:int = 2;

        public function PrivateChatActionImpl(param1:int, param2:int, param3:String)
        {
            if (param1 != OPEN_CHAT_CHANNEL && param1 != OPEN_MESSAGE_CHANNEL && param1 != CHAT_CHANNEL_INVITE && param1 != CHAT_CHANNEL_EXCLUDE)
            {
                throw new ArgumentError("ChatActionImpl.ChatActionImpl: Invalid type: " + param1 + ".");
            }
            this.m_Type = param1;
            this.m_ChannelID = param2;
            this.m_Name = param3;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_Type == OPEN_CHAT_CHANNEL || this.m_Name != null)
            {
                this.performInternal(this.m_Type, this.m_Name);
            }
            else
            {
                _loc_2 = null;
                switch(this.m_Type)
                {
                    case CHAT_CHANNEL_INVITE:
                    {
                        _loc_2 = "ACTION_INVITE";
                        break;
                    }
                    case CHAT_CHANNEL_EXCLUDE:
                    {
                        _loc_2 = "ACTION_EXCLUDE";
                        break;
                    }
                    case OPEN_MESSAGE_CHANNEL:
                    {
                        _loc_2 = "ACTION_MESSAGE";
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                _loc_3 = ResourceManager.getInstance();
                _loc_4 = new AskPlayerNameWidget();
                _loc_4.prompt = _loc_3.getString(BUNDLE, _loc_2 + "_PROMPT");
                _loc_4.title = _loc_3.getString(BUNDLE, _loc_2 + "_TITLE");
                _loc_4.addEventListener(CloseEvent.CLOSE, this.onWidgetClose);
                _loc_4.show();
            }
            return;
        }// end function

        private function onWidgetClose(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as AskPlayerNameWidget;
            _loc_2 = event.currentTarget as AskPlayerNameWidget;
            if (event != null && event.detail == PopUpBase.BUTTON_OKAY && _loc_3 != null && _loc_2.playerName != null && _loc_2.playerName.length > 0)
            {
                this.performInternal(this.m_Type, _loc_2.playerName);
            }
            return;
        }// end function

        private function performInternal(param1:int, param2:String) : void
        {
            var _loc_6:* = null;
            var _loc_3:* = Tibia.s_GetChatStorage();
            var _loc_4:* = Tibia.s_GetChatWidget();
            var _loc_5:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_4 != null && _loc_5 != null && _loc_5.isGameRunning)
            {
                _loc_6 = null;
                switch(param1)
                {
                    case OPEN_CHAT_CHANNEL:
                    {
                        _loc_6 = _loc_3.getChannel(_loc_3.ownPrivateChannelID);
                        if (_loc_6 == null)
                        {
                            _loc_5.sendCOPENCHANNEL();
                        }
                        else
                        {
                            _loc_4.leftChannel = _loc_6;
                        }
                        break;
                    }
                    case OPEN_MESSAGE_CHANNEL:
                    {
                        _loc_6 = _loc_3.getChannel(param2);
                        if (_loc_6 == null)
                        {
                            _loc_5.sendCPRIVATECHANNEL(param2);
                        }
                        else
                        {
                            _loc_4.leftChannel = _loc_6;
                        }
                        break;
                    }
                    case CHAT_CHANNEL_INVITE:
                    {
                        if (this.m_ChannelID > -1)
                        {
                            _loc_5.sendCINVITETOCHANNEL(param2, this.m_ChannelID);
                        }
                        break;
                    }
                    case CHAT_CHANNEL_EXCLUDE:
                    {
                        if (this.m_ChannelID > -1)
                        {
                            _loc_5.sendCEXCLUDEFROMCHANNEL(param2, this.m_ChannelID);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
