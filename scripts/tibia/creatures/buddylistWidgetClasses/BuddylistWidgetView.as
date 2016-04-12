package tibia.creatures.buddylistWidgetClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.creatures.*;
    import tibia.creatures.buddylistClasses.*;
    import tibia.input.gameaction.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class BuddylistWidgetView extends WidgetView
    {
        private var m_UncommittedShowOffline:Boolean = false;
        private var m_SortOrder:int = 0;
        private var m_UIList:SmoothList = null;
        private var m_UncommittedBuddySet:Boolean = false;
        private var m_BuddySet:BuddySet = null;
        private var m_ShowOffline:Boolean = true;
        private var m_BuddiesView:IList = null;
        private var m_UncommittedSortOrder:Boolean = false;
        private static const BUNDLE:String = "BuddylistWidget";
        private static const s_StatusSortOrder:Dictionary = new Dictionary();

        public function BuddylistWidgetView()
        {
            titleText = resourceManager.getString(BUNDLE, "TITLE");
            verticalScrollPolicy = ScrollPolicy.OFF;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            maxHeight = int.MAX_VALUE;
            addEventListener(MouseEvent.RIGHT_CLICK, this.onBuddiesClick);
            addEventListener(MouseEvent.DOUBLE_CLICK, this.onBuddiesClick);
            return;
        }// end function

        public function releaseInstance() : void
        {
            super.releaseInstance();
            removeEventListener(MouseEvent.DOUBLE_CLICK, this.onBuddiesClick);
            removeEventListener(MouseEvent.RIGHT_CLICK, this.onBuddiesClick);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedBuddySet)
            {
                if (this.buddySet != null)
                {
                    this.m_BuddiesView = new ListCollectionView(this.buddySet.buddies);
                    if (this.m_BuddiesView is ICollectionView)
                    {
                        ICollectionView(this.m_BuddiesView).filterFunction = this.buddyFilter;
                        _loc_1 = new Sort();
                        _loc_1.compareFunction = this.buddyComparator;
                        ICollectionView(this.m_BuddiesView).sort = _loc_1;
                    }
                }
                else
                {
                    this.m_BuddiesView = null;
                }
                this.m_UIList.dataProvider = this.m_BuddiesView;
                this.m_UncommittedBuddySet = false;
            }
            if (this.m_UncommittedShowOffline || this.m_UncommittedSortOrder)
            {
                if (this.m_BuddiesView is ICollectionView)
                {
                    ICollectionView(this.m_BuddiesView).refresh();
                }
                this.m_UncommittedShowOffline = false;
                this.m_UncommittedSortOrder = false;
            }
            return;
        }// end function

        function get buddySet() : BuddySet
        {
            return this.m_BuddySet;
        }// end function

        function set showOffline(param1:Boolean) : void
        {
            if (this.m_ShowOffline != param1)
            {
                this.m_ShowOffline = param1;
                this.m_UncommittedShowOffline = true;
                invalidateProperties();
            }
            return;
        }// end function

        function get sortOrder() : int
        {
            return this.m_SortOrder;
        }// end function

        private function onBuddiesClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.buddySet != null)
            {
                _loc_2 = null;
                _loc_3 = this.m_UIList.mouseEventToItemRenderer(event);
                if (_loc_3 != null)
                {
                    _loc_2 = _loc_3.data as Buddy;
                }
                if (event.type == MouseEvent.DOUBLE_CLICK)
                {
                    if (_loc_2 != null)
                    {
                        new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL, PrivateChatActionImpl.CHAT_CHANNEL_NO_CHANNEL, _loc_2.name).perform();
                    }
                }
                else if (event.type == MouseEvent.RIGHT_CLICK)
                {
                    new BuddylistItemContextMenu(this.buddySet, _loc_2).display(this, stage.mouseX, stage.mouseY);
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIList = new SmoothList(BuddylistItemRenderer, BuddylistItemRenderer.HEIGHT_HINT);
            this.m_UIList.name = "Buddylist";
            this.m_UIList.defaultItemCount = 3;
            this.m_UIList.doubleClickEnabled = true;
            this.m_UIList.followTailPolicy = SmoothList.FOLLOW_TAIL_OFF;
            this.m_UIList.minItemCount = 3;
            this.m_UIList.percentWidth = 100;
            this.m_UIList.percentHeight = 100;
            this.m_UIList.selectable = false;
            this.m_UIList.styleName = getStyle("listStyle");
            var _loc_1:* = new HBox();
            _loc_1.percentHeight = 100;
            _loc_1.percentWidth = 100;
            _loc_1.styleName = getStyle("listBoxStyle");
            _loc_1.addChild(this.m_UIList);
            addChild(_loc_1);
            return;
        }// end function

        function set sortOrder(param1:int) : void
        {
            if (this.m_SortOrder != param1)
            {
                this.m_SortOrder = param1;
                this.m_UncommittedSortOrder = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function buddyFilter(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as Buddy;
            return _loc_2 != null && (this.showOffline || _loc_2.status != Buddy.STATUS_OFFLINE);
        }// end function

        function get showOffline() : Boolean
        {
            return this.m_ShowOffline;
        }// end function

        function set buddySet(param1:BuddySet) : void
        {
            if (this.m_BuddySet != param1)
            {
                this.m_BuddySet = param1;
                this.m_UncommittedBuddySet = true;
                this.m_UncommittedShowOffline = true;
                this.m_UncommittedSortOrder = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function buddyComparator(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = param1 as Buddy;
            var _loc_5:* = param2 as Buddy;
            var _loc_6:* = 0;
            if (_loc_4 != null && _loc_5 != null)
            {
                switch(this.sortOrder)
                {
                    case BuddylistWidget.SORT_BY_NAME:
                    {
                        break;
                    }
                    case BuddylistWidget.SORT_BY_ICON:
                    {
                        if (_loc_4.icon < _loc_5.icon)
                        {
                            _loc_6 = -1;
                        }
                        else if (_loc_4.icon > _loc_5.icon)
                        {
                            _loc_6 = 1;
                        }
                        break;
                    }
                    case BuddylistWidget.SORT_BY_STATUS:
                    {
                        if (s_StatusSortOrder[_loc_4.status] < s_StatusSortOrder[_loc_5.status])
                        {
                            _loc_6 = -1;
                        }
                        else if (s_StatusSortOrder[_loc_4.status] > s_StatusSortOrder[_loc_5.status])
                        {
                            _loc_6 = 1;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_6 == 0)
                {
                    _loc_7 = _loc_4.name;
                    if (_loc_7 != null)
                    {
                        _loc_7 = _loc_7.toLowerCase();
                    }
                    _loc_8 = _loc_5.name;
                    if (_loc_8 != null)
                    {
                        _loc_8 = _loc_8.toLowerCase();
                    }
                    if (_loc_7 < _loc_8)
                    {
                        _loc_6 = -1;
                    }
                    else if (_loc_7 > _loc_8)
                    {
                        _loc_6 = 1;
                    }
                }
            }
            return _loc_6;
        }// end function

        s_StatusSortOrder[Buddy.STATUS_ONLINE] = 1;
        s_StatusSortOrder[Buddy.STATUS_PENDING] = 2;
        s_StatusSortOrder[Buddy.STATUS_OFFLINE] = 3;
    }
}
