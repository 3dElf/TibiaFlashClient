package tibia.creatures.buddylistWidgetClasses
{
    import flash.system.*;
    import mx.core.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.creatures.buddylistClasses.*;
    import tibia.game.*;
    import tibia.input.gameaction.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class BuddylistItemContextMenu extends ContextMenuBase
    {
        private var m_Buddy:Buddy = null;
        private var m_BuddySet:BuddySet = null;
        private static const BUNDLE:String = "BuddylistWidget";
        private static const SORT_MODE:Array = [{value:BuddylistWidget.SORT_BY_NAME, label:"CTX_SORT_NAME"}, {value:BuddylistWidget.SORT_BY_ICON, label:"CTX_SORT_ICON"}, {value:BuddylistWidget.SORT_BY_STATUS, label:"CTX_SORT_STATUS"}];

        public function BuddylistItemContextMenu(param1:BuddySet, param2:Buddy)
        {
            this.m_BuddySet = param1;
            if (this.m_BuddySet == null)
            {
                throw new ArgumentError("BuddylistItemContextMenu.BuddylistItemContextMenu: Invalid buddy set.");
            }
            this.m_Buddy = param2;
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var _Widget:BuddylistWidget;
            var i:int;
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            if (this.m_Buddy != null)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_EDIT_BUDDY", [this.m_Buddy.name]), function (param1) : void
            {
                var _loc_2:* = new EditBuddyWidget();
                _loc_2.buddySet = m_BuddySet;
                _loc_2.buddy = m_Buddy;
                _loc_2.show();
                return;
            }// end function
            );
                createTextItem(resourceManager.getString(BUNDLE, "CTX_REMOVE_BUDDY", [this.m_Buddy.name]), function (param1) : void
            {
                new BuddylistActionImpl(BuddylistActionImpl.REMOVE, m_Buddy.ID).perform();
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Buddy != null && this.m_Buddy.status == Buddy.STATUS_ONLINE && this.m_Buddy.ID != Tibia.s_GetPlayer().ID)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_OPEN_MESSAGE_CHANNEL", [this.m_Buddy.name]), function (param1) : void
            {
                new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL, PrivateChatActionImpl.CHAT_CHANNEL_NO_CHANNEL, m_Buddy.name).perform();
                return;
            }// end function
            );
                createSeparatorItem();
            }
            createTextItem(resourceManager.getString(BUNDLE, "CTX_ADD_BUDDY"), function (param1) : void
            {
                new BuddylistActionImpl(BuddylistActionImpl.ADD_ASK_NAME, null).perform();
                return;
            }// end function
            );
            if (a_Owner is BuddylistWidgetView && BuddylistWidgetView(a_Owner).widgetInstance is BuddylistWidget)
            {
                _Widget = BuddylistWidget(BuddylistWidgetView(a_Owner).widgetInstance);
                i;
                while (i < SORT_MODE.length)
                {
                    
                    if (_Widget.sortOrder != SORT_MODE[i].value)
                    {
                        createTextItem(resourceManager.getString(BUNDLE, SORT_MODE[i].label), closure(null, function (param1:BuddylistWidget, param2:int, param3) : void
            {
                param1.sortOrder = param2;
                return;
            }// end function
            , _Widget, SORT_MODE[i].value));
                    }
                    i = (i + 1);
                }
                createTextItem(resourceManager.getString(BUNDLE, _Widget.showOffline ? ("CTX_HIDE_OFFLINE") : ("CTX_SHOW_OFFLINE")), function (param1) : void
            {
                _Widget.showOffline = !_Widget.showOffline;
                return;
            }// end function
            );
            }
            createSeparatorItem();
            if (this.m_Buddy != null && this.m_Buddy.isReportTypeAllowed(Type.REPORT_NAME))
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_REPORT_NAME"), function (param1) : void
            {
                new ReportWidget(Type.REPORT_NAME, m_Buddy).show();
                return;
            }// end function
            );
                createSeparatorItem();
            }
            if (this.m_Buddy != null)
            {
                createTextItem(resourceManager.getString(BUNDLE, "CTX_COPY_NAME"), function (param1) : void
            {
                System.setClipboard(m_Buddy.name);
                return;
            }// end function
            );
                createSeparatorItem();
            }
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

    }
}
