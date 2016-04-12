package mx.containers
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.dividedBoxClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class DividedBox extends Box
    {
        private var postLayoutChanges:Array;
        private var minDelta:Number;
        private var layoutStyleChanged:Boolean = false;
        private var dbPreferredHeight:Number;
        private var dbMinWidth:Number;
        private var maxDelta:Number;
        private var activeDividerStartPosition:Number;
        var activeDivider:BoxDivider;
        private var dbMinHeight:Number;
        private var dividerLayer:UIComponent = null;
        private var dragStartPosition:Number;
        public var liveDragging:Boolean = false;
        private var oldChildSizes:Array;
        protected var dividerClass:Class;
        private var dbPreferredWidth:Number;
        private var dragDelta:Number;
        private var activeDividerIndex:int = -1;
        private var _resizeToContent:Boolean = false;
        private var numLayoutChildren:int = 0;
        private var cursorID:int = 0;
        private var dontCoalesceDividers:Boolean;
        static const VERSION:String = "3.6.0.21751";
        private static const PROXY_DIVIDER_INDEX:int = 999;
        private static var classInitialized:Boolean = false;

        public function DividedBox()
        {
            dividerClass = BoxDivider;
            if (!classInitialized)
            {
                initializeClass();
                classInitialized = true;
            }
            addEventListener(ChildExistenceChangedEvent.CHILD_ADD, childAddHandler);
            addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, childRemoveHandler);
            showInAutomationHierarchy = true;
            return;
        }// end function

        public function set resizeToContent(param1:Boolean) : void
        {
            if (param1 != _resizeToContent)
            {
                _resizeToContent = param1;
                if (param1)
                {
                    invalidateSize();
                }
            }
            return;
        }// end function

        private function child_includeInLayoutChangedHandler(event:Event) : void
        {
            var _loc_2:* = UIComponent(event.target);
            numLayoutChildren = (numLayoutChildren + 1);
            if (_loc_2.includeInLayout && numLayoutChildren > 1)
            {
                createDivider(numLayoutChildren - 2);
            }
            else
            {
                numLayoutChildren = (numLayoutChildren - 1);
                if (!_loc_2.includeInLayout && numLayoutChildren > 0)
                {
                    dividerLayer.removeChild(getDividerAt((numLayoutChildren - 1)));
                }
            }
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
            invalidateSize();
            return;
        }// end function

        private function createDivider(param1:int) : BoxDivider
        {
            if (!dividerLayer)
            {
                dividerLayer = UIComponent(rawChildren.addChild(new UIComponent()));
            }
            var _loc_2:* = BoxDivider(new dividerClass());
            dividerLayer.addChild(_loc_2);
            if (param1 == PROXY_DIVIDER_INDEX)
            {
                rawChildren.setChildIndex(dividerLayer, (rawChildren.numChildren - 1));
            }
            var _loc_3:* = param1 == PROXY_DIVIDER_INDEX ? (getDividerAt(activeDividerIndex)) : (this);
            _loc_2.styleName = _loc_3;
            _loc_2.owner = this;
            return _loc_2;
        }// end function

        public function moveDivider(param1:int, param2:Number) : void
        {
            if (param1 < 0 || param1 >= numDividers)
            {
                return;
            }
            if (activeDividerIndex >= 0)
            {
                return;
            }
            activeDividerIndex = param1;
            cacheChildSizes();
            computeMinAndMaxDelta();
            dragDelta = limitDelta(param2);
            adjustChildSizes();
            invalidateSize();
            invalidateDisplayList();
            resetDividerTracking();
            return;
        }// end function

        function restoreCursor() : void
        {
            if (cursorID != CursorManager.NO_CURSOR)
            {
                cursorManager.removeCursor(cursorID);
                cursorID = CursorManager.NO_CURSOR;
            }
            return;
        }// end function

        private function layoutDivider(param1:int, param2:Number, param3:Number, param4:IUIComponent, param5:IUIComponent) : void
        {
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_6:* = BoxDivider(getDividerAt(param1));
            var _loc_7:* = viewMetrics;
            var _loc_8:* = getStyle("verticalGap");
            var _loc_9:* = getStyle("horizontalGap");
            var _loc_10:* = _loc_6.getStyle("dividerThickness");
            var _loc_11:* = _loc_6.getStyle("dividerAffordance");
            if (isVertical())
            {
                _loc_12 = _loc_11;
                if (_loc_12 < _loc_10)
                {
                    _loc_12 = _loc_10;
                }
                if (_loc_12 > _loc_8)
                {
                    _loc_12 = _loc_8;
                }
                _loc_6.setActualSize(param2 - _loc_7.left - _loc_7.right, _loc_12);
                _loc_6.move(_loc_7.left, Math.round((param4.y + param4.height + param5.y - _loc_12) / 2));
            }
            else
            {
                _loc_13 = _loc_11;
                if (_loc_13 < _loc_10)
                {
                    _loc_13 = _loc_10;
                }
                if (_loc_13 > _loc_9)
                {
                    _loc_13 = _loc_9;
                }
                _loc_6.setActualSize(_loc_13, param3 - _loc_7.top - _loc_7.bottom);
                _loc_6.move(Math.round((param4.x + param4.width + param5.x - _loc_13) / 2), _loc_7.top);
            }
            _loc_6.invalidateDisplayList();
            return;
        }// end function

        private function computeMinAndMaxDelta() : void
        {
            computeAllowableMovement(activeDividerIndex);
            return;
        }// end function

        function stopDividerDrag(param1:BoxDivider, param2:MouseEvent) : void
        {
            if (param2)
            {
                dragDelta = limitDelta(getMousePosition(param2) - dragStartPosition);
            }
            var _loc_3:* = new DividerEvent(DividerEvent.DIVIDER_RELEASE);
            _loc_3.dividerIndex = activeDividerIndex;
            _loc_3.delta = dragDelta;
            dispatchEvent(_loc_3);
            if (!liveDragging)
            {
                if (dragDelta == 0)
                {
                    getDividerAt(activeDividerIndex).state = DividerState.OVER;
                }
                if (activeDivider)
                {
                    dividerLayer.removeChild(activeDivider);
                }
                activeDivider = null;
                adjustChildSizes();
                invalidateSize();
                invalidateDisplayList();
            }
            resetDividerTracking();
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            systemManager.deployMouseShields(false);
            return;
        }// end function

        private function postLayoutAdjustment() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = postLayoutChanges.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = postLayoutChanges[_loc_2];
                if (_loc_3.percentWidth !== undefined)
                {
                    _loc_3.child.percentWidth = _loc_3.percentWidth;
                }
                if (_loc_3.percentHeight !== undefined)
                {
                    _loc_3.child.percentHeight = _loc_3.percentHeight;
                }
                if (_loc_3.explicitWidth !== undefined)
                {
                    _loc_3.child.explicitWidth = _loc_3.explicitWidth;
                }
                if (_loc_3.explicitHeight !== undefined)
                {
                    _loc_3.child.explicitHeight = _loc_3.explicitHeight;
                }
                _loc_2++;
            }
            postLayoutChanges = null;
            return;
        }// end function

        public function get numDividers() : int
        {
            if (dividerLayer)
            {
                if (!liveDragging && activeDivider)
                {
                    return (dividerLayer.numChildren - 1);
                }
                return dividerLayer.numChildren;
            }
            else
            {
                return 0;
            }
        }// end function

        private function resetDividerTracking() : void
        {
            activeDivider = null;
            activeDividerIndex = -1;
            activeDividerStartPosition = NaN;
            dragStartPosition = NaN;
            dragDelta = NaN;
            oldChildSizes = null;
            minDelta = NaN;
            maxDelta = NaN;
            return;
        }// end function

        private function childAddHandler(event:ChildExistenceChangedEvent) : void
        {
            var _loc_2:* = event.relatedObject;
            _loc_2.addEventListener("includeInLayoutChanged", child_includeInLayoutChangedHandler);
            if (!IUIComponent(_loc_2).includeInLayout)
            {
                return;
            }
            var _loc_4:* = numLayoutChildren + 1;
            numLayoutChildren = _loc_4;
            if (numLayoutChildren > 1)
            {
                createDivider(numLayoutChildren - 2);
            }
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
            return;
        }// end function

        function changeCursor(param1:BoxDivider) : void
        {
            var _loc_2:* = null;
            if (cursorID == CursorManager.NO_CURSOR)
            {
                _loc_2 = isVertical() ? (getStyle("verticalDividerCursor") as Class) : (getStyle("horizontalDividerCursor") as Class);
                cursorID = cursorManager.setCursor(_loc_2, CursorManagerPriority.HIGH, 0, 0);
            }
            return;
        }// end function

        private function mouseMoveHandler(event:MouseEvent) : void
        {
            dragDelta = limitDelta(getMousePosition(event) - dragStartPosition);
            var _loc_2:* = new DividerEvent(DividerEvent.DIVIDER_DRAG);
            _loc_2.dividerIndex = activeDividerIndex;
            _loc_2.delta = dragDelta;
            dispatchEvent(_loc_2);
            if (liveDragging)
            {
                adjustChildSizes();
                invalidateDisplayList();
                updateDisplayList(unscaledWidth, unscaledHeight);
            }
            else if (isVertical())
            {
                activeDivider.move(0, activeDividerStartPosition + dragDelta);
            }
            else
            {
                activeDivider.move(activeDividerStartPosition + dragDelta, 0);
            }
            return;
        }// end function

        public function get resizeToContent() : Boolean
        {
            return _resizeToContent;
        }// end function

        function startDividerDrag(param1:BoxDivider, param2:MouseEvent) : void
        {
            if (activeDividerIndex >= 0)
            {
                return;
            }
            activeDividerIndex = getDividerIndex(param1);
            var _loc_3:* = new DividerEvent(DividerEvent.DIVIDER_PRESS);
            _loc_3.dividerIndex = activeDividerIndex;
            dispatchEvent(_loc_3);
            if (liveDragging)
            {
                activeDivider = param1;
            }
            else
            {
                activeDivider = createDivider(PROXY_DIVIDER_INDEX);
                activeDivider.visible = false;
                activeDivider.state = DividerState.DOWN;
                activeDivider.setActualSize(param1.width, param1.height);
                activeDivider.move(param1.x, param1.y);
                activeDivider.visible = true;
                param1.state = DividerState.UP;
            }
            if (isVertical())
            {
                activeDividerStartPosition = activeDivider.y;
            }
            else
            {
                activeDividerStartPosition = activeDivider.x;
            }
            dragStartPosition = getMousePosition(param2);
            dragDelta = 0;
            cacheChildSizes();
            adjustChildSizes();
            computeMinAndMaxDelta();
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
            systemManager.deployMouseShields(true);
            return;
        }// end function

        function getDividerIndex(param1:BoxDivider) : int
        {
            var _loc_2:* = numChildren;
            var _loc_3:* = 0;
            while (_loc_3 < (_loc_2 - 1))
            {
                
                if (getDividerAt(_loc_3) == param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        private function cacheSizes() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            oldChildSizes = [];
            var _loc_1:* = isVertical();
            var _loc_2:* = Number.MAX_VALUE;
            var _loc_3:* = numChildren;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = IUIComponent(getChildAt(_loc_4));
                if (!_loc_5.includeInLayout)
                {
                }
                else
                {
                    _loc_6 = _loc_1 ? (_loc_5.height) : (_loc_5.width);
                    _loc_7 = _loc_1 ? (_loc_5.maxHeight) : (_loc_5.maxWidth);
                    _loc_8 = _loc_1 ? (_loc_5.explicitMinHeight) : (_loc_5.explicitMinWidth);
                    _loc_9 = isNaN(_loc_8) ? (0) : (_loc_8);
                    _loc_10 = Math.max(0, _loc_6 - _loc_9);
                    _loc_11 = Math.max(0, _loc_7 - _loc_6);
                    if (_loc_6 > 0 && _loc_6 < _loc_2)
                    {
                        _loc_2 = _loc_6;
                    }
                    oldChildSizes.push(new ChildSizeInfo(_loc_6, _loc_9, _loc_7, _loc_10, _loc_11));
                }
                _loc_4++;
            }
            oldChildSizes.push(new ChildSizeInfo(_loc_2 == Number.MAX_VALUE ? (1) : (_loc_2)));
            return;
        }// end function

        private function limitDelta(param1:Number) : Number
        {
            if (param1 < minDelta)
            {
                param1 = minDelta;
            }
            else if (param1 > maxDelta)
            {
                param1 = maxDelta;
            }
            param1 = Math.round(param1);
            return param1;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            super.styleChanged(param1);
            if (dividerLayer)
            {
                _loc_2 = dividerLayer.numChildren;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    getDividerAt(_loc_3).styleChanged(param1);
                    _loc_3++;
                }
            }
            if (StyleManager.isSizeInvalidatingStyle(param1))
            {
                layoutStyleChanged = true;
            }
            return;
        }// end function

        private function getMousePosition(event:MouseEvent) : Number
        {
            var _loc_2:* = new Point(event.stageX, event.stageY);
            _loc_2 = globalToLocal(_loc_2);
            return isVertical() ? (_loc_2.y) : (_loc_2.x);
        }// end function

        private function adjustChildSizes() : void
        {
            distributeDelta();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = false;
            var _loc_16:* = false;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            super.measure();
            if (!isNaN(dbPreferredWidth) && !_resizeToContent && !layoutStyleChanged)
            {
                measuredMinWidth = dbMinWidth;
                measuredMinHeight = dbMinHeight;
                measuredWidth = dbPreferredWidth;
                measuredHeight = dbPreferredHeight;
                return;
            }
            layoutStyleChanged = false;
            var _loc_1:* = this.isVertical();
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = numChildren;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_10 = IUIComponent(getChildAt(_loc_7));
                if (!_loc_10.includeInLayout)
                {
                }
                else
                {
                    _loc_11 = _loc_10.getExplicitOrMeasuredWidth();
                    _loc_12 = _loc_10.getExplicitOrMeasuredHeight();
                    _loc_13 = _loc_10.minWidth;
                    _loc_14 = _loc_10.minHeight;
                    _loc_15 = !isNaN(_loc_10.percentWidth);
                    _loc_16 = !isNaN(_loc_10.percentHeight);
                    _loc_17 = Math.min(_loc_11, _loc_13);
                    _loc_18 = Math.min(_loc_12, _loc_14);
                    if (_loc_1)
                    {
                        _loc_2 = Math.max(_loc_15 ? (_loc_13) : (_loc_11), _loc_2);
                        _loc_4 = Math.max(_loc_11, _loc_4);
                        _loc_3 = _loc_3 + (_loc_16 ? (_loc_18) : (_loc_12));
                        _loc_5 = _loc_5 + _loc_12;
                    }
                    else
                    {
                        _loc_2 = _loc_2 + (_loc_15 ? (_loc_17) : (_loc_11));
                        _loc_4 = _loc_4 + _loc_11;
                        _loc_3 = Math.max(_loc_16 ? (_loc_14) : (_loc_12), _loc_3);
                        _loc_5 = Math.max(_loc_12, _loc_5);
                    }
                }
                _loc_7++;
            }
            var _loc_8:* = layoutObject.widthPadding(numLayoutChildren);
            var _loc_9:* = layoutObject.heightPadding(numLayoutChildren);
            var _loc_19:* = _loc_2 + _loc_8;
            dbMinWidth = _loc_2 + _loc_8;
            measuredMinWidth = _loc_19;
            var _loc_19:* = _loc_3 + _loc_9;
            dbMinHeight = _loc_3 + _loc_9;
            measuredMinHeight = _loc_19;
            var _loc_19:* = _loc_4 + _loc_8;
            dbPreferredWidth = _loc_4 + _loc_8;
            measuredWidth = _loc_19;
            var _loc_19:* = _loc_5 + _loc_9;
            dbPreferredHeight = _loc_5 + _loc_9;
            measuredHeight = _loc_19;
            return;
        }// end function

        private function childRemoveHandler(event:ChildExistenceChangedEvent) : void
        {
            var _loc_2:* = event.relatedObject;
            _loc_2.removeEventListener("includeInLayoutChanged", child_includeInLayoutChangedHandler);
            if (!IUIComponent(_loc_2).includeInLayout)
            {
                return;
            }
            var _loc_4:* = numLayoutChildren - 1;
            numLayoutChildren = _loc_4;
            if (numLayoutChildren > 0)
            {
                dividerLayer.removeChild(getDividerAt((numLayoutChildren - 1)));
            }
            dbMinWidth = NaN;
            dbMinHeight = NaN;
            dbPreferredWidth = NaN;
            dbPreferredHeight = NaN;
            invalidateSize();
            return;
        }// end function

        override protected function scrollChildren() : void
        {
            super.scrollChildren();
            if (contentPane && dividerLayer)
            {
                dividerLayer.scrollRect = contentPane.scrollRect;
            }
            return;
        }// end function

        public function getDividerAt(param1:int) : BoxDivider
        {
            return BoxDivider(dividerLayer.getChildAt(param1));
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_8:* = null;
            if (!liveDragging && activeDivider)
            {
                _loc_3 = numChildren;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_8 = IUIComponent(getChildAt(_loc_4));
                    if (!_loc_8.includeInLayout)
                    {
                    }
                    else
                    {
                        _loc_8.measuredMinWidth = 0;
                        _loc_8.measuredMinHeight = 0;
                    }
                    _loc_4++;
                }
                return;
            }
            preLayoutAdjustment();
            super.updateDisplayList(param1, param2);
            postLayoutAdjustment();
            if (!dividerLayer)
            {
                return;
            }
            var _loc_5:* = viewMetrics;
            dividerLayer.x = _loc_5.left;
            dividerLayer.y = _loc_5.top;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            _loc_3 = numChildren;
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_8 = UIComponent(getChildAt(_loc_4));
                if (_loc_8.includeInLayout)
                {
                    if (_loc_6)
                    {
                        layoutDivider(_loc_7, param1, param2, _loc_6, _loc_8);
                        _loc_7++;
                    }
                    _loc_6 = _loc_8;
                }
                _loc_4++;
            }
            return;
        }// end function

        private function cacheChildSizes() : void
        {
            oldChildSizes = [];
            cacheSizes();
            return;
        }// end function

        private function distributeDelta() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            if (!dragDelta)
            {
                return;
            }
            var _loc_1:* = isVertical();
            var _loc_2:* = numLayoutChildren;
            var _loc_3:* = activeDividerIndex;
            var _loc_4:* = oldChildSizes[_loc_2].size - Math.abs(dragDelta);
            if (oldChildSizes[_loc_2].size - Math.abs(dragDelta) <= 0 || isNaN(_loc_4))
            {
                _loc_4 = 1;
            }
            var _loc_11:* = -1;
            var _loc_12:* = -1;
            while (_loc_12 < activeDividerIndex)
            {
                
                if (UIComponent(getChildAt(++_loc_11)).includeInLayout)
                {
                    _loc_12++;
                }
            }
            var _loc_13:* = _loc_11 + 1;
            var _loc_14:* = dragDelta;
            _loc_5 = _loc_3;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = ChildSizeInfo(oldChildSizes[_loc_5]);
                _loc_7 = _loc_14 < 0 ? (-Math.min(-_loc_14, _loc_6.deltaMin)) : (Math.min(_loc_14, _loc_6.deltaMax));
                _loc_8 = _loc_6.size + _loc_7;
                _loc_14 = _loc_14 - _loc_7;
                do
                {
                    
                    _loc_9 = IUIComponent(getChildAt(_loc_13--));
                }while (!_loc_9.includeInLayout)
                _loc_10 = _loc_8 / _loc_4 * 100;
                if (_loc_1)
                {
                    _loc_9.percentHeight = _loc_10;
                }
                else
                {
                    _loc_9.percentWidth = _loc_10;
                }
                if (_loc_9 is IInvalidating)
                {
                    IInvalidating(_loc_9).invalidateSize();
                }
                _loc_5 = _loc_5 - 1;
            }
            _loc_13 = _loc_11 + 1;
            _loc_14 = dragDelta;
            _loc_5 = _loc_3 + 1;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = ChildSizeInfo(oldChildSizes[_loc_5]);
                _loc_7 = _loc_14 < 0 ? (Math.min(-_loc_14, _loc_6.deltaMax)) : (-Math.min(_loc_14, _loc_6.deltaMin));
                _loc_8 = _loc_6.size + _loc_7;
                _loc_14 = _loc_14 + _loc_7;
                do
                {
                    
                    _loc_9 = IUIComponent(getChildAt(_loc_13++));
                }while (!_loc_9.includeInLayout)
                _loc_10 = _loc_8 / _loc_4 * 100;
                if (_loc_1)
                {
                    _loc_9.percentHeight = _loc_10;
                }
                else
                {
                    _loc_9.percentWidth = _loc_10;
                }
                if (_loc_9 is IInvalidating)
                {
                    IInvalidating(_loc_9).invalidateSize();
                }
                _loc_5++;
            }
            return;
        }// end function

        private function preLayoutAdjustment() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_1:* = isVertical();
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = numChildren;
            _loc_5 = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = IUIComponent(getChildAt(_loc_5));
                if (!_loc_6.includeInLayout)
                {
                }
                else
                {
                    _loc_6.measuredMinWidth = 0;
                    _loc_6.measuredMinHeight = 0;
                    _loc_7 = _loc_1 ? (_loc_6.percentHeight) : (_loc_6.percentWidth);
                    if (!isNaN(_loc_7))
                    {
                        _loc_2 = _loc_2 + _loc_7;
                        _loc_3 = _loc_3 + 1;
                    }
                }
                _loc_5++;
            }
            postLayoutChanges = [];
            if (_loc_2 == 0 && _loc_3 == 0)
            {
                _loc_5 = _loc_4 - 1;
                while (_loc_5 >= 0)
                {
                    
                    _loc_6 = UIComponent(getChildAt(_loc_5));
                    if (_loc_6.includeInLayout)
                    {
                        _loc_8 = {child:_loc_6};
                        if (_loc_1)
                        {
                            if (_loc_6.explicitHeight)
                            {
                                _loc_8.explicitHeight = _loc_6.explicitHeight;
                            }
                            else
                            {
                                _loc_8.percentHeight = NaN;
                            }
                            _loc_6.percentHeight = 100;
                        }
                        else
                        {
                            if (_loc_6.explicitWidth)
                            {
                                _loc_8.explicitWidth = _loc_6.explicitWidth;
                            }
                            else if (_loc_6.percentWidth)
                            {
                                _loc_8.percentWidth = NaN;
                            }
                            _loc_6.percentWidth = 100;
                        }
                        postLayoutChanges.push(_loc_8);
                        break;
                    }
                    _loc_5 = _loc_5 - 1;
                }
            }
            else if (_loc_2 < 100)
            {
                _loc_9 = Math.ceil((100 - _loc_2) / _loc_3);
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    _loc_6 = IUIComponent(getChildAt(_loc_5));
                    if (!_loc_6.includeInLayout)
                    {
                    }
                    else
                    {
                        _loc_8 = {child:_loc_6};
                        if (_loc_1)
                        {
                            _loc_7 = _loc_6.percentHeight;
                            if (!isNaN(_loc_7))
                            {
                                _loc_8.percentHeight = _loc_6.percentHeight;
                                postLayoutChanges.push(_loc_8);
                                _loc_6.percentHeight = (_loc_7 + _loc_9) * unscaledHeight;
                            }
                        }
                        else
                        {
                            _loc_7 = _loc_6.percentWidth;
                            if (!isNaN(_loc_7))
                            {
                                _loc_8.percentWidth = _loc_6.percentWidth;
                                postLayoutChanges.push(_loc_8);
                                _loc_6.percentWidth = (_loc_7 + _loc_9) * unscaledWidth;
                            }
                        }
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function computeAllowableMovement(param1:int) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = numLayoutChildren;
            if (param1 < 0)
            {
                return;
            }
            _loc_7 = param1;
            while (_loc_7 >= 0)
            {
                
                _loc_8 = ChildSizeInfo(oldChildSizes[_loc_7]);
                _loc_2 = _loc_2 + (dontCoalesceDividers && _loc_2 ? (0) : (_loc_8.deltaMin));
                _loc_3 = _loc_3 + (dontCoalesceDividers && _loc_3 ? (0) : (_loc_8.deltaMax));
                _loc_7 = _loc_7 - 1;
            }
            _loc_7 = param1 + 1;
            while (_loc_7 < _loc_6)
            {
                
                _loc_8 = ChildSizeInfo(oldChildSizes[_loc_7]);
                _loc_4 = _loc_4 + (dontCoalesceDividers && _loc_4 ? (0) : (_loc_8.deltaMin));
                _loc_5 = _loc_5 + (dontCoalesceDividers && _loc_5 ? (0) : (_loc_8.deltaMax));
                _loc_7++;
            }
            var _loc_9:* = Math.min(_loc_2, _loc_5);
            var _loc_10:* = Math.min(_loc_4, _loc_3);
            minDelta = -_loc_9;
            maxDelta = _loc_10;
            return;
        }// end function

        override public function set direction(param1:String) : void
        {
            var _loc_2:* = 0;
            if (super.direction != param1)
            {
                super.direction = param1;
                if (dividerLayer)
                {
                    _loc_2 = 0;
                    while (_loc_2 < dividerLayer.numChildren)
                    {
                        
                        getDividerAt(_loc_2).invalidateDisplayList();
                        _loc_2++;
                    }
                }
            }
            return;
        }// end function

        private static function initializeClass() : void
        {
            StyleManager.registerSizeInvalidatingStyle("dividerAffordance");
            StyleManager.registerSizeInvalidatingStyle("dividerThickness");
            return;
        }// end function

    }
}

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import mx.containers.dividedBoxClasses.*;

import mx.core.*;

import mx.events.*;

import mx.managers.*;

import mx.styles.*;

class ChildSizeInfo extends Object
{
    public var size:Number;
    public var min:Number;
    public var max:Number;
    public var deltaMin:Number;
    public var deltaMax:Number;

    function ChildSizeInfo(param1:Number, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0)
    {
        this.size = param1;
        this.min = param2;
        this.max = param3;
        this.deltaMin = param4;
        this.deltaMax = param5;
        return;
    }// end function

}

