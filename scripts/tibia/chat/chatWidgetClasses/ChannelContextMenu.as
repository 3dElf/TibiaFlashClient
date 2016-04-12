package tibia.chat.chatWidgetClasses
{
    import flash.system.*;
    import mx.core.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.input.gameaction.*;
    import tibia.network.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;
    import tibia.worldmap.*;

    public class ChannelContextMenu extends ContextMenuBase
    {
        protected var m_Channel:Channel = null;
        protected var m_Message:ChannelMessage = null;
        protected var m_View:ChannelView = null;
        protected var m_ChatStorage:ChatStorage = null;
        protected var m_SpeakerName:String = null;
        private static const BUNDLE:String = "ChatWidget";

        public function ChannelContextMenu(param1:ChatStorage, param2:Channel, param3:ChannelMessage, param4:String, param5:ChannelView)
        {
            if (param1 == null)
            {
                throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid chat storage.");
            }
            if (param2 == null)
            {
                throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid chat channel.");
            }
            if (param3 == null && param4 == null)
            {
                throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Message and Name may not be both null.");
            }
            if (param5 == null)
            {
                throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid channel view.");
            }
            this.m_ChatStorage = param1;
            this.m_Channel = param2;
            this.m_Message = param3;
            this.m_SpeakerName = param4;
            this.m_View = param5;
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var Selection:String;
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            if (this.m_SpeakerName != null && this.m_SpeakerName != Tibia.s_GetPlayer().name && (this.m_Message == null || this.m_Message.speakerLevel > 0))
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_PRIVATE_MESSAGE", [this.m_SpeakerName]), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL, PrivateChatActionImpl.CHAT_CHANNEL_NO_CHANNEL, m_SpeakerName).perform();
                return;
            }// end function
            );
                if (this.m_ChatStorage.hasOwnPrivateChannel && this.m_Channel.ID != this.m_ChatStorage.ownPrivateChannelID)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_PRIVATE_INVITE"), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE, m_ChatStorage.ownPrivateChannelID, m_SpeakerName).perform();
                return;
            }// end function
            );
                }
                else if (this.m_ChatStorage.hasOwnPrivateChannel && this.m_Channel.ID == this.m_ChatStorage.ownPrivateChannelID)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_PRIVATE_EXCLUDE"), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_EXCLUDE, m_ChatStorage.ownPrivateChannelID, m_SpeakerName).perform();
                return;
            }// end function
            );
                }
                if (!BuddylistActionImpl.s_IsBuddy(this.m_SpeakerName))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_ADD_BUDDY"), function (param1) : void
            {
                new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME, m_SpeakerName).perform();
                return;
            }// end function
            );
                }
                if (NameFilterActionImpl.s_IsBlacklisted(this.m_SpeakerName))
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_PLAYER_UNIGNORE", [this.m_SpeakerName]), function (param1) : void
            {
                new NameFilterActionImpl(NameFilterActionImpl.UNIGNORE, m_SpeakerName).perform();
                return;
            }// end function
            );
                }
                else
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_PLAYER_IGNORE", [this.m_SpeakerName]), function (param1) : void
            {
                new NameFilterActionImpl(NameFilterActionImpl.IGNORE, m_SpeakerName).perform();
                return;
            }// end function
            );
                }
                createSeparatorItem();
            }
            if (this.m_Message != null)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_SELECT_ALL"), function (param1) : void
            {
                m_View.selectAll();
                return;
            }// end function
            );
                Selection = this.m_View.getSelectedText();
                if (Selection != null && Selection.length > 0)
                {
                    createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_COPY_SELECTED_TEXT"), function (param1) : void
            {
                System.setClipboard(m_View.getSelectedText());
                return;
            }// end function
            );
                }
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_COPY_MESSAGE"), function (param1) : void
            {
                System.setClipboard(m_Message.plainText);
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Message != null && this.m_Message.isReportTypeAllowed(Type.REPORT_STATEMENT))
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_REPORT_STATEMENT"), function (param1) : void
            {
                new ReportWidget(Type.REPORT_STATEMENT, m_Message).show();
                return;
            }// end function
            );
            }
            if (this.m_Message != null && this.m_Message.isReportTypeAllowed(Type.REPORT_NAME))
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_REPORT_NAME"), function (param1) : void
            {
                new ReportWidget(Type.REPORT_NAME, m_Message).show();
                return;
            }// end function
            );
            }
            if (this.m_Message != null && Tibia.s_GetCommunication().allowBugreports && this.m_Message.speakerLevel == 0 && (this.m_Channel.ID == ChatStorage.NPC_CHANNEL_ID || this.m_Channel.ID == ChatStorage.SERVER_CHANNEL_ID))
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_REPORT_TYPO"), function (param1) : void
            {
                var _loc_2:* = new BugReportTypo();
                _loc_2.Speaker = m_Message.speaker;
                _loc_2.Text = m_Message.reportableText;
                new SendBugReportActionImpl(null, _loc_2, null, BugReportWidget.BUG_CATEGORY_TYPO).perform();
                return;
            }// end function
            );
            }
            createSeparatorItem();
            if (this.m_Channel.ID === ChatStorage.HELP_CHANNEL_ID && this.m_Message != null && this.m_Message.ID > 0)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_THANK_YOU"), function (param1) : void
            {
                var _loc_2:* = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCTHANKYOU(m_Message.ID);
                }
                var _loc_3:* = resourceManager.getString(BUNDLE, "CTX_VIEW_THANK_YOU_FEEDBACK");
                var _loc_4:* = Tibia.s_GetWorldMapStorage();
                if (Tibia.s_GetWorldMapStorage() != null)
                {
                    _loc_4.addOnscreenMessage(null, -1, null, 0, MessageMode.MESSAGE_THANKYOU, _loc_3);
                }
                if (m_ChatStorage != null)
                {
                    m_ChatStorage.addChannelMessage(-1, -1, null, 0, MessageMode.MESSAGE_THANKYOU, _loc_3);
                }
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_SpeakerName != null)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_VIEW_COPY_NAME"), function (param1) : void
            {
                System.setClipboard(m_SpeakerName);
                return;
            }// end function
            );
            }
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

    }
}
