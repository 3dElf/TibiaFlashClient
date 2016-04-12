package shared.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import shared.utility.*;

    public class SmoothList extends ScrollControlBase
    {
        protected var m_ExtentChache:ExtentCache = null;
        protected var m_SelectedIndex:int = -1;
        protected var m_Selectable:Boolean = true;
        protected var m_FirstVisibleItem:int = -1;
        private var m_MouseCursorOverList:Boolean = false;
        protected var m_AlignBottom:Boolean = false;
        protected var m_ForceUpdate:Boolean = false;
        protected var m_UIContentLayer:UIComponent = null;
        protected var m_RendererMap:Array = null;
        protected var m_ResizeFollowTailHeight:Number = NaN;
        private var m_UIConstructed:Boolean = false;
        protected var m_DragScrollTimer:Timer = null;
        protected var m_ItemDefaultCount:int = 1;
        protected var m_LastVisibleItem:int = -1;
        protected var m_ItemRendererFactory:ClassFactory = null;
        protected var m_ItemMinCount:int = 1;
        protected var m_FollowTail:Boolean = false;
        private var m_UncommittedRollOverItem:Boolean = true;
        protected var m_RollOverItem:int = -1;
        protected var m_FollowTailPolicy:String = "off";
        protected var m_UISelectionLayer:FlexSprite = null;
        private var m_UncommittedDataProvider:Boolean = false;
        protected var m_ItemHeightHint:int = 0;
        protected var m_DataProvider:IList = null;
        protected var m_DragScrollClick:Point = null;
        protected var m_UIItemLayer:UIComponent = null;
        protected var m_AvailableRenderers:Array = null;
        private var m_UncommittedSelectedIndex:Boolean = true;
        public static const FOLLOW_TAIL_ON:String = "on";
        private static const m_TempPoint2:Point = new Point();
        private static const DRAGSCROLL_DELAY:int = 50;
        private static const LINE_SCROLL_SIZE:Number = 6;
        private static const DRAGSCROLL_MAX_DISTANCE:Number = 128;
        public static const FOLLOW_TAIL_AUTO:String = "auto";
        private static const m_TempPoint:Point = new Point();
        private static const DRAGSCROLL_MAX_SPEED:Number = 12;
        public static const FOLLOW_TAIL_OFF:String = "off";

        public function SmoothList(param1:Class, param2:int = 0)
        {
            verticalScrollPolicy = ScrollPolicy.ON;
            this.m_ItemHeightHint = param2;
            this.m_ItemRendererFactory = new ClassFactory(param1);
            this.resetExtentCache();
            this.resetRendererCache();
            return;
        }// end function

        public function get defaultItemCount() : int
        {
            return this.m_ItemDefaultCount;
        }// end function

        protected function onMouseMove(event:MouseEvent) : void
        {
            if (event != null)
            {
                this.updateRollOverItem(event.stageX, event.stageY, true);
            }
            return;
        }// end function

        protected function aquireItemRenderer(param1:int = -1, param2:int = 1) : IListItemRenderer
        {
            var _loc_3:* = null;
            if (param1 > -1 && param1 < this.m_UIItemLayer.numChildren)
            {
                _loc_3 = IListItemRenderer(this.m_UIItemLayer.getChildAt(param1));
            }
            else
            {
                if (this.m_AvailableRenderers.length > 0)
                {
                    _loc_3 = IListItemRenderer(this.m_AvailableRenderers.pop());
                }
                else
                {
                    _loc_3 = this.createItemRenderer();
                }
                if (param2 > 0)
                {
                    this.m_UIItemLayer.addChild(DisplayObject(_loc_3));
                }
                else
                {
                    this.m_UIItemLayer.addChildAt(DisplayObject(_loc_3), 0);
                }
            }
            return _loc_3;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_11:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = NaN;
            var _loc_18:* = 0;
            var _loc_19:* = NaN;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            super.updateDisplayList(param1, param2);
            _loc_3 = this.viewMetricsAndPadding;
            var _loc_4:* = getStyle("itemHorizontalGap");
            var _loc_5:* = getStyle("itemVerticalGap");
            var _loc_6:* = param1 - _loc_3.left - _loc_3.right;
            var _loc_7:* = param2 - _loc_3.top - _loc_3.bottom;
            var _loc_8:* = this.m_DataProvider != null ? (this.m_DataProvider.length) : (0);
            var _loc_9:* = this.m_ExtentChache.topToIndex(verticalScrollPosition);
            var _loc_10:* = null;
            _loc_11 = verticalScrollPosition - this.m_ExtentChache.top(_loc_9);
            var _loc_12:* = _loc_11 + _loc_7 + _loc_5;
            var _loc_13:* = this.m_UIItemLayer.height;
            this.m_UIContentLayer.move(_loc_3.left, _loc_3.top);
            this.m_UIContentLayer.setActualSize(_loc_6, _loc_7);
            if (isNaN(_loc_11))
            {
                _loc_11 = 0;
            }
            this.m_AlignBottom = this.m_FollowTail || param2 > this.m_ResizeFollowTailHeight;
            if (this.m_ForceUpdate || this.m_AlignBottom || this.m_ExtentChache.width != _loc_6 || this.m_FirstVisibleItem != _loc_9 || this.m_LastVisibleItem != this.m_ExtentChache.topToIndex(verticalScrollPosition + _loc_7))
            {
                this.m_RendererMap.length = 0;
                this.m_ExtentChache.width = _loc_6;
                _loc_16 = 0;
                if (this.m_AlignBottom)
                {
                    _loc_16 = -1;
                    _loc_13 = 0;
                    this.m_LastVisibleItem = _loc_8 - 1;
                    this.m_FirstVisibleItem = _loc_8 - 1;
                }
                else
                {
                    _loc_16 = 1;
                    _loc_13 = 0;
                    var _loc_23:* = Math.min(_loc_9, (_loc_8 - 1));
                    this.m_LastVisibleItem = Math.min(_loc_9, (_loc_8 - 1));
                    this.m_FirstVisibleItem = _loc_23;
                }
                _loc_17 = 0;
                _loc_18 = 0;
                _loc_18 = 0;
                _loc_9 = this.m_LastVisibleItem;
                while (_loc_9 >= 0 && _loc_9 < _loc_8 && _loc_13 < _loc_12)
                {
                    
                    _loc_10 = this.aquireItemRenderer(_loc_18++, _loc_16);
                    _loc_10.data = this.m_DataProvider.getItemAt(_loc_9);
                    _loc_10.height = NaN;
                    _loc_10.width = _loc_6;
                    LayoutManager.getInstance().validateClient(_loc_10, true);
                    _loc_17 = _loc_10.getExplicitOrMeasuredHeight();
                    _loc_13 = _loc_13 + (_loc_17 + _loc_5);
                    this.m_RendererMap.splice(_loc_16 > 0 ? ((_loc_18 - 1)) : (0), 0, _loc_10);
                    this.m_ExtentChache.updateItemAt(_loc_17, _loc_9);
                    this.m_FirstVisibleItem = Math.min(this.m_FirstVisibleItem, _loc_9);
                    this.m_LastVisibleItem = Math.max(this.m_LastVisibleItem, _loc_9);
                    if (_loc_16 > 0 && _loc_9 == (_loc_8 - 1) && _loc_18 < _loc_8 && _loc_12 > 0)
                    {
                        _loc_9 = this.m_FirstVisibleItem;
                        _loc_16 = -1;
                    }
                    _loc_9 = _loc_9 + _loc_16;
                }
                this.trimItemRenderers(_loc_18);
                _loc_19 = 0;
                _loc_9 = 0;
                while (_loc_9 < _loc_18)
                {
                    
                    _loc_10 = IListItemRenderer(this.m_RendererMap[_loc_9]);
                    _loc_17 = _loc_10.getExplicitOrMeasuredHeight();
                    _loc_10.move(0, _loc_19);
                    _loc_10.setActualSize(_loc_6, _loc_17);
                    _loc_19 = _loc_19 + (_loc_17 + _loc_5);
                    _loc_9++;
                }
            }
            if (_loc_13 > _loc_12 - _loc_11)
            {
                if (verticalScrollPosition > maxVerticalScrollPosition)
                {
                    this.m_ResizeFollowTailHeight = param2;
                    this.m_AlignBottom = true;
                }
            }
            else
            {
                this.m_ResizeFollowTailHeight = NaN;
            }
            if (this.m_AlignBottom)
            {
                this.m_UIItemLayer.move(0, _loc_7 - _loc_13);
                this.m_UIItemLayer.setActualSize(_loc_6, _loc_13);
            }
            else
            {
                this.m_UIItemLayer.move(0, _loc_13 < _loc_7 ? (0) : (-_loc_11));
                this.m_UIItemLayer.setActualSize(_loc_6, _loc_13);
            }
            _loc_13 = _loc_8 > 0 ? (this.m_ExtentChache.bottom((_loc_8 - 1))) : (0);
            setScrollBarProperties(1, 1, _loc_13, _loc_7);
            if (this.m_AlignBottom)
            {
                verticalScrollPosition = Math.max(0, _loc_13 - _loc_7);
            }
            else
            {
                if (_loc_13 < _loc_7)
                {
                    verticalScrollPosition = 0;
                }
                _loc_20 = new ScrollEvent(ScrollEvent.SCROLL);
                _loc_20.direction = ScrollEventDirection.VERTICAL;
                _loc_20.position = verticalScrollPosition;
                _loc_20.delta = 0;
                dispatchEvent(_loc_20);
            }
            var _loc_14:* = localToGlobal(new Point(mouseX, mouseY));
            this.updateRollOverItem(_loc_14.x, _loc_14.y, this.m_ForceUpdate);
            this.m_ForceUpdate = false;
            var _loc_15:* = this.m_UISelectionLayer.graphics;
            _loc_15.clear();
            if (getStyle("itemBackgroundColors") !== undefined)
            {
                _loc_21 = getStyle("itemBackgroundColors");
                _loc_22 = getStyle("itemBackgroundAlphas");
                if (_loc_21.length == 1)
                {
                    _loc_15.beginFill(_loc_21[0], _loc_22[0]);
                    _loc_15.drawRect(0, 0, this.m_UIItemLayer.width, this.m_UIItemLayer.height);
                }
                else
                {
                    _loc_9 = this.m_FirstVisibleItem;
                    while (_loc_9 <= this.m_LastVisibleItem)
                    {
                        
                        var _loc_23:* = this.itemIndexToItemRenderer(_loc_9);
                        _loc_10 = this.itemIndexToItemRenderer(_loc_9);
                        if ((!this.m_Selectable || this.m_SelectedIndex != _loc_9) && _loc_23 != null)
                        {
                            _loc_15.beginFill(_loc_21[_loc_9 % _loc_21.length], _loc_22[_loc_9 % _loc_21.length]);
                            _loc_15.drawRect(Math.floor(_loc_10.x - _loc_4 / 2), Math.floor(_loc_10.y - _loc_5 / 2), Math.ceil(_loc_10.width + _loc_4), Math.ceil(_loc_10.height + _loc_5));
                        }
                        _loc_9++;
                    }
                }
            }
            var _loc_23:* = this.itemIndexToItemRenderer(this.m_SelectedIndex);
            _loc_10 = this.itemIndexToItemRenderer(this.m_SelectedIndex);
            if (this.m_Selectable && getStyle("itemSelectionColor") !== undefined && _loc_23 != null)
            {
                _loc_15.beginFill(getStyle("itemSelectionColor"), getStyle("itemSelectionAlpha"));
                _loc_15.drawRect(_loc_10.x, _loc_10.y, _loc_10.width, _loc_10.height);
            }
            _loc_15.endFill();
            this.m_UISelectionLayer.x = this.m_UIItemLayer.x;
            this.m_UISelectionLayer.y = this.m_UIItemLayer.y;
            if (verticalScrollBar != null)
            {
                verticalScrollBar.lineScrollSize = LINE_SCROLL_SIZE;
            }
            if (horizontalScrollBar != null)
            {
                horizontalScrollBar.lineScrollSize = LINE_SCROLL_SIZE;
            }
            return;
        }// end function

        public function get minItemCount() : int
        {
            return this.m_ItemMinCount;
        }// end function

        protected function resetRendererCache() : void
        {
            if (this.m_AvailableRenderers == null)
            {
                this.m_AvailableRenderers = new Array();
            }
            this.m_AvailableRenderers.length = 0;
            if (this.m_RendererMap == null)
            {
                this.m_RendererMap = new Array();
            }
            this.m_RendererMap.length = 0;
            if (this.m_UIItemLayer != null)
            {
                while (this.m_UIItemLayer.numChildren > 0)
                {
                    
                    this.m_UIItemLayer.removeChildAt(0);
                }
            }
            return;
        }// end function

        public function set followTailPolicy(param1:String) : void
        {
            switch(param1)
            {
                case FOLLOW_TAIL_ON:
                {
                    this.m_FollowTail = true;
                    break;
                }
                case FOLLOW_TAIL_OFF:
                {
                    this.m_FollowTail = false;
                    break;
                }
                case FOLLOW_TAIL_AUTO:
                {
                    this.m_FollowTail = true;
                    break;
                }
                default:
                {
                    return;
                    break;
                }
            }
            this.m_FollowTailPolicy = param1;
            invalidateDisplayList();
            return;
        }// end function

        public function set minItemCount(param1:int) : void
        {
            if (this.m_ItemMinCount != param1)
            {
                this.m_ItemMinCount = Math.max(1, param1);
                this.m_ItemDefaultCount = Math.max(this.m_ItemMinCount, this.m_ItemDefaultCount);
                invalidateSize();
            }
            return;
        }// end function

        protected function startDragToScroll() : void
        {
            if (this.m_DragScrollTimer != null)
            {
                this.stopDragToScroll();
            }
            this.m_DragScrollTimer = new Timer(DRAGSCROLL_DELAY);
            this.m_DragScrollTimer.addEventListener(TimerEvent.TIMER, this.onDragScrollTimer);
            this.m_DragScrollTimer.start();
            var _loc_1:* = systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                _loc_1.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onMouseUp);
            }
            return;
        }// end function

        public function set defaultItemCount(param1:int) : void
        {
            if (this.m_ItemDefaultCount != param1)
            {
                this.m_ItemDefaultCount = Math.max(this.m_ItemMinCount, param1);
                invalidateSize();
            }
            return;
        }// end function

        protected function createItemRenderer() : IListItemRenderer
        {
            var _loc_1:* = IListItemRenderer(this.m_ItemRendererFactory.newInstance());
            _loc_1.owner = this;
            if (getStyle("itemRendererStyle") !== undefined)
            {
                _loc_1.styleName = getStyle("itemRendererStyle");
            }
            else
            {
                _loc_1.styleName = this;
            }
            return _loc_1;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            if (this.m_Selectable && param1 != null && this.m_DataProvider != null)
            {
                this.m_SelectedIndex = this.m_DataProvider.getItemIndex(param1);
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onRollOver(event:MouseEvent) : void
        {
            this.m_MouseCursorOverList = true;
            if (event != null)
            {
                this.updateRollOverItem(event.stageX, event.stageY, true);
                this.m_DragScrollClick = null;
            }
            return;
        }// end function

        public function mouseEventToItemRenderer(event:MouseEvent) : IListItemRenderer
        {
            var _loc_3:* = null;
            var _loc_2:* = this.m_ItemRendererFactory.generator;
            if (event != null)
            {
                _loc_3 = event.target as DisplayObject;
                while (_loc_3 != null && !(_loc_3 is Stage))
                {
                    
                    if (_loc_3 is _loc_2)
                    {
                        return _loc_3 as IListItemRenderer;
                    }
                    _loc_3 = _loc_3.parent;
                }
            }
            return null;
        }// end function

        public function pointToItemIndex(param1:Number, param2:Number) : int
        {
            var _loc_11:* = null;
            var _loc_3:* = this.m_FirstVisibleItem;
            var _loc_4:* = this.m_LastVisibleItem;
            if (_loc_3 < 0 || _loc_4 < 0 || !hitTestPoint(param1, param2))
            {
                return -1;
            }
            var _loc_5:* = verticalScrollPosition;
            if (isNaN(_loc_5))
            {
                _loc_5 = 0;
            }
            m_TempPoint.setTo(param1, param2);
            var _loc_6:* = globalToLocal(m_TempPoint);
            if (_loc_6.x < 0 || _loc_6.x > this.width || _loc_6.y < 0 || _loc_6.y > this.height)
            {
                return -1;
            }
            _loc_11 = this.m_UIItemLayer.globalToContent(m_TempPoint);
            if (_loc_11.x < 0 || _loc_11.x > this.m_UIItemLayer.width)
            {
                return -1;
            }
            var _loc_7:* = unscaledHeight - viewMetrics.top - viewMetrics.bottom;
            if (this.m_AlignBottom && this.m_ExtentChache.bottom(this.m_LastVisibleItem) < _loc_7)
            {
                _loc_5 = _loc_5 + (_loc_6.y - (_loc_7 - this.m_ExtentChache.bottom(this.m_LastVisibleItem)));
            }
            else
            {
                _loc_5 = _loc_5 + _loc_6.y;
            }
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_8 = _loc_3 + _loc_4 >> 1;
                _loc_9 = this.m_ExtentChache.top(_loc_8);
                _loc_10 = _loc_9 + this.m_ExtentChache.getItemAt(_loc_8);
                if (_loc_5 < _loc_9)
                {
                    _loc_4 = _loc_8 - 1;
                    continue;
                }
                if (_loc_5 > _loc_10)
                {
                    _loc_3 = _loc_8 + 1;
                    continue;
                }
                return _loc_8;
            }
            return -1;
        }// end function

        protected function resetExtentCache() : void
        {
            if (this.m_ExtentChache == null)
            {
                this.m_ExtentChache = new ExtentCache(this.m_ItemHeightHint);
            }
            this.m_ExtentChache.reset();
            this.m_ExtentChache.gap = getStyle("itemVerticalGap");
            this.m_FirstVisibleItem = -1;
            this.m_LastVisibleItem = -1;
            this.m_FollowTail = this.m_FollowTailPolicy == FOLLOW_TAIL_ON || this.m_FollowTailPolicy == FOLLOW_TAIL_AUTO;
            return;
        }// end function

        protected function stopDragToScroll() : void
        {
            if (this.m_DragScrollTimer != null)
            {
                this.m_DragScrollTimer.stop();
                this.m_DragScrollTimer.removeEventListener(TimerEvent.TIMER, this.onDragScrollTimer);
            }
            this.m_DragScrollTimer = null;
            var _loc_1:* = systemManager.getSandboxRoot();
            if (_loc_1 != null)
            {
                _loc_1.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                _loc_1.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onMouseUp);
            }
            return;
        }// end function

        protected function updateRollOverItem(param1:Number, param2:Number, param3:Boolean = false) : void
        {
            var _loc_4:* = -1;
            if (this.m_MouseCursorOverList && !isNaN(param1) && !isNaN(param2))
            {
                _loc_4 = this.pointToItemIndex(param1, param2);
            }
            var _loc_5:* = null;
            if (param3 || this.m_RollOverItem != _loc_4)
            {
                if (this.m_RollOverItem > -1 && this.m_RollOverItem != _loc_4)
                {
                    _loc_5 = new ListEvent(ListEvent.ITEM_ROLL_OUT);
                    _loc_5.columnIndex = 0;
                    _loc_5.rowIndex = this.m_RollOverItem;
                    _loc_5.reason = ListEventReason.OTHER;
                    _loc_5.itemRenderer = this.itemIndexToItemRenderer(this.m_RollOverItem);
                    dispatchEvent(_loc_5);
                }
                this.m_RollOverItem = _loc_4;
                if (this.m_RollOverItem > -1)
                {
                    _loc_5 = new ListEvent(ListEvent.ITEM_ROLL_OVER);
                    _loc_5.columnIndex = 0;
                    _loc_5.rowIndex = this.m_RollOverItem;
                    _loc_5.reason = ListEventReason.OTHER;
                    _loc_5.itemRenderer = this.itemIndexToItemRenderer(this.m_RollOverItem);
                    dispatchEvent(_loc_5);
                }
            }
            return;
        }// end function

        protected function onMouseClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            var _loc_4:* = this.pointToItemIndex(event.stageX, event.stageY);
            _loc_2 = this.pointToItemIndex(event.stageX, event.stageY);
            if (event != null && _loc_4 > -1)
            {
                this.selectedIndex = _loc_2;
                _loc_3 = new ListEvent(ListEvent.ITEM_CLICK);
                _loc_3.columnIndex = 0;
                _loc_3.rowIndex = _loc_2;
                _loc_3.reason = ListEventReason.OTHER;
                _loc_3.itemRenderer = this.itemIndexToItemRenderer(_loc_2);
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        override protected function mouseWheelHandler(event:MouseEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            if (verticalScrollBar != null && verticalScrollBar.visible)
            {
                event.stopPropagation();
                _loc_2 = verticalScrollPosition;
                _loc_3 = verticalScrollPosition - event.delta * verticalScrollBar.lineScrollSize;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                if (_loc_3 > maxVerticalScrollPosition)
                {
                    _loc_3 = maxVerticalScrollPosition;
                }
                if (this.m_FollowTailPolicy == FOLLOW_TAIL_AUTO)
                {
                    this.m_FollowTail = _loc_3 >= maxVerticalScrollPosition;
                }
                if (_loc_2 != _loc_3)
                {
                    verticalScrollPosition = _loc_3;
                    _loc_4 = new ScrollEvent(ScrollEvent.SCROLL);
                    _loc_4.direction = ScrollEventDirection.VERTICAL;
                    _loc_4.position = _loc_3;
                    _loc_4.delta = _loc_3 - _loc_2;
                    dispatchEvent(_loc_4);
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        protected function onDataProviderChange(event:CollectionEvent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (event != null)
            {
                _loc_2 = unscaledHeight - viewMetrics.top - viewMetrics.bottom;
                _loc_3 = NaN;
                _loc_4 = NaN;
                _loc_5 = verticalScrollPosition;
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        this.m_ExtentChache.addItemAt(NaN, event.location);
                        if (event.location <= this.m_FirstVisibleItem)
                        {
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_FirstVisibleItem + 1;
                            _loc_6.m_FirstVisibleItem = _loc_7;
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_LastVisibleItem + 1;
                            _loc_6.m_LastVisibleItem = _loc_7;
                            verticalScrollPosition = verticalScrollPosition + (this.m_ExtentChache.getItemAt(event.location) + this.m_ExtentChache.gap);
                        }
                        else if (event.location > this.m_FirstVisibleItem && event.location <= this.m_LastVisibleItem)
                        {
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_LastVisibleItem + 1;
                            _loc_6.m_LastVisibleItem = _loc_7;
                        }
                        break;
                    }
                    case CollectionEventKind.MOVE:
                    {
                        _loc_3 = this.m_ExtentChache.removeItemAt(event.oldLocation);
                        this.m_ExtentChache.addItemAt(_loc_3, event.location);
                        if (event.oldLocation < this.m_FirstVisibleItem)
                        {
                            verticalScrollPosition = verticalScrollPosition - _loc_3;
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_FirstVisibleItem - 1;
                            _loc_6.m_FirstVisibleItem = _loc_7;
                        }
                        if (event.location <= this.m_FirstVisibleItem)
                        {
                            verticalScrollPosition = verticalScrollPosition + _loc_3;
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_FirstVisibleItem + 1;
                            _loc_6.m_FirstVisibleItem = _loc_7;
                        }
                        if (event.oldLocation >= this.m_FirstVisibleItem && event.oldLocation <= this.m_LastVisibleItem || event.location >= this.m_FirstVisibleItem && event.location <= this.m_LastVisibleItem)
                        {
                            this.m_LastVisibleItem = Math.min(this.m_LastVisibleItem, (event.oldLocation - 1), (event.location - 1));
                        }
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        _loc_3 = this.m_ExtentChache.removeItemAt(event.location);
                        if (event.location < this.m_FirstVisibleItem)
                        {
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_FirstVisibleItem - 1;
                            _loc_6.m_FirstVisibleItem = _loc_7;
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_LastVisibleItem - 1;
                            _loc_6.m_LastVisibleItem = _loc_7;
                            verticalScrollPosition = verticalScrollPosition - (_loc_3 + this.m_ExtentChache.gap);
                        }
                        else if (this.m_FirstVisibleItem <= event.location && event.location <= this.m_LastVisibleItem)
                        {
                            var _loc_6:* = this;
                            var _loc_7:* = this.m_LastVisibleItem - 1;
                            _loc_6.m_LastVisibleItem = _loc_7;
                        }
                        break;
                    }
                    case CollectionEventKind.REPLACE:
                    case CollectionEventKind.UPDATE:
                    {
                        if (event.location <= -1)
                        {
                        }
                        else if (event.location > -1 && event.location < this.m_FirstVisibleItem)
                        {
                            _loc_3 = this.m_ExtentChache.updateItemAt(NaN, event.location);
                            _loc_4 = !isNaN(_loc_3) ? (this.m_ExtentChache.getItemAt(event.location) - _loc_3) : (0);
                            verticalScrollPosition = verticalScrollPosition + _loc_4;
                        }
                        else if (event.location == this.m_FirstVisibleItem)
                        {
                            verticalScrollPosition = this.m_ExtentChache.top(this.m_FirstVisibleItem);
                            this.m_LastVisibleItem = -1;
                        }
                        else if (event.location > this.m_FirstVisibleItem && event.location <= this.m_LastVisibleItem)
                        {
                            this.m_LastVisibleItem = -1;
                        }
                        break;
                    }
                    case CollectionEventKind.REFRESH:
                    {
                        this.m_ForceUpdate = true;
                        if (this.m_DataProvider.length > 0)
                        {
                            verticalScrollPosition = Math.max(0, Math.min(_loc_5, maxVerticalScrollPosition));
                        }
                        else
                        {
                            verticalScrollPosition = 0;
                        }
                        break;
                    }
                    case CollectionEventKind.RESET:
                    {
                        this.m_ForceUpdate = true;
                        this.resetExtentCache();
                        verticalScrollPosition = 0;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.m_SelectedIndex = -1;
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
                this.m_ForceUpdate = true;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get viewMetricsAndPadding() : EdgeMetrics
        {
            var _loc_1:* = viewMetrics.clone();
            _loc_1.bottom = _loc_1.bottom + getStyle("paddingBottom");
            _loc_1.left = _loc_1.left + getStyle("paddingLeft");
            _loc_1.right = _loc_1.right + getStyle("paddingRight");
            _loc_1.top = _loc_1.top + getStyle("paddingTop");
            return _loc_1;
        }// end function

        protected function onRollOut(event:MouseEvent) : void
        {
            this.m_MouseCursorOverList = false;
            if (event != null)
            {
                if (event.buttonDown && this.m_DragScrollClick != null && this.m_DragScrollTimer == null)
                {
                    this.startDragToScroll();
                }
                if (this.m_RollOverItem > -1)
                {
                    this.updateRollOverItem(event.stageX, event.stageY, true);
                }
            }
            return;
        }// end function

        public function get dataProvider() : IList
        {
            return this.m_DataProvider;
        }// end function

        public function itemRendererToIndex(param1:IListItemRenderer) : int
        {
            var _loc_2:* = this.m_RendererMap.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_RendererMap[_loc_2] == param1)
                {
                    return this.m_FirstVisibleItem + _loc_2;
                }
                _loc_2 = _loc_2 - 1;
            }
            return -1;
        }// end function

        protected function onDragScrollTimer(event:TimerEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            if (event != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                if (mouseY < 0)
                {
                    _loc_2 = -1;
                    _loc_3 = -mouseY;
                }
                if (mouseY > unscaledHeight)
                {
                    _loc_2 = 1;
                    _loc_3 = mouseY - unscaledHeight;
                }
                if (_loc_2 == 0 || _loc_3 == 0)
                {
                    return;
                }
                _loc_3 = Math.min(_loc_3, DRAGSCROLL_MAX_DISTANCE) / DRAGSCROLL_MAX_DISTANCE;
                _loc_3 = _loc_2 * _loc_3 * DRAGSCROLL_MAX_SPEED;
                _loc_4 = verticalScrollPosition;
                _loc_5 = verticalScrollPosition + _loc_3;
                if (_loc_5 < 0)
                {
                    _loc_5 = 0;
                }
                if (_loc_5 > maxVerticalScrollPosition)
                {
                    _loc_5 = maxVerticalScrollPosition;
                }
                if (_loc_4 != _loc_5)
                {
                    verticalScrollPosition = _loc_5;
                    _loc_6 = new ScrollEvent(ScrollEvent.SCROLL);
                    _loc_6.direction = ScrollEventDirection.VERTICAL;
                    _loc_6.position = _loc_5;
                    _loc_6.delta = _loc_5 - _loc_4;
                    dispatchEvent(_loc_6);
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        protected function onMouseDown(event:MouseEvent) : void
        {
            if (event != null)
            {
                if (hitTestPoint(event.stageX, event.stageY))
                {
                    this.m_DragScrollClick = new Point(event.localX, event.localY);
                }
                else
                {
                    this.m_DragScrollClick = null;
                }
            }
            return;
        }// end function

        public function get followTailPolicy() : String
        {
            return this.m_FollowTailPolicy;
        }// end function

        protected function onMouseUp(event:Event) : void
        {
            if (event != null)
            {
                this.stopDragToScroll();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedDataProvider)
            {
                this.m_SelectedIndex = -1;
                this.m_RollOverItem = -1;
                this.resetExtentCache();
                this.resetRendererCache();
                invalidateDisplayList();
                this.m_UncommittedDataProvider = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                invalidateDisplayList();
                this.m_UncommittedSelectedIndex = false;
            }
            if (this.m_UncommittedRollOverItem)
            {
                invalidateDisplayList();
                this.m_UncommittedRollOverItem = false;
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "itemVerticalGap":
                {
                    this.m_ExtentChache.gap = getStyle("itemVerticalGap");
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIContentLayer = new UIComponent();
                this.m_UIContentLayer.mask = maskShape;
                addChild(this.m_UIContentLayer);
                this.m_UISelectionLayer = new FlexSprite();
                this.m_UISelectionLayer.mouseEnabled = false;
                this.m_UIContentLayer.addChild(this.m_UISelectionLayer);
                this.m_UIItemLayer = new UIComponent();
                this.m_UIItemLayer.addEventListener(MouseEvent.CLICK, this.onMouseClick);
                this.m_UIItemLayer.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.m_UIItemLayer.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                this.m_UIContentLayer.addChild(this.m_UIItemLayer);
                addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
                addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            if (this.m_Selectable && !param1)
            {
                this.selectedIndex = -1;
            }
            this.m_Selectable = param1;
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = 0;
            if (!isNaN(getStyle("itemVerticalGap")))
            {
                _loc_1 = getStyle("itemVerticalGap");
            }
            if (this.m_ItemMinCount > 1)
            {
                measuredMinHeight = this.m_ItemMinCount * this.m_ItemHeightHint + (this.m_ItemMinCount - 1) * _loc_1;
            }
            else
            {
                measuredMinHeight = this.m_ItemHeightHint;
            }
            if (this.m_ItemDefaultCount > 1)
            {
                measuredHeight = this.m_ItemDefaultCount * this.m_ItemHeightHint + (this.m_ItemDefaultCount - 1) * _loc_1;
            }
            else
            {
                measuredHeight = this.m_ItemHeightHint;
            }
            return;
        }// end function

        override protected function scrollHandler(event:Event) : void
        {
            super.scrollHandler(event);
            if (this.m_FollowTailPolicy == FOLLOW_TAIL_AUTO)
            {
                this.m_FollowTail = verticalScrollPosition >= maxVerticalScrollPosition;
            }
            invalidateDisplayList();
            return;
        }// end function

        protected function trimItemRenderers(param1:int = 0) : void
        {
            var _loc_2:* = this.m_UIItemLayer.numChildren;
            while (param1 >= 0 && --_loc_2 > param1)
            {
                
                this.m_AvailableRenderers.push(this.m_UIItemLayer.removeChildAt(--_loc_2));
            }
            return;
        }// end function

        public function get selectable() : Boolean
        {
            return this.m_Selectable;
        }// end function

        public function set dataProvider(param1:IList) : void
        {
            if (this.m_DataProvider != param1)
            {
                if (this.m_DataProvider != null)
                {
                    this.m_DataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
                this.m_DataProvider = param1;
                if (this.m_DataProvider != null)
                {
                    this.m_DataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
                this.m_UncommittedDataProvider = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        public function get selectedItem() : Object
        {
            if (this.m_Selectable && this.m_DataProvider != null && this.m_SelectedIndex >= 0 && this.m_SelectedIndex < this.m_DataProvider.length)
            {
                return this.m_DataProvider.getItemAt(this.m_SelectedIndex);
            }
            return null;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            if (this.m_Selectable && this.m_SelectedIndex != param1)
            {
                if (this.m_DataProvider == null || !this.m_Selectable)
                {
                    this.m_SelectedIndex = -1;
                }
                else
                {
                    this.m_SelectedIndex = Math.min(Math.max(0, param1), this.m_DataProvider.length);
                }
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function itemIndexToItemRenderer(param1:int) : IListItemRenderer
        {
            if (param1 < this.m_FirstVisibleItem || param1 > this.m_LastVisibleItem)
            {
                return null;
            }
            return this.m_RendererMap[param1 - this.m_FirstVisibleItem] as IListItemRenderer;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration(Selector);
            }
            Decl.defaultFactory = function () : void
            {
                this.borderSkin = undefined;
                this.itemBackgroundColors = undefined;
                this.itemBackgroundAlphas = undefined;
                this.itemHorizontalGap = 0;
                this.itemVerticalGap = 2;
                this.itemSelectionColor = 16711680;
                this.itemSelectionAlpha = 1;
                this.itemRendererStyle = undefined;
                this.paddingBottom = 0;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
