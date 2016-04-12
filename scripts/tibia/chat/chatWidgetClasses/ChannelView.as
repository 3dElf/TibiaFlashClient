package tibia.chat.chatWidgetClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.listClasses.*;
    import shared.controls.*;
    import tibia.chat.*;

    public class ChannelView extends CustomDividedBox
    {
        protected var m_UINicklist:SmoothList = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_Channel:Channel = null;
        private var m_UncommittedChannel:Boolean = false;
        protected var m_UIChannel:ChannelMessageList = null;
        protected var m_UINicklistItemView:IList = null;
        private static const s_StateSortOrder:Dictionary = new Dictionary();

        public function ChannelView()
        {
            direction = BoxDirection.HORIZONTAL;
            return;
        }// end function

        public function get channel() : Channel
        {
            return this.m_Channel;
        }// end function

        public function selectAll() : void
        {
            if (this.m_UIChannel != null)
            {
                this.m_UIChannel.selectAllText();
            }
            return;
        }// end function

        public function set channel(param1:Channel) : void
        {
            if (this.m_Channel != param1)
            {
                this.m_Channel = param1;
                this.m_UncommittedChannel = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            if (this.m_UncommittedChannel)
            {
                _loc_1 = false;
                if (this.m_Channel != null)
                {
                    this.m_UINicklistItemView = new ListCollectionView(this.m_Channel.nicklistItems);
                    this.m_UIChannel.stopsScrollingOnLargeBlocks = this.m_Channel.ID == ChatStorage.NPC_CHANNEL_ID;
                    this.m_UIChannel.dataProvider = this.m_Channel.messages;
                    this.m_UINicklist.dataProvider = this.m_UINicklistItemView;
                    if (this.m_UINicklistItemView is ICollectionView)
                    {
                        ICollectionView(this.m_UINicklistItemView).filterFunction = this.nicklistItemFilter;
                        ICollectionView(this.m_UINicklistItemView).refresh();
                        _loc_2 = new Sort();
                        _loc_2.compareFunction = this.nicklistItemComparator;
                        ICollectionView(this.m_UINicklistItemView).sort = _loc_2;
                    }
                    _loc_1 = this.m_Channel.showNicklist;
                }
                else
                {
                    this.m_UIChannel.dataProvider = null;
                    this.m_UINicklist.dataProvider = null;
                    _loc_1 = false;
                }
                if (_loc_1)
                {
                    if (!contains(this.m_UINicklist))
                    {
                        addChild(this.m_UINicklist);
                    }
                }
                else if (contains(this.m_UINicklist))
                {
                    removeChild(this.m_UINicklist);
                }
                this.m_UncommittedChannel = false;
            }
            super.commitProperties();
            return;
        }// end function

        protected function nicklistItemFilter(param1:Object) : Boolean
        {
            var _loc_2:* = param1 as NicklistItem;
            return _loc_2 != null && _loc_2.state != NicklistItem.STATE_UNKNOWN;
        }// end function

        public function getSelectedText() : String
        {
            if (this.m_UIChannel != null)
            {
                return this.m_UIChannel.getSelectedText();
            }
            return null;
        }// end function

        protected function onMessageClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (event != null && this.m_Channel != null)
            {
                _loc_2 = this.m_UIChannel.mouseEventToItemRenderer(event);
                _loc_3 = _loc_2 != null ? (this.m_UIChannel.itemRendererToIndex(_loc_2)) : (0);
                _loc_4 = this.m_Channel.messages;
                _loc_3 = Math.min(Math.max(0, _loc_3), (_loc_4.length - 1));
                if (_loc_3 > -1)
                {
                    _loc_5 = ChannelMessage(_loc_4.getItemAt(_loc_3));
                    _loc_6 = new ChannelEvent(ChannelEvent.VIEW_CONTEXT_MENU);
                    _loc_6.channel = this.m_Channel;
                    _loc_6.message = _loc_5;
                    _loc_6.name = _loc_5.speaker;
                    dispatchEvent(_loc_6);
                }
            }
            return;
        }// end function

        protected function onNicklistItemClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (event != null && this.m_Channel != null && this.m_Channel.showNicklist)
            {
                _loc_2 = this.m_UINicklist.mouseEventToItemRenderer(event);
                _loc_3 = _loc_2 != null ? (_loc_2.data as NicklistItem) : (null);
                if (_loc_3 != null)
                {
                    _loc_4 = new ChannelEvent(ChannelEvent.NICKLIST_CONTEXT_MENU);
                    _loc_4.channel = this.m_Channel;
                    _loc_4.message = null;
                    _loc_4.name = _loc_3.name;
                    dispatchEvent(_loc_4);
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            minHeight = this.m_UIChannel.minHeight + viewMetricsAndPadding.top + viewMetricsAndPadding.bottom;
            return;
        }// end function

        public function clearSelection() : void
        {
            if (this.m_UIChannel != null)
            {
                this.m_UIChannel.clearSelectedText();
            }
            return;
        }// end function

        protected function nicklistItemComparator(param1:Object, param2:Object, param3:Array = null) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = param1 as NicklistItem;
            var _loc_5:* = param2 as NicklistItem;
            var _loc_6:* = 0;
            if (_loc_4 != null && _loc_5 != null)
            {
                if (s_StateSortOrder[_loc_4.state] < s_StateSortOrder[_loc_5.state])
                {
                    _loc_6 = -1;
                }
                else if (s_StateSortOrder[_loc_4.state] > s_StateSortOrder[_loc_5.state])
                {
                    _loc_6 = 1;
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
            return _loc_6;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIChannel = new ChannelMessageList();
                this.m_UIChannel.name = "ChannelMessageList";
                this.m_UIChannel.dataProvider = null;
                this.m_UIChannel.followTailPolicy = SmoothList.FOLLOW_TAIL_AUTO;
                this.m_UIChannel.minItemCount = 3;
                this.m_UIChannel.percentHeight = 100;
                this.m_UIChannel.percentWidth = 100;
                this.m_UIChannel.styleName = getStyle("messagesStyle");
                this.m_UIChannel.addEventListener(MouseEvent.RIGHT_CLICK, this.onMessageClick);
                addChild(this.m_UIChannel);
                this.m_UINicklist = new SmoothList(NicklistItemRenderer, NicklistItemRenderer.HEIGHT_HINT);
                this.m_UINicklist.name = "ChannelNicklist";
                this.m_UINicklist.dataProvider = null;
                this.m_UINicklist.followTailPolicy = SmoothList.FOLLOW_TAIL_OFF;
                this.m_UINicklist.maxWidth = 128;
                this.m_UINicklist.minWidth = 64;
                this.m_UINicklist.percentHeight = 100;
                this.m_UINicklist.percentWidth = 100;
                this.m_UINicklist.selectable = false;
                this.m_UINicklist.styleName = getStyle("nicklistStyle");
                this.m_UINicklist.addEventListener(MouseEvent.RIGHT_CLICK, this.onNicklistItemClick);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        s_StateSortOrder[NicklistItem.STATE_SUBSCRIBER] = 1;
        s_StateSortOrder[NicklistItem.STATE_INVITED] = 2;
        s_StateSortOrder[NicklistItem.STATE_PENDING] = 3;
    }
}
