package tibia.chat.chatWidgetClasses
{
    import flash.events.*;
    import flash.geom.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.effects.*;
    import shared.controls.*;
    import tibia.chat.*;

    public class ChannelMessageList extends SmoothList
    {
        private var m_UnreadEffect:Effect = null;
        protected var m_SelectedTextEnd:Point = null;
        protected var m_StopScrollingOnLargeBlocks:Boolean = false;
        private var m_UncommittedDataProvider:Boolean = false;
        protected var m_SelectedTextBegin:Point = null;
        protected var m_TextSelectionMode:Boolean = false;
        protected var m_LastMarkerLineCount:int = 0;

        public function ChannelMessageList()
        {
            super(ChannelMessageRenderer, ChannelMessageRenderer.HEIGHT_HINT);
            selectable = false;
            this.m_TextSelectionMode = false;
            this.m_SelectedTextBegin = new Point();
            this.m_SelectedTextEnd = new Point();
            return;
        }// end function

        override protected function onMouseUp(event:Event) : void
        {
            super.onMouseUp(event);
            if (this.m_TextSelectionMode)
            {
                this.leaveTextSelectionMode(stage.mouseX, stage.mouseY);
            }
            return;
        }// end function

        override protected function onDragScrollTimer(event:TimerEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            super.onDragScrollTimer(event);
            if (this.m_TextSelectionMode)
            {
                _loc_2 = mouseX;
                _loc_3 = Math.max(0, Math.min(mouseY, unscaledHeight));
                _loc_4 = localToGlobal(new Point(_loc_2, _loc_3));
                this.setSelectedTextPoint(_loc_4.x, _loc_4.y, this.m_SelectedTextEnd);
                this.updateSelectedText();
            }
            return;
        }// end function

        protected function setSelectedTextPoint(param1:Number, param2:Number, param3:Point) : void
        {
            var _loc_6:* = null;
            if (param1 < 0 || param2 < 0)
            {
                param3.x = -1;
                param3.y = -1;
                return;
            }
            var _loc_4:* = pointToItemIndex(param1, param2);
            var _loc_5:* = itemIndexToItemRenderer(_loc_4) as ISelectionProxy;
            if (itemIndexToItemRenderer(_loc_4) as ISelectionProxy != null && _loc_5 is IUIComponent)
            {
                _loc_6 = (_loc_5 as IUIComponent).globalToLocal(new Point(param1, param2));
                param3.x = _loc_4;
                param3.y = _loc_5.getCharIndexAtPoint(_loc_6.x, _loc_6.y);
            }
            return;
        }// end function

        override protected function onMouseDown(event:MouseEvent) : void
        {
            super.onMouseDown(event);
            var _loc_2:* = mouseEventToItemRenderer(event);
            if (_loc_2 != null)
            {
                this.m_TextSelectionMode = true;
                this.setSelectedTextPoint(event.stageX, event.stageY, this.m_SelectedTextBegin);
                this.setSelectedTextPoint(-1, -1, this.m_SelectedTextEnd);
                this.updateSelectedText();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedDataProvider)
            {
                this.m_TextSelectionMode = false;
                this.setSelectedTextRange(-1, -1, -1, -1);
                this.updateSelectedText();
                this.m_UncommittedDataProvider = false;
            }
            return;
        }// end function

        protected function updateSelectedText() : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_1:* = -1;
            var _loc_2:* = -1;
            var _loc_3:* = -1;
            var _loc_4:* = -1;
            if (this.m_SelectedTextBegin.x <= this.m_SelectedTextEnd.x)
            {
                _loc_1 = this.m_SelectedTextBegin.x;
                _loc_2 = this.m_SelectedTextBegin.y;
                _loc_3 = this.m_SelectedTextEnd.x;
                _loc_4 = this.m_SelectedTextEnd.y;
                if (_loc_1 == _loc_3)
                {
                    _loc_2 = Math.min(this.m_SelectedTextBegin.y, this.m_SelectedTextEnd.y);
                    _loc_4 = Math.max(this.m_SelectedTextBegin.y, this.m_SelectedTextEnd.y);
                }
            }
            else
            {
                _loc_1 = this.m_SelectedTextEnd.x;
                _loc_2 = this.m_SelectedTextEnd.y;
                _loc_3 = this.m_SelectedTextBegin.x;
                _loc_4 = this.m_SelectedTextBegin.y;
            }
            if (_loc_1 < 0 || _loc_3 < 0)
            {
                _loc_1 = -1;
                _loc_3 = -1;
            }
            var _loc_5:* = 0;
            while (_loc_5 < m_RendererMap.length)
            {
                
                _loc_6 = _loc_5 + m_FirstVisibleItem;
                _loc_7 = m_RendererMap[_loc_5] as ISelectionProxy;
                if (_loc_7 == null)
                {
                }
                else if (_loc_1 < _loc_3 && _loc_6 == _loc_1)
                {
                    _loc_7.setSelection(_loc_2, (_loc_7.getCharCount() + 1));
                }
                else if (_loc_1 < _loc_3 && _loc_6 == _loc_3)
                {
                    _loc_7.setSelection(0, _loc_4);
                }
                else if (_loc_1 < _loc_6 && _loc_6 < _loc_3)
                {
                    _loc_7.selectAll();
                }
                else if (_loc_1 == _loc_3 && _loc_6 == _loc_1)
                {
                    _loc_7.setSelection(_loc_2, _loc_4);
                }
                else
                {
                    _loc_7.clearSelection();
                }
                _loc_5++;
            }
            return;
        }// end function

        public function clearSelectedText() : void
        {
            this.setSelectedTextRange(-1, -1, -1, -1);
            this.updateSelectedText();
            return;
        }// end function

        public function selectAllText() : void
        {
            this.setSelectedTextRange(-1, -1, -1, -1);
            var _loc_1:* = dataProvider != null ? (dataProvider.length) : (0);
            var _loc_2:* = createItemRenderer();
            if (_loc_1 > 0 && _loc_2 is ISelectionProxy)
            {
                _loc_2.data = dataProvider.getItemAt((_loc_1 - 1));
                this.setSelectedTextRange(0, 0, (_loc_1 - 1), ((_loc_2 as ISelectionProxy).getCharCount() + 1));
            }
            this.updateSelectedText();
            return;
        }// end function

        public function get stopsScrollingOnLargeBlocks() : Boolean
        {
            return this.m_StopScrollingOnLargeBlocks;
        }// end function

        private function startIndicatorForUnreadText() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_UnreadEffect == null)
            {
                _loc_1 = new Glow();
                _loc_2 = new Glow();
                _loc_1.alphaFrom = 0;
                _loc_1.alphaTo = 0.3;
                _loc_2.alphaFrom = _loc_1.alphaTo;
                _loc_2.alphaTo = _loc_1.alphaFrom;
                var _loc_5:* = 15597568;
                _loc_2.color = 15597568;
                _loc_1.color = _loc_5;
                var _loc_5:* = 100;
                _loc_2.blurXFrom = 100;
                _loc_1.blurXFrom = _loc_5;
                var _loc_5:* = 100;
                _loc_2.blurXTo = 100;
                _loc_1.blurXTo = _loc_5;
                var _loc_5:* = _loc_1.blurXFrom;
                _loc_2.blurYFrom = _loc_1.blurXFrom;
                _loc_1.blurYFrom = _loc_5;
                var _loc_5:* = _loc_1.blurXTo;
                _loc_2.blurYTo = _loc_1.blurXTo;
                _loc_1.blurYTo = _loc_5;
                var _loc_5:* = 4;
                _loc_2.strength = 4;
                _loc_1.strength = _loc_5;
                var _loc_5:* = 2000;
                _loc_2.duration = 2000;
                _loc_1.duration = _loc_5;
                var _loc_5:* = true;
                _loc_2.inner = true;
                _loc_1.inner = _loc_5;
                _loc_3 = new Sequence();
                _loc_3.repeatCount = 0;
                _loc_3.addChild(_loc_1);
                _loc_3.addChild(_loc_2);
                this.m_UnreadEffect = _loc_3;
            }
            if (verticalScrollBar != null)
            {
                _loc_4 = verticalScrollBar.getChildAt((verticalScrollBar.numChildren - 1)) as Button;
                if (_loc_4 != null)
                {
                    this.m_UnreadEffect.end();
                    this.m_UnreadEffect.play([_loc_4]);
                }
            }
            if (Tibia.s_GetChatWidget() != null && Tibia.s_GetChatWidget().tabBar != null && Tibia.s_GetChatWidget().tabBar.selectedTab != null)
            {
                Tibia.s_GetChatWidget().tabBar.selectedTab.forceHighlight();
            }
            return;
        }// end function

        public function getSelectedText() : String
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_1:* = -1;
            var _loc_2:* = -1;
            var _loc_3:* = -1;
            var _loc_4:* = -1;
            if (this.m_SelectedTextBegin.x <= this.m_SelectedTextEnd.x)
            {
                _loc_1 = this.m_SelectedTextBegin.x;
                _loc_2 = this.m_SelectedTextBegin.y;
                _loc_3 = this.m_SelectedTextEnd.x;
                _loc_4 = this.m_SelectedTextEnd.y;
                if (_loc_1 == _loc_3)
                {
                    _loc_2 = Math.min(this.m_SelectedTextBegin.y, this.m_SelectedTextEnd.y);
                    _loc_4 = Math.max(this.m_SelectedTextBegin.y, this.m_SelectedTextEnd.y);
                }
            }
            else
            {
                _loc_1 = this.m_SelectedTextEnd.x;
                _loc_2 = this.m_SelectedTextEnd.y;
                _loc_3 = this.m_SelectedTextBegin.x;
                _loc_4 = this.m_SelectedTextBegin.y;
            }
            var _loc_5:* = createItemRenderer();
            if (!(createItemRenderer() is ISelectionProxy))
            {
                return null;
            }
            if (_loc_1 < 0 || _loc_3 < 0 || _loc_5 == null)
            {
                return "";
            }
            if (_loc_1 == _loc_3)
            {
                _loc_5.data = dataProvider.getItemAt(_loc_1);
                return (_loc_5 as ISelectionProxy).getLabel().substring(_loc_2, _loc_4);
            }
            _loc_5.data = dataProvider.getItemAt(_loc_1);
            _loc_6 = (_loc_5 as ISelectionProxy).getLabel();
            _loc_7 = _loc_6 != null ? (_loc_6.substr(_loc_2) + "\n") : ("");
            _loc_8 = _loc_1 + 1;
            while (_loc_8 < _loc_3)
            {
                
                _loc_5.data = dataProvider.getItemAt(_loc_8);
                _loc_6 = (_loc_5 as ISelectionProxy).getLabel();
                if (_loc_6 != null)
                {
                    _loc_7 = _loc_7 + (_loc_6 + "\n");
                }
                _loc_8++;
            }
            _loc_5.data = dataProvider.getItemAt(_loc_8);
            _loc_6 = (_loc_5 as ISelectionProxy).getLabel();
            _loc_7 = _loc_7 + (_loc_6 != null ? (_loc_6.substring(0, _loc_4)) : (""));
            return _loc_7;
        }// end function

        protected function leaveTextSelectionMode(param1:Number, param2:Number) : void
        {
            if (this.m_TextSelectionMode)
            {
                this.m_TextSelectionMode = false;
                this.setSelectedTextPoint(param1, param2, this.m_SelectedTextEnd);
                if (this.m_SelectedTextBegin.x == this.m_SelectedTextEnd.x && this.m_SelectedTextBegin.y == this.m_SelectedTextEnd.y)
                {
                    var _loc_3:* = -1;
                    this.m_SelectedTextBegin.y = -1;
                    this.m_SelectedTextBegin.x = _loc_3;
                    var _loc_3:* = -1;
                    this.m_SelectedTextEnd.y = -1;
                    this.m_SelectedTextEnd.x = _loc_3;
                }
                this.updateSelectedText();
            }
            return;
        }// end function

        override public function set dataProvider(param1:IList) : void
        {
            if (super.dataProvider != param1)
            {
                super.dataProvider = param1;
                if (param1 != null)
                {
                    this.m_LastMarkerLineCount = param1.length;
                }
                this.stopIndicatorForUnreadText();
                this.m_UncommittedDataProvider = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function onMouseMove(event:MouseEvent) : void
        {
            super.onMouseMove(event);
            if (this.m_TextSelectionMode)
            {
                this.setSelectedTextPoint(event.stageX, event.stageY, this.m_SelectedTextEnd);
                this.updateSelectedText();
            }
            return;
        }// end function

        private function stopIndicatorForUnreadText() : void
        {
            if (this.m_UnreadEffect != null && this.m_UnreadEffect.isPlaying)
            {
                this.m_UnreadEffect.end();
            }
            if (Tibia.s_GetChatWidget() != null && Tibia.s_GetChatWidget().tabBar != null && Tibia.s_GetChatWidget().tabBar.selectedTab != null)
            {
                Tibia.s_GetChatWidget().tabBar.selectedTab.highlight = false;
            }
            return;
        }// end function

        protected function setSelectedTextRange(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.m_SelectedTextBegin.x = param1;
            this.m_SelectedTextBegin.y = param2;
            this.m_SelectedTextEnd.x = param3;
            this.m_SelectedTextEnd.y = param4;
            return;
        }// end function

        public function set stopsScrollingOnLargeBlocks(param1:Boolean) : void
        {
            this.m_StopScrollingOnLargeBlocks = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = m_DataProvider != null ? (m_DataProvider.length) : (0);
            if (!m_FollowTail)
            {
                this.m_LastMarkerLineCount = _loc_3;
            }
            else if (_loc_3 > 0 && this.m_StopScrollingOnLargeBlocks && this.m_LastMarkerLineCount < _loc_3 && m_FollowTail)
            {
                _loc_4 = -1;
                _loc_5 = _loc_3 - 1;
                while (_loc_5 >= 0)
                {
                    
                    _loc_6 = m_DataProvider.getItemAt(_loc_5) as ChannelMessage;
                    if (_loc_6 != null && _loc_6.mode == MessageMode.MESSAGE_NPC_FROM_START_BLOCK)
                    {
                        _loc_4 = _loc_5;
                        break;
                    }
                    else if (_loc_6 != null && _loc_6.mode == MessageMode.MESSAGE_NPC_TO)
                    {
                        break;
                    }
                    _loc_5 = _loc_5 - 1;
                }
                if (_loc_4 > -1)
                {
                    _loc_7 = viewMetricsAndPadding;
                    _loc_8 = param2 - _loc_7.top - _loc_7.bottom;
                    _loc_9 = m_ExtentChache.top(_loc_4);
                    _loc_10 = m_ExtentChache.bottom((_loc_3 - 1)) - _loc_9;
                    if (_loc_10 > _loc_8)
                    {
                        this.m_LastMarkerLineCount = _loc_3;
                        verticalScrollPosition = _loc_9;
                        m_FollowTail = false;
                        super.updateDisplayList(param1, param2);
                        this.startIndicatorForUnreadText();
                        Tibia.s_GetChatWidget().tabBar.selectedTab.forceHighlight();
                    }
                }
            }
            if (m_FollowTail || m_LastVisibleItem == (_loc_3 - 1))
            {
                this.stopIndicatorForUnreadText();
            }
            this.updateSelectedText();
            return;
        }// end function

    }
}
