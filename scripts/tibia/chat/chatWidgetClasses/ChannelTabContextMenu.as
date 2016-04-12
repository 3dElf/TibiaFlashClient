package tibia.chat.chatWidgetClasses
{
    import mx.core.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.input.gameaction.*;
    import tibia.network.*;

    public class ChannelTabContextMenu extends ContextMenuBase
    {
        protected var m_Channel:Channel = null;
        protected var m_ChatStorage:ChatStorage = null;
        private static const BUNDLE:String = "ChatWidget";

        public function ChannelTabContextMenu(param1:ChatStorage, param2:Channel)
        {
            if (param1 == null)
            {
                throw new ArgumentError("ChannelTabContextMenu.ChannelTabContextMenu: Invalid chat storage.");
            }
            if (param2 == null)
            {
                throw new ArgumentError("ChannelTabContextMenu.ChannelTabContextMenu: Invalid chat channel.");
            }
            this.m_ChatStorage = param1;
            this.m_Channel = param2;
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            if (this.m_Channel.canModerate)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_INVITE"), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE, m_Channel.safeID, null).perform();
                return;
            }// end function
            );
                createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_EXCLUDE"), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_EXCLUDE, m_Channel.safeID, null).perform();
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Channel.canModerate && this.m_Channel.isGuildChannel)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_EDIT_MOTD"), function (param1) : void
            {
                var _loc_2:* = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCGUILDMESSAGE();
                }
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Channel.closable)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_CLOSE"), function (param1) : void
            {
                if (m_Channel != null && m_ChatStorage != null)
                {
                    m_ChatStorage.leaveChannel(m_Channel);
                }
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (Tibia.s_GetChatWidget().rightChannel != this.m_Channel)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_SHOW_RIGHT"), function (param1) : void
            {
                Tibia.s_GetChatWidget().rightChannel = m_Channel;
                return;
            }// end function
            );
                createSeparatorItem();
            }
            createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_SAVE"), function (param1) : void
            {
                if (m_Channel != null && m_ChatStorage != null)
                {
                    new SaveChannelActionImpl(m_ChatStorage, m_Channel).perform();
                }
                return;
            }// end function
            );
            createTextItem(resourceManager.getString(BUNDLE, "CTX_TAB_CLEAR"), function (param1) : void
            {
                if (m_Channel != null)
                {
                    m_Channel.clearMessages();
                }
                return;
            }// end function
            );
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

    }
}
