package tibia.sidebar
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import tibia.cursors.*;
    import tibia.options.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class SideBarWidget extends Container
    {
        protected var m_StyleWithoutBorder:String = null;
        protected var m_LayoutMode:int = 0;
        private var m_UncommittedVisible:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        protected var m_StyleWithBorder:String = null;
        protected var m_LayoutProtected:Object = null;
        protected var m_Options:OptionsStorage = null;
        private var m_DropOffset:Number = NaN;
        protected var m_SideBarSet:SideBarSet = null;
        private var m_DropIndicatorSkipIndex:int = -1;
        private var m_ResizeWidget:WidgetView = null;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_LayoutWidth:Number = 0;
        private var m_UncommittedStyleWithBorder:Boolean = false;
        private var m_UIHeader:SideBarHeader = null;
        private var m_UncommittedStyleWithoutBorder:Boolean = false;
        private var m_CursorHelper:CursorHelper;
        private var m_ResizeUsedHeight:Number = NaN;
        private var m_UIDropIndicator:DisplayObject = null;
        private var m_ResizeStartPoint:Point;
        private var m_DropOffsetList:Array;
        private var m_ResizeStartHeight:Number = NaN;
        private var m_UncommittedLocation:Boolean = false;
        protected var m_Location:int = -1;
        protected var m_DropAvailableHeight:Number = NaN;
        private var m_UncommittedSideBarSet:Boolean = false;
        static const DRAG_OPACITY:Number = 0.75;
        static const DEFAULT_WIDGET_HEIGHT:Number = 200;
        static const DEFAULT_WIDGET_WIDTH:Number = 184;
        static const DRAG_TYPE_SPELL:String = "spell";
        static const DRAG_TYPE_CHANNEL:String = "channel";
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        static const DRAG_TYPE_ACTION:String = "action";
        static const DRAG_TYPE_OBJECT:String = "object";
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";

        public function SideBarWidget()
        {
            this.m_DropOffsetList = [];
            this.m_ResizeStartPoint = new Point(NaN, NaN);
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.HIGH);
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            addEventListener(DragEvent.DRAG_DROP, this.onWidgetDragEvent);
            addEventListener(DragEvent.DRAG_ENTER, this.onWidgetDragEvent);
            addEventListener(DragEvent.DRAG_EXIT, this.onWidgetDragEvent);
            addEventListener(DragEvent.DRAG_OVER, this.onWidgetDragEvent);
            return;
        }// end function

        private function onWidgetDragEvent(event:DragEvent) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = -1;
            var _loc_8:* = event.dragSource;
            _loc_2 = event.dragSource;
            var _loc_8:* = int(_loc_2.dataForFormat("widgetID"));
            _loc_3 = int(_loc_2.dataForFormat("widgetID"));
            if (event != null && _loc_8 != null && (_loc_2.hasFormat("dragType") && _loc_2.dataForFormat("dragType") == DRAG_TYPE_WIDGETBASE) && (_loc_2.hasFormat("widgetID") && _loc_8 > -1))
            {
                _loc_4 = null;
                _loc_5 = -1;
                switch(event.type)
                {
                    case DragEvent.DRAG_DROP:
                    {
                        _loc_5 = this.getDropIndex(event.localY);
                        _loc_6 = this.m_SideBarSet.getWidgetByType(Widget.TYPE_PREMIUM);
                        if (_loc_6 != null && Tibia.s_GetPremiumManager().freePlayerLimitations)
                        {
                            _loc_7 = this.m_SideBarSet.getSideBar(this.m_Location).getWidgetInstanceIndex(_loc_6);
                            _loc_5 = Math.max(_loc_5, (_loc_7 + 1));
                        }
                        if (this.m_DropIndicatorSkipIndex > -1 && _loc_5 > this.m_DropIndicatorSkipIndex)
                        {
                            _loc_5 = _loc_5 - 1;
                        }
                        this.m_SideBarSet.showWidgetByID(_loc_3, this.m_Location, _loc_5);
                    }
                    case DragEvent.DRAG_EXIT:
                    {
                        this.updateDropIndicator(false);
                        break;
                    }
                    case DragEvent.DRAG_ENTER:
                    {
                        _loc_4 = this.m_SideBarSet.getWidgetByID(_loc_3).acquireViewInstance(false);
                        _loc_5 = this.m_SideBarSet.getSideBar(this.m_Location).getWidgetIndexByID(_loc_3);
                        if (this.m_SideBarSet.getSideBar(this.m_Location).visible && this.hasEnoughSpace(_loc_4))
                        {
                            this.updateDropIndicator(true, _loc_5);
                            DragManager.acceptDragDrop(this);
                        }
                    }
                    case DragEvent.DRAG_OVER:
                    {
                        this.layoutDropIndicator(event.localY);
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

        private function onWidgetMouseResizeEvent(event:Event) : void
        {
            var _loc_2:* = NaN;
            if (event != null && this.m_ResizeWidget != null)
            {
                switch(event.type)
                {
                    case MouseEvent.MOUSE_MOVE:
                    {
                        _loc_2 = this.m_ResizeStartHeight + MouseEvent(event).stageY - this.m_ResizeStartPoint.y;
                        this.m_ResizeWidget.resizeWidgetAbsolute(_loc_2, false);
                        break;
                    }
                    case MouseEvent.MOUSE_UP:
                    case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                    {
                        this.finishMouseResize();
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

        function get sideBarSet() : SideBarSet
        {
            return this.m_SideBarSet;
        }// end function

        private function onWidgetDragInit(event:MouseEvent) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_5:* = event.currentTarget as WidgetView;
            _loc_2 = event.currentTarget as WidgetView;
            var _loc_5:* = _loc_2.widgetInstance;
            _loc_3 = _loc_2.widgetInstance;
            if (event != null && _loc_5 != null && _loc_5 != null)
            {
                switch(event.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                    {
                        if (_loc_2.hitTestDragHandle(event.stageX, event.stageY))
                        {
                            _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetDragInit);
                            _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.onWidgetDragInit);
                            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onWidgetDragInit);
                        }
                        break;
                    }
                    case MouseEvent.MOUSE_MOVE:
                    {
                        _loc_4 = new DragSource();
                        _loc_4.addData(DRAG_TYPE_WIDGETBASE, "dragType");
                        _loc_4.addData(_loc_3.ID, "widgetID");
                        DragManager.doDrag(_loc_2, _loc_4, event as MouseEvent);
                    }
                    case MouseEvent.MOUSE_UP:
                    case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                    {
                        _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetDragInit);
                        _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.onWidgetDragInit);
                        _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onWidgetDragInit);
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

        function set sideBarSet(param1:SideBarSet) : void
        {
            if (this.m_SideBarSet != param1)
            {
                if (this.m_SideBarSet != null)
                {
                    this.m_SideBarSet.getSideBar(this.m_Location).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarPropertyChange);
                    this.m_SideBarSet.getSideBar(this.m_Location).removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onWidgetViewAddRemove);
                }
                this.m_SideBarSet = param1;
                if (this.m_SideBarSet != null)
                {
                    this.m_SideBarSet.getSideBar(this.m_Location).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarPropertyChange);
                    this.m_SideBarSet.getSideBar(this.m_Location).addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onWidgetViewAddRemove);
                }
                this.m_UncommittedSideBarSet = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_7:* = NaN;
            layoutChrome(param1, unscaledHeight);
            var _loc_3:* = viewMetricsAndPadding;
            var _loc_4:* = Math.max(0, getStyle("verticalGap"));
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_7 = 0;
            var _loc_8:* = 0;
            var _loc_9:* = getStyle("paddingLeft");
            var _loc_10:* = 0;
            var _loc_11:* = param1 - _loc_3.left - _loc_3.right;
            if (this.m_UIHeader != null)
            {
                _loc_7 = this.m_UIHeader.getExplicitOrMeasuredHeight();
                _loc_8 = this.m_UIHeader.getExplicitOrMeasuredWidth();
                this.m_UIHeader.visible = visible;
                this.m_UIHeader.move(Math.round(_loc_3.left + (_loc_11 - _loc_8) / 2), 0);
                this.m_UIHeader.setActualSize(_loc_8, _loc_7);
                _loc_10 = _loc_7;
            }
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = param2 - _loc_10 - _loc_3.top - _loc_3.bottom;
            var _loc_15:* = -_loc_4;
            if (!visible)
            {
                this.m_LayoutMode = 0;
                this.m_LayoutWidth = 0;
                this.m_DropAvailableHeight = 0;
                _loc_12 = numChildren - 1;
                while (_loc_12 >= 0)
                {
                    
                    _loc_13 = getChildAt(_loc_12) as WidgetView;
                    _loc_13.visible = false;
                    _loc_12 = _loc_12 - 1;
                }
            }
            else if (this.m_LayoutMode == 1)
            {
                this.m_LayoutMode = 0;
                this.m_LayoutWidth = _loc_11;
                this.m_DropAvailableHeight = 0;
                _loc_6 = _loc_10 + _loc_3.top;
                this.m_DropOffsetList.length = 0;
                this.m_DropOffsetList[0] = _loc_6;
                this.m_DropAvailableHeight = _loc_14;
                _loc_12 = 0;
                while (_loc_12 < numChildren)
                {
                    
                    var _loc_16:* = getChildAt(_loc_12) as WidgetView;
                    _loc_13 = getChildAt(_loc_12) as WidgetView;
                    if (_loc_16 != null && !_loc_13.widgetClosed)
                    {
                        _loc_7 = _loc_13.widgetSuggestedHeight;
                        _loc_15 = _loc_15 + (_loc_7 + _loc_4);
                        if (_loc_15 <= _loc_14)
                        {
                            _loc_13.move(_loc_9, _loc_6);
                            _loc_13.setActualSize(_loc_11, _loc_7);
                            _loc_13.visible = true;
                            _loc_6 = _loc_6 + (_loc_7 + _loc_4);
                            this.m_DropOffsetList[(_loc_12 + 1)] = _loc_6;
                        }
                        else
                        {
                            _loc_13.widgetInstance.close(true);
                        }
                        this.m_DropAvailableHeight = this.m_DropAvailableHeight - (_loc_13.widgetRequiredHeight + _loc_4);
                    }
                    _loc_12++;
                }
            }
            else
            {
                this.m_LayoutMode = 0;
                this.m_LayoutWidth = _loc_11;
                this.m_DropAvailableHeight = _loc_14;
                _loc_12 = numChildren - 1;
                while (_loc_12 >= 0)
                {
                    
                    var _loc_16:* = getChildAt(_loc_12) as WidgetView;
                    _loc_13 = getChildAt(_loc_12) as WidgetView;
                    if (_loc_16 != null && !_loc_13.widgetClosed)
                    {
                        _loc_15 = _loc_15 + (_loc_13.widgetSuggestedHeight + _loc_4);
                    }
                    _loc_12 = _loc_12 - 1;
                }
                _loc_12 = numChildren;
                while (_loc_15 > _loc_14 && --_loc_12 >= 0)
                {
                    
                    var _loc_16:* = getChildAt(_loc_12) as WidgetView;
                    _loc_13 = getChildAt(_loc_12) as WidgetView;
                    if (_loc_16 != null && !_loc_13.widgetClosed)
                    {
                        if (_loc_13.widgetResizable)
                        {
                            _loc_15 = _loc_15 + _loc_13.resizeWidgetDelta(_loc_14 - _loc_15, this.m_ResizeWidget == null);
                        }
                        if (this.m_ResizeWidget == null && _loc_15 > _loc_14 && _loc_13.widgetClosable && !this.widgetIsProtected(_loc_13))
                        {
                            _loc_13.widgetInstance.close(true);
                            _loc_15 = _loc_15 - (_loc_13.widgetSuggestedHeight + _loc_4);
                        }
                    }
                }
                this.widgetSetProtected(null);
                --_loc_12 = numChildren;
                while (this.m_ResizeWidget != null && !isNaN(this.m_ResizeUsedHeight) && _loc_15 < this.m_ResizeUsedHeight && --_loc_12 >= 0)
                {
                    
                    _loc_13 = getChildAt(--_loc_12) as WidgetView;
                    if (_loc_13 == this.m_ResizeWidget)
                    {
                        break;
                    }
                    if (!_loc_13.widgetClosed && _loc_13.widgetResizable)
                    {
                        _loc_15 = _loc_15 + _loc_13.resizeWidgetDelta(this.m_ResizeUsedHeight - _loc_15, false);
                    }
                }
                this.m_ResizeUsedHeight = _loc_15;
                _loc_6 = _loc_10 + _loc_3.top;
                this.m_DropOffsetList.length = 0;
                this.m_DropOffsetList[0] = _loc_6;
                this.m_DropAvailableHeight = _loc_14 + _loc_4;
                --_loc_12 = 0;
                while (_loc_12 < numChildren)
                {
                    
                    var _loc_16:* = getChildAt(--_loc_12) as WidgetView;
                    _loc_13 = getChildAt(--_loc_12) as WidgetView;
                    if (_loc_16 != null)
                    {
                        _loc_7 = _loc_13.widgetSuggestedHeight;
                        _loc_13.move(_loc_9, _loc_6);
                        _loc_13.setActualSize(_loc_11, _loc_7);
                        _loc_13.visible = true;
                        _loc_6 = _loc_6 + (_loc_7 + _loc_4);
                        this.m_DropOffsetList[(_loc_12 + 1)] = _loc_6;
                        if (!_loc_13.widgetClosed)
                        {
                            this.m_DropAvailableHeight = this.m_DropAvailableHeight - (_loc_13.widgetRequiredHeight + _loc_4);
                        }
                    }
                    _loc_12++;
                }
            }
            this.layoutDropIndicator();
            return;
        }// end function

        private function updateDropIndicator(param1:Boolean, param2:int = -1) : void
        {
            var _loc_3:* = null;
            if (!param1 && this.m_UIDropIndicator != null)
            {
                rawChildren.removeChild(this.m_UIDropIndicator);
                this.m_UIDropIndicator = null;
                this.m_DropIndicatorSkipIndex = -1;
            }
            if (param1 && this.m_UIDropIndicator == null)
            {
                _loc_3 = getStyle("dropIndicatorSkin") as Class;
                if (_loc_3 != null)
                {
                    this.m_UIDropIndicator = DisplayObject(new _loc_3);
                    rawChildren.addChild(this.m_UIDropIndicator);
                }
                this.m_DropIndicatorSkipIndex = param2;
            }
            return;
        }// end function

        protected function onWidgetViewAddRemove(event:CollectionEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (event != null)
            {
                this.finishMouseResize();
                _loc_2 = null;
                if (event.items != null && event.items.length == 1)
                {
                    _loc_2 = Widget(event.items[0]);
                }
                _loc_3 = null;
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        var _loc_5:* = _loc_2.acquireViewInstance(true);
                        _loc_3 = _loc_2.acquireViewInstance(true);
                        if (_loc_2 != null && _loc_5 != null)
                        {
                            _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetDragInit);
                            _loc_3.addEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                            _loc_3.addEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                            _loc_3.addEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                            _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetMouseResizeInit);
                            _loc_3.invalidateWidgetInstance();
                            addChildAt(_loc_3, event.location);
                            this.widgetSetProtected(_loc_3);
                        }
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        _loc_4 = removeChildAt(event.location);
                        _loc_4.removeEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetDragInit);
                        _loc_4.removeEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                        _loc_4.removeEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                        _loc_4.removeEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                        _loc_4.removeEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetMouseResizeInit);
                        break;
                    }
                    case CollectionEventKind.MOVE:
                    {
                        var _loc_5:* = _loc_2.acquireViewInstance(false);
                        _loc_3 = _loc_2.acquireViewInstance(false);
                        if (_loc_2 != null && _loc_5 != null)
                        {
                            _loc_3.invalidateWidgetInstance();
                            setChildIndex(_loc_3, event.location);
                            this.widgetSetProtected(_loc_3);
                        }
                        break;
                    }
                    default:
                    {
                        this.resetWidgets();
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.resetHeader();
                this.resetWidgets();
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function onSideBarPropertyChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property as String)
                {
                    case "visible":
                    {
                        this.visible = this.m_SideBarSet.getSideBar(this.m_Location).visible;
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

        private function finishMouseResize() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this.m_ResizeWidget != null)
            {
                _loc_1 = 0;
                _loc_2 = numChildren;
                if (contains(this.m_ResizeWidget))
                {
                    _loc_1 = getChildIndex(this.m_ResizeWidget);
                }
                while (_loc_1 < _loc_2)
                {
                    
                    _loc_3 = getChildAt(_loc_1) as WidgetView;
                    if (_loc_3 != null && !_loc_3.widgetClosed && (!_loc_3.widgetCollapsible || !_loc_3.widgetCollapsed) && _loc_3.widgetResizable)
                    {
                        _loc_3.resizeWidgetAbsolute(_loc_3.widgetSuggestedHeight, true);
                    }
                    _loc_1++;
                }
                if (this.m_ResizeWidget != null)
                {
                    this.m_ResizeWidget.addEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                    this.m_ResizeWidget.addEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                    this.m_ResizeWidget.addEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                }
            }
            systemManager.removeEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeEvent);
            systemManager.removeEventListener(MouseEvent.MOUSE_UP, this.onWidgetMouseResizeEvent);
            systemManager.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onWidgetMouseResizeEvent);
            this.m_ResizeWidget = null;
            this.m_ResizeStartHeight = NaN;
            this.m_ResizeStartPoint.x = NaN;
            this.m_ResizeStartPoint.y = NaN;
            this.updateMouseResizeCursor(false);
            return;
        }// end function

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        public function get styleWithBorder() : String
        {
            return this.m_StyleWithBorder;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_UncommittedOptions = true;
                invalidateProperties();
                this.updateSideBarSet();
            }
            return;
        }// end function

        private function updateSiblingStyleNames() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (parent != null)
            {
                _loc_1 = parent.numChildren;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = parent.getChildAt(_loc_2);
                    if (_loc_3 is SideBarWidget)
                    {
                        SideBarWidget(_loc_3).updateOwnStyleName();
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        protected function widgetIsProtected(param1) : Boolean
        {
            if (param1 is Widget)
            {
                return (param1 as Widget).acquireViewInstance() == this.m_LayoutProtected;
            }
            if (param1 is WidgetView)
            {
                return param1 as WidgetView == this.m_LayoutProtected;
            }
            return false;
        }// end function

        protected function resetHeader() : void
        {
            if (this.m_UIHeader != null)
            {
                this.m_UIHeader.sideBarSet = null;
                this.m_UIHeader.location = -1;
                rawChildren.removeChild(this.m_UIHeader as DisplayObject);
            }
            this.m_UIHeader = new SideBarHeader();
            this.m_UIHeader.sideBarSet = this.m_SideBarSet;
            this.m_UIHeader.location = this.m_Location;
            rawChildren.addChild(this.m_UIHeader as DisplayObject);
            return;
        }// end function

        private function updateSideBarSet() : void
        {
            if (this.m_Options != null)
            {
                this.sideBarSet = this.m_Options.getSideBarSet(SideBarSet.DEFAULT_SET);
            }
            else
            {
                this.sideBarSet = null;
            }
            return;
        }// end function

        private function updateMouseResizeCursor(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = getStyle("resizeCursorSkin");
                if (!DragManager.isDragging)
                {
                    this.m_CursorHelper.setCursor(_loc_2);
                }
            }
            else
            {
                this.m_CursorHelper.resetCursor();
            }
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "sideBarSet":
                    case "*":
                    {
                        this.updateSideBarSet();
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

        protected function widgetSetProtected(param1) : void
        {
            if (param1 is Widget)
            {
                this.m_LayoutProtected = (param1 as Widget).acquireViewInstance();
            }
            else if (param1 is WidgetView)
            {
                this.m_LayoutProtected = param1 as WidgetView;
            }
            else
            {
                this.m_LayoutProtected = null;
            }
            return;
        }// end function

        public function set styleWithBorder(param1:String) : void
        {
            if (this.m_StyleWithBorder != param1)
            {
                this.m_StyleWithBorder = param1;
                this.m_UncommittedStyleWithBorder = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function layoutDropIndicator(param1:Number = NaN) : void
        {
            var _loc_2:* = 0;
            if (!isNaN(param1))
            {
                this.m_DropOffset = param1;
            }
            if (this.m_UIDropIndicator != null)
            {
                _loc_2 = this.getDropIndex(this.m_DropOffset);
                this.m_UIDropIndicator.x = (this.m_LayoutWidth - this.m_UIDropIndicator.width) / 2;
                this.m_UIDropIndicator.y = this.m_DropOffsetList[_loc_2] - (getStyle("verticalGap") + this.m_UIDropIndicator.height) / 2;
                rawChildren.setChildIndex(this.m_UIDropIndicator as DisplayObject, (rawChildren.numChildren - 1));
            }
            return;
        }// end function

        private function updateOwnStyleName() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (styleName != null && styleName != this.m_StyleWithBorder && styleName != this.m_StyleWithoutBorder)
            {
                return;
            }
            var _loc_1:* = false;
            if (parent != null)
            {
                _loc_2 = parent.getChildIndex(this);
                _loc_3 = parent.numChildren;
                for each (_loc_4 in [-1, 1])
                {
                    
                    _loc_5 = _loc_2 + _loc_4;
                    if (_loc_5 >= 0 && _loc_5 < _loc_3 && parent.getChildAt(_loc_5) is SideBarWidget && parent.getChildAt(_loc_5).visible)
                    {
                        _loc_1 = true;
                        break;
                    }
                }
            }
            if (_loc_1)
            {
                styleName = this.m_StyleWithBorder;
            }
            else
            {
                styleName = this.m_StyleWithoutBorder;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_4:* = null;
            super.measure();
            var _loc_1:* = this.m_UIHeader != null ? (this.m_UIHeader.getExplicitOrMeasuredWidth()) : (0);
            var _loc_2:* = numChildren - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_4 = getChildAt(_loc_2) as UIComponent;
                if (_loc_4 != null)
                {
                    _loc_1 = Math.max(_loc_1, _loc_4.getExplicitOrMeasuredWidth());
                }
                _loc_2 = _loc_2 - 1;
            }
            _loc_1 = Math.max(_loc_1, DEFAULT_WIDGET_WIDTH);
            var _loc_3:* = viewMetricsAndPadding;
            var _loc_5:* = _loc_3.left + _loc_1 + _loc_3.right;
            measuredWidth = _loc_3.left + _loc_1 + _loc_3.right;
            measuredMinWidth = _loc_5;
            return;
        }// end function

        public function set styleWithoutBorder(param1:String) : void
        {
            if (this.m_StyleWithoutBorder != param1)
            {
                this.m_StyleWithoutBorder = param1;
                this.m_UncommittedStyleWithoutBorder = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set location(param1:int) : void
        {
            if (this.m_Location != param1)
            {
                this.m_Location = param1;
                this.m_UncommittedLocation = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            this.m_UncommittedVisible = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedSideBarSet)
            {
                this.m_LayoutMode = 1;
                this.finishMouseResize();
                if (this.m_UIHeader != null)
                {
                    this.m_UIHeader.sideBarSet = this.m_SideBarSet;
                }
                this.resetWidgets();
                this.visible = this.m_SideBarSet != null && this.m_SideBarSet.getSideBar(this.m_Location).visible;
                this.m_UncommittedSideBarSet = false;
            }
            if (this.m_UncommittedLocation)
            {
                this.m_LayoutMode = 1;
                this.finishMouseResize();
                if (this.m_UIHeader != null)
                {
                    this.m_UIHeader.location = this.m_Location;
                }
                this.m_UncommittedLocation = false;
            }
            if (this.m_UncommittedOptions)
            {
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedVisible)
            {
                includeInLayout = visible;
                this.updateSiblingStyleNames();
                this.m_UncommittedVisible = false;
            }
            if (this.m_UncommittedStyleWithBorder || this.m_UncommittedStyleWithoutBorder)
            {
                this.updateSiblingStyleNames();
                this.m_UncommittedStyleWithBorder = false;
                this.m_UncommittedStyleWithoutBorder = false;
            }
            return;
        }// end function

        private function getDropIndex(param1:Number) : int
        {
            var _loc_2:* = this.m_DropOffsetList.length;
            if (this.m_DropOffsetList.length < 2 || param1 <= this.m_DropOffsetList[0])
            {
                return 0;
            }
            if (param1 >= this.m_DropOffsetList[(_loc_2 - 1)])
            {
                return (_loc_2 - 1);
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = -1;
            var _loc_7:* = 0;
            while (_loc_7 < (_loc_2 - 1))
            {
                
                _loc_3 = this.m_DropOffsetList[_loc_7];
                _loc_4 = this.m_DropOffsetList[(_loc_7 + 1)];
                _loc_5 = (_loc_3 + _loc_4) / 2;
                if (_loc_3 <= param1 && param1 < _loc_5)
                {
                    _loc_6 = _loc_7;
                    break;
                }
                if (_loc_5 <= param1 && param1 < _loc_4)
                {
                    _loc_6 = _loc_7 + 1;
                    break;
                }
                _loc_7++;
            }
            if (this.m_DropIndicatorSkipIndex > -1 && _loc_6 == (this.m_DropIndicatorSkipIndex + 1))
            {
                _loc_6 = _loc_6 - 1;
            }
            return _loc_6;
        }// end function

        public function get styleWithoutBorder() : String
        {
            return this.m_StyleWithoutBorder;
        }// end function

        private function onWidgetMouseResizeInit(event:MouseEvent) : void
        {
            var _loc_3:* = false;
            var _loc_2:* = null;
            var _loc_4:* = event.currentTarget as WidgetView;
            _loc_2 = event.currentTarget as WidgetView;
            if (event != null && this.m_ResizeWidget == null && _loc_4 != null)
            {
                _loc_3 = !DragManager.isDragging && !_loc_2.widgetClosed && _loc_2.widgetResizable && _loc_2.hitTestResizeHandle(event.stageX, event.stageY);
                switch(event.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                    {
                        if (_loc_3)
                        {
                            this.m_ResizeWidget = _loc_2;
                            this.m_ResizeStartHeight = _loc_2.widgetSuggestedHeight;
                            this.m_ResizeStartPoint.x = event.stageX;
                            this.m_ResizeStartPoint.y = event.stageY;
                            this.m_ResizeWidget.removeEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                            this.m_ResizeWidget.removeEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                            this.m_ResizeWidget.removeEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                            systemManager.addEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeEvent);
                            systemManager.addEventListener(MouseEvent.MOUSE_UP, this.onWidgetMouseResizeEvent);
                            systemManager.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onWidgetMouseResizeEvent);
                            this.updateMouseResizeCursor(true);
                        }
                        break;
                    }
                    case MouseEvent.MOUSE_MOVE:
                    case MouseEvent.MOUSE_OVER:
                    {
                        this.updateMouseResizeCursor(_loc_3);
                        break;
                    }
                    case MouseEvent.MOUSE_OUT:
                    {
                        this.updateMouseResizeCursor(false);
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

        public function resetWidgets() : void
        {
            var _loc_5:* = false;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = new Vector.<WidgetViewWithIndex>;
            var _loc_4:* = numChildren - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_1 = null;
                _loc_2 = removeChildAt(_loc_4) as WidgetView;
                _loc_5 = !(_loc_2 != null && _loc_2.widgetInstance != null && !Widget.s_GetRestorable(_loc_2.widgetInstance.type));
                if (!_loc_5)
                {
                    _loc_6 = new WidgetViewWithIndex(_loc_2, _loc_4);
                    _loc_3.push(_loc_6);
                }
                else if (_loc_2 != null && _loc_5)
                {
                    _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetDragInit);
                    _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                    _loc_2.removeEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                    _loc_2.removeEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                    _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetMouseResizeInit);
                    _loc_1 = _loc_2.widgetInstance;
                }
                if (_loc_1 != null && _loc_5)
                {
                    _loc_1.releaseViewInstance();
                }
                _loc_4 = _loc_4 - 1;
            }
            if (this.m_SideBarSet != null)
            {
                _loc_7 = this.m_SideBarSet.getSideBar(this.m_Location);
                _loc_8 = 0;
                _loc_9 = _loc_7.length;
                while (_loc_8 < _loc_9)
                {
                    
                    _loc_2 = _loc_7.getWidgetInstanceAt(_loc_8).acquireViewInstance(true);
                    _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetDragInit);
                    _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.onWidgetMouseResizeInit);
                    _loc_2.addEventListener(MouseEvent.MOUSE_OVER, this.onWidgetMouseResizeInit);
                    _loc_2.addEventListener(MouseEvent.MOUSE_OUT, this.onWidgetMouseResizeInit);
                    _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onWidgetMouseResizeInit);
                    _loc_2.invalidateWidgetInstance();
                    addChild(_loc_2);
                    _loc_8++;
                }
            }
            _loc_4 = _loc_3.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_6 = _loc_3[_loc_4];
                if (_loc_6.Index >= 0 && _loc_6.Index < numChildren)
                {
                    addChildAt(_loc_6.WidgetViewObj, _loc_6.Index);
                }
                else
                {
                    addChild(_loc_6.WidgetViewObj);
                }
                this.m_SideBarSet.insertOrphanWidget(_loc_6.WidgetViewObj.widgetInstance, this.m_Location, _loc_6.Index);
                _loc_4 = _loc_4 - 1;
            }
            this.widgetSetProtected(null);
            return;
        }// end function

        private function hasEnoughSpace(param1:IUIComponent) : Boolean
        {
            if (param1 == null)
            {
                return false;
            }
            var _loc_2:* = param1.measuredMinHeight;
            return contains(param1 as DisplayObject) || !isNaN(this.m_DropAvailableHeight) && !isNaN(_loc_2) && _loc_2 <= this.m_DropAvailableHeight;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            if (mx_internal::border is IBorder)
            {
                return IBorder(mx_internal::border).borderMetrics;
            }
            return super.borderMetrics;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import mx.core.*;

import mx.events.*;

import mx.managers.*;

import tibia.cursors.*;

import tibia.options.*;

import tibia.sidebar.sideBarWidgetClasses.*;

class WidgetViewWithIndex extends Object
{
    public var Index:int;
    public var WidgetViewObj:WidgetView;

    function WidgetViewWithIndex(param1:WidgetView, param2:int)
    {
        this.WidgetViewObj = param1;
        this.Index = param2;
        return;
    }// end function

}

