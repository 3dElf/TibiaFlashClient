package tibia.controls
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.controls.dynamicTabBarClasses.*;
    import tibia.input.*;

    public class DynamicTabBar extends UIComponent
    {
        protected var m_UIDropDownButton:Button = null;
        protected var m_ScrollPolicy:String = "auto";
        private var m_UncommittedScrollPolicy:Boolean = false;
        private var m_UncommittedDropDownPolicy:Boolean = false;
        protected var m_TabResize:Boolean = false;
        protected var m_ScrollPosition:int = 0;
        private var m_UIConstructed:Boolean = false;
        protected var m_TabMinWidth:Number = NaN;
        protected var m_ClosePolicy:int = 2;
        private var m_UncommittedLabelFunction:Boolean = false;
        private var m_UncommittedLabelField:Boolean = false;
        protected var m_UILeftButton:Button = null;
        private var m_UncommittedDataProvider:Boolean = false;
        private var m_UncommittedSelectedIndex:Boolean = false;
        protected var m_DataProvider:Object = null;
        private var m_UncommittedTabMinWidth:Boolean = false;
        private var m_UncommittedClosePolicy:Boolean = false;
        protected var m_DragEnabled:Boolean = false;
        protected var m_LabelFunction:Function = null;
        protected var m_DragAutoScrollTimer:Timer = null;
        protected var m_SelectedIndex:int = -1;
        private var m_NavItemFactory:ClassFactory = null;
        private var m_UncommittedScrollPosition:Boolean = false;
        private var m_UncommittedToolTipField:Boolean = false;
        protected var m_ToolTipField:String = "toolTip";
        protected var m_TabMaxWidth:Number = NaN;
        protected var m_IconField:String = "icon";
        private var m_UncommittedTabResize:Boolean = false;
        private var m_UncommittedDragEnabled:Boolean = false;
        protected var m_LabelField:String = "label";
        protected var m_UIInternalChildren:int = 0;
        private var m_UncommittedTabMaxWidth:Boolean = false;
        protected var m_DragAutoScrollDirection:int = -1;
        private var m_UncommittedNavItemFactory:Boolean = false;
        private var m_FirstVisibleIndex:int = 0;
        protected var m_UIDropIndicator:DisplayObject = null;
        protected var m_UIRightButton:Button = null;
        private var m_LastVisibleIndex:int = 0;
        protected var m_DropDownPolicy:int = 0;
        protected var m_UIDropDownMenu:Menu = null;
        private var m_UncommittedIconField:Boolean = false;
        public static const DROP_DOWN_OFF:int = 1;
        public static const CLOSE_NEVER:int = 0;
        public static const CLOSE_SELECTED:int = 2;
        public static const DROP_DOWN_ON:int = 2;
        public static const CLOSE_ALWAYS:int = 1;
        public static const CLOSE_ROLLOVER:int = 3;
        public static const DROP_DOWN_AUTO:int = 0;

        public function DynamicTabBar()
        {
            addEventListener(DragEvent.DRAG_DROP, this.onNavItemDragEvent);
            addEventListener(DragEvent.DRAG_ENTER, this.onNavItemDragEvent);
            addEventListener(DragEvent.DRAG_EXIT, this.onNavItemDragEvent);
            addEventListener(DragEvent.DRAG_OVER, this.onNavItemDragEvent);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.onScrollWheel);
            this.navItemFactory = new ClassFactory(DynamicTab);
            this.m_DragAutoScrollTimer = new Timer(500);
            this.m_DragAutoScrollTimer.addEventListener(TimerEvent.TIMER, this.onScrollDrag);
            this.m_DragAutoScrollDirection = 0;
            return;
        }// end function

        public function get iconField() : String
        {
            return this.m_IconField;
        }// end function

        public function set iconField(param1:String) : void
        {
            if (this.m_IconField != param1)
            {
                this.m_IconField = param1;
                this.m_UncommittedIconField = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function itemToToolTip(param1:Object) : String
        {
            if (param1 is Container)
            {
                return Container(param1).toolTip;
            }
            if (param1 != null && this.m_ToolTipField != null && param1.hasOwnProperty(this.m_ToolTipField))
            {
                return String(param1[this.m_ToolTipField]);
            }
            return null;
        }// end function

        public function get scrollPosition() : int
        {
            return this.m_ScrollPosition;
        }// end function

        public function set tabMaxWidth(param1:Number) : void
        {
            if (this.m_TabMaxWidth != param1)
            {
                this.m_TabMaxWidth = param1;
                this.m_UncommittedTabMaxWidth = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILeftButton = new CustomButton();
                this.m_UILeftButton.styleName = getStyle("scrollLeftButtonStyle");
                this.m_UILeftButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onScrollButtonDown);
                this.m_UILeftButton.addEventListener(MouseEvent.CLICK, this.onScrollButtonClick);
                this.m_UILeftButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onScrollButtonClick);
                this.m_UILeftButton.setStyle("repeatDelay", 500);
                addChild(this.m_UILeftButton);
                var _loc_1:* = this;
                var _loc_2:* = this.m_UIInternalChildren + 1;
                _loc_1.m_UIInternalChildren = _loc_2;
                this.m_UIRightButton = new CustomButton();
                this.m_UIRightButton.styleName = getStyle("scrollRightButtonStyle");
                this.m_UIRightButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onScrollButtonDown);
                this.m_UIRightButton.addEventListener(MouseEvent.CLICK, this.onScrollButtonClick);
                this.m_UIRightButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onScrollButtonClick);
                this.m_UIRightButton.setStyle("repeatDelay", 500);
                addChild(this.m_UIRightButton);
                var _loc_1:* = this;
                var _loc_2:* = this.m_UIInternalChildren + 1;
                _loc_1.m_UIInternalChildren = _loc_2;
                this.m_UIDropDownButton = new CustomButton();
                this.m_UIDropDownButton.styleName = getStyle("dropDownButtonStyle");
                this.m_UIDropDownButton.addEventListener(MouseEvent.CLICK, this.onDropDownButton);
                addChild(this.m_UIDropDownButton);
                var _loc_1:* = this;
                var _loc_2:* = this.m_UIInternalChildren + 1;
                _loc_1.m_UIInternalChildren = _loc_2;
                this.createDropIndicator();
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set scrollPosition(param1:int) : void
        {
            param1 = Math.max(0, Math.min(param1, (this.getDataProviderLength() - 1)));
            if (this.m_ScrollPosition != param1)
            {
                this.m_ScrollPosition = param1;
                this.m_UncommittedScrollPosition = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        protected function onScrollWheel(event:MouseEvent) : void
        {
            this.scrollPosition = this.scrollPosition + (-event.delta) / Math.abs(event.delta) * (event.shiftKey ? (10) : (1));
            return;
        }// end function

        protected function createNavItem(param1:Object) : DynamicTab
        {
            var _loc_2:* = DynamicTab(this.m_NavItemFactory.newInstance());
            _loc_2.closePolicy = this.m_ClosePolicy;
            _loc_2.enabled = this.itemToEnabled(param1);
            _loc_2.focusEnabled = false;
            _loc_2.label = this.itemToLabel(param1);
            _loc_2.styleName = getStyle("navItemStyle");
            _loc_2.toggle = true;
            _loc_2.toolTip = this.itemToToolTip(param1);
            _loc_2.addEventListener(Event.CLOSE, this.onNavItemClose);
            _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onNavItemSelect);
            _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onNavItemDragInit);
            _loc_2.setStyle("icon", this.itemToIcon(param1));
            addChildAt(_loc_2, numChildren - this.m_UIInternalChildren);
            return _loc_2;
        }// end function

        protected function onNavItemClose(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (event != null)
            {
                _loc_2 = DynamicTab(event.currentTarget);
                _loc_3 = getChildIndex(_loc_2);
                _loc_4 = new TabBarEvent(TabBarEvent.CLOSE);
                _loc_4.index = _loc_3;
                dispatchEvent(_loc_4);
                if (!_loc_4.cancelable || !_loc_4.isDefaultPrevented())
                {
                    _loc_5 = -1;
                    if (_loc_3 < this.m_SelectedIndex)
                    {
                        _loc_5 = this.m_SelectedIndex - 1;
                    }
                    else if (_loc_3 == this.m_SelectedIndex)
                    {
                        _loc_5 = Math.min(this.m_SelectedIndex, this.getDataProviderLength() - 2);
                    }
                    else
                    {
                        _loc_5 = this.m_SelectedIndex;
                    }
                    if (this.m_DataProvider is IList)
                    {
                        IList(this.m_DataProvider).removeItemAt(_loc_3);
                    }
                    else if (this.m_DataProvider is ViewStack)
                    {
                        ViewStack(this.m_DataProvider).removeChildAt(_loc_3);
                    }
                    this.selectedIndex = _loc_5;
                }
                else
                {
                    event.preventDefault();
                }
            }
            return;
        }// end function

        protected function onStackSelectionChange(event:Event) : void
        {
            if (event != null)
            {
                this.selectedIndex = ViewStack(this.m_DataProvider).selectedIndex;
            }
            return;
        }// end function

        protected function onStackChildChange(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null)
            {
                _loc_2 = Container(event.target);
                _loc_3 = ViewStack(this.m_DataProvider).getChildIndex(_loc_2);
                _loc_4 = DynamicTab(getChildAt(_loc_3));
                switch(event.type)
                {
                    case "enabledChanged":
                    {
                        _loc_4.enabled = _loc_2.enabled;
                        break;
                    }
                    case "iconChanged":
                    {
                        _loc_4.setStyle("icon", _loc_2.icon);
                        break;
                    }
                    case "labelChanged":
                    {
                        _loc_4.label = _loc_2.label;
                        break;
                    }
                    case "toolTipChanged":
                    {
                        _loc_4.toolTip = _loc_2.toolTip;
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

        public function get tabMinWidth() : Number
        {
            return this.m_TabMinWidth;
        }// end function

        public function get closePolicy() : int
        {
            return this.m_ClosePolicy;
        }// end function

        private function createDropIndicator() : void
        {
            if (this.m_UIDropIndicator != null && contains(this.m_UIDropIndicator))
            {
                removeChild(this.m_UIDropIndicator);
                var _loc_2:* = this;
                var _loc_3:* = this.m_UIInternalChildren - 1;
                _loc_2.m_UIInternalChildren = _loc_3;
            }
            this.m_UIDropIndicator = null;
            var _loc_1:* = getStyle("dropIndicatorSkin") as Class;
            if (_loc_1 != null)
            {
                this.m_UIDropIndicator = DisplayObject(new _loc_1);
                this.m_UIDropIndicator.visible = false;
                addChild(this.m_UIDropIndicator);
                var _loc_2:* = this;
                var _loc_3:* = this.m_UIInternalChildren + 1;
                _loc_2.m_UIInternalChildren = _loc_3;
            }
            return;
        }// end function

        protected function onScrollButtonClick(event:MouseEvent) : void
        {
            if (event.currentTarget == this.m_UILeftButton)
            {
                this.scrollPosition = this.scrollPosition - (event.shiftKey ? (10) : (1));
            }
            else if (event.currentTarget == this.m_UIRightButton)
            {
                this.scrollPosition = this.scrollPosition + (event.shiftKey ? (10) : (1));
            }
            return;
        }// end function

        protected function createDropDownMenu() : IList
        {
            var _loc_4:* = null;
            var _loc_1:* = new ArrayCollection();
            var _loc_2:* = 0;
            var _loc_3:* = this.getDataProviderLength();
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = DynamicTab(getChildAt(_loc_2));
                _loc_1.addItem({label:_loc_4.label});
                _loc_2++;
            }
            return _loc_1;
        }// end function

        protected function get navItemFactory() : ClassFactory
        {
            return this.m_NavItemFactory;
        }// end function

        public function set tabResize(param1:Boolean) : void
        {
            if (this.m_TabResize != param1)
            {
                this.m_TabResize = param1;
                this.m_UncommittedTabResize = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function destroyDropDownMenu() : void
        {
            if (this.m_UIDropDownMenu != null)
            {
                this.m_UIDropDownMenu.hide();
                this.m_UIDropDownMenu.removeEventListener(MenuEvent.ITEM_CLICK, this.onDropDownMenu);
                this.m_UIDropDownMenu = null;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            super.measure();
            var _loc_1:* = getStyle("paddingLeft") + getStyle("paddingRight");
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.m_ScrollPolicy != ScrollPolicy.OFF)
            {
                _loc_1 = _loc_1 + (this.m_UILeftButton.getExplicitOrMeasuredWidth() + this.m_UIRightButton.getExplicitOrMeasuredWidth());
                _loc_2 = Math.max(_loc_2, this.m_UILeftButton.getExplicitOrMeasuredHeight(), this.m_UIRightButton.getExplicitOrMeasuredHeight());
            }
            if (this.m_DropDownPolicy != DROP_DOWN_OFF)
            {
                _loc_1 = _loc_1 + this.m_UIDropDownButton.getExplicitOrMeasuredWidth();
                _loc_2 = Math.max(_loc_2, this.m_UIDropDownButton.getExplicitOrMeasuredHeight());
            }
            var _loc_6:* = 0;
            var _loc_7:* = numChildren - this.m_UIInternalChildren;
            _loc_6 = 0;
            while (_loc_6 < _loc_7)
            {
                
                _loc_8 = DynamicTab(getChildAt(_loc_6));
                _loc_9 = 0;
                _loc_10 = _loc_8.getExplicitOrMeasuredWidth();
                if (this.m_TabResize && !isNaN(this.m_TabMinWidth))
                {
                    _loc_9 = this.m_TabMinWidth;
                }
                else if (!isNaN(_loc_8.minWidth))
                {
                    _loc_9 = _loc_8.minWidth;
                }
                else
                {
                    _loc_9 = _loc_10;
                }
                if (this.m_TabResize && !isNaN(this.m_TabMaxWidth))
                {
                    _loc_10 = Math.min(_loc_10, this.m_TabMaxWidth);
                }
                _loc_4 = Math.max(_loc_4, _loc_9);
                _loc_3 = _loc_3 + Math.max(_loc_9, _loc_10);
                _loc_5 = Math.max(_loc_5, _loc_8.getExplicitOrMeasuredHeight());
                _loc_6++;
            }
            if (_loc_7 > 1)
            {
                _loc_3 = _loc_3 + (_loc_7 - 1) * getStyle("horizontalGap");
            }
            measuredWidth = _loc_1 + _loc_3;
            measuredMinWidth = _loc_1 + _loc_4;
            var _loc_11:* = Math.max(_loc_2, _loc_5) + getStyle("paddingTop") + getStyle("paddingBottom");
            measuredMinHeight = Math.max(_loc_2, _loc_5) + getStyle("paddingTop") + getStyle("paddingBottom");
            measuredHeight = _loc_11;
            return;
        }// end function

        public function get scrollPolicy() : String
        {
            return this.m_ScrollPolicy;
        }// end function

        private function itemToEnabled(param1:Object) : Boolean
        {
            if (param1 is Container)
            {
                return Container(param1).enabled;
            }
            return true;
        }// end function

        public function get labelField() : String
        {
            return this.m_LabelField;
        }// end function

        public function set dataProvider(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this.m_DataProvider != param1)
            {
                _loc_2 = null;
                _loc_3 = null;
                _loc_4 = null;
                _loc_5 = 0;
                if (this.m_DataProvider is IList)
                {
                    _loc_2 = IList(this.m_DataProvider);
                    _loc_2.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onIListChange);
                }
                else if (this.m_DataProvider is ViewStack)
                {
                    _loc_3 = ViewStack(this.m_DataProvider);
                    _loc_3.removeEventListener(ChildExistenceChangedEvent.CHILD_ADD, this.onStackChange);
                    _loc_3.removeEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, this.onStackChange);
                    _loc_3.removeEventListener(Event.CHANGE, this.onStackSelectionChange);
                    _loc_3.removeEventListener(IndexChangedEvent.CHILD_INDEX_CHANGE, this.onStackChange);
                    _loc_5 = _loc_3.numChildren - 1;
                    while (_loc_5 >= 0)
                    {
                        
                        _loc_4 = Container(_loc_3.getChildAt(_loc_5));
                        _loc_4.removeEventListener("enabledChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("iconChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("labelChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("toolTipChanged", this.onStackChildChange);
                        _loc_5 = _loc_5 - 1;
                    }
                }
                if (param1 == null)
                {
                    this.m_DataProvider = null;
                }
                else if (param1 is Array)
                {
                    this.m_DataProvider = new ArrayCollection(param1 as Array);
                }
                else if (param1 is IList)
                {
                    this.m_DataProvider = param1;
                }
                else if (param1 is ViewStack)
                {
                    this.m_DataProvider = param1;
                }
                else
                {
                    throw new ArgumentError("DynamicTabBar.set dataProvider: Invalid data provider.");
                }
                if (this.m_DataProvider is IList)
                {
                    _loc_2 = IList(this.m_DataProvider);
                    _loc_2.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onIListChange);
                }
                else if (this.m_DataProvider is ViewStack)
                {
                    _loc_3 = ViewStack(this.m_DataProvider);
                    _loc_3.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, this.onStackChange);
                    _loc_3.addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, this.onStackChange);
                    _loc_3.addEventListener(Event.CHANGE, this.onStackSelectionChange);
                    _loc_3.addEventListener(IndexChangedEvent.CHILD_INDEX_CHANGE, this.onStackChange);
                    _loc_5 = _loc_3.numChildren - 1;
                    while (_loc_5 >= 0)
                    {
                        
                        _loc_4 = Container(_loc_3.getChildAt(_loc_5));
                        _loc_4.addEventListener("enabledChanged", this.onStackChildChange);
                        _loc_4.addEventListener("iconChanged", this.onStackChildChange);
                        _loc_4.addEventListener("labelChanged", this.onStackChildChange);
                        _loc_4.addEventListener("toolTipChanged", this.onStackChildChange);
                        _loc_5 = _loc_5 - 1;
                    }
                }
                this.m_UncommittedDataProvider = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get tabMaxWidth() : Number
        {
            return this.m_TabMaxWidth;
        }// end function

        public function get dragEnabled() : Boolean
        {
            return this.m_DragEnabled;
        }// end function

        protected function getDataProviderLength() : int
        {
            if (this.m_DataProvider is IList)
            {
                return IList(this.m_DataProvider).length;
            }
            if (this.m_DataProvider is ViewStack)
            {
                return ViewStack(this.m_DataProvider).numChildren;
            }
            return 0;
        }// end function

        protected function selectNavItems() : void
        {
            var _loc_1:* = numChildren - this.m_UIInternalChildren - 1;
            while (_loc_1 >= 0)
            {
                
                DynamicTab(getChildAt(_loc_1)).selected = _loc_1 == this.m_SelectedIndex;
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        protected function onNavItemDragInit(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null && this.m_DragEnabled)
            {
                _loc_2 = DynamicTab(event.currentTarget);
                _loc_3 = getChildIndex(_loc_2);
                switch(event.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                    {
                        _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.onNavItemDragInit, false, EventPriority.DEFAULT, true);
                        _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.onNavItemDragInit, false, EventPriority.DEFAULT, true);
                        _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onNavItemDragInit, false, EventPriority.DEFAULT, true);
                        break;
                    }
                    case MouseEvent.MOUSE_MOVE:
                    {
                        _loc_4 = new DragSource();
                        _loc_4.addData("dynamicTab", "dragType");
                        _loc_4.addData(this, "dragTabBar");
                        _loc_4.addData(_loc_3, "dragTabIndex");
                        DragManager.doDrag(_loc_2, _loc_4, event as MouseEvent);
                    }
                    case MouseEvent.MOUSE_UP:
                    {
                        _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.onNavItemDragInit);
                        _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.onNavItemDragInit);
                        _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onNavItemDragInit);
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

        protected function destroyNavItem(param1:int) : DynamicTab
        {
            var _loc_2:* = null;
            if (param1 >= 0 && param1 < numChildren - this.m_UIInternalChildren)
            {
                _loc_2 = DynamicTab(removeChildAt(param1));
                _loc_2.removeEventListener(Event.CLOSE, this.onNavItemClose);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onNavItemSelect);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onNavItemDragInit);
            }
            return _loc_2;
        }// end function

        public function set dropDownPolicy(param1:int) : void
        {
            if (this.m_DropDownPolicy != param1)
            {
                this.m_DropDownPolicy = param1;
                this.m_UncommittedDropDownPolicy = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function itemToIcon(param1:Object) : Class
        {
            if (param1 is Container)
            {
                return Container(param1).icon;
            }
            if (param1 != null && this.m_IconField != null && param1.hasOwnProperty(this.m_IconField))
            {
                return param1[this.m_IconField] as Class;
            }
            return null;
        }// end function

        protected function onDropDownButton(event:MouseEvent) : void
        {
            if (event != null)
            {
                this.destroyDropDownMenu();
                this.m_UIDropDownMenu = TabBarMenu.s_CreateMenu(null, this.createDropDownMenu(), true);
                this.m_UIDropDownMenu.selectedIndex = this.m_SelectedIndex;
                this.m_UIDropDownMenu.addEventListener(MenuEvent.ITEM_CLICK, this.onDropDownMenu);
                this.m_UIDropDownMenu.show(event.stageX, event.stageY);
            }
            return;
        }// end function

        public function set tabMinWidth(param1:Number) : void
        {
            if (this.m_TabMinWidth != param1)
            {
                this.m_TabMinWidth = param1;
                this.m_UncommittedTabMinWidth = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function set closePolicy(param1:int) : void
        {
            if (this.m_ClosePolicy != param1)
            {
                this.m_ClosePolicy = param1;
                this.m_UncommittedClosePolicy = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        protected function onNavItemDragEvent(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (event != null && this.m_DragEnabled)
            {
                _loc_2 = event.dragSource;
                if (!_loc_2.hasFormat("dragType") || _loc_2.dataForFormat("dragType") != "dynamicTab")
                {
                    return;
                }
                if (!_loc_2.hasFormat("dragTabBar") || _loc_2.dataForFormat("dragTabBar") != this)
                {
                    return;
                }
                if (!_loc_2.hasFormat("dragTabIndex"))
                {
                    return;
                }
                _loc_3 = int(_loc_2.dataForFormat("dragTabIndex"));
                _loc_4 = this.getDropIndex(event.localX, event.localY);
                switch(event.type)
                {
                    case DragEvent.DRAG_DROP:
                    {
                        if (_loc_3 < _loc_4)
                        {
                            _loc_4 = _loc_4 - 1;
                        }
                        if (_loc_3 != _loc_4)
                        {
                            _loc_5 = new TabBarEvent(TabBarEvent.DROP);
                            _loc_5.oldIndex = _loc_3;
                            _loc_5.index = _loc_4;
                            dispatchEvent(_loc_5);
                            if (!_loc_5.cancelable || !_loc_5.isDefaultPrevented())
                            {
                                if (this.m_DataProvider is IList)
                                {
                                    _loc_6 = IList(this.m_DataProvider);
                                    _loc_6.addItemAt(_loc_6.removeItemAt(_loc_3), _loc_4);
                                }
                                else if (this.m_DataProvider is ViewStack)
                                {
                                    _loc_7 = ViewStack(this.m_DataProvider);
                                    _loc_7.addChildAt(_loc_7.removeChildAt(_loc_3), _loc_4);
                                }
                                this.selectedIndex = _loc_4;
                            }
                        }
                    }
                    case DragEvent.DRAG_EXIT:
                    {
                        this.m_DragAutoScrollTimer.stop();
                        this.m_DragAutoScrollDirection = 0;
                        this.layoutDropIndicator(-1);
                        break;
                    }
                    case DragEvent.DRAG_ENTER:
                    {
                        DragManager.acceptDragDrop(this);
                    }
                    case DragEvent.DRAG_OVER:
                    {
                        if (this.m_UILeftButton.hitTestPoint(event.stageX, event.stageY))
                        {
                            this.m_DragAutoScrollDirection = -1;
                        }
                        else if (this.m_UIRightButton.hitTestPoint(event.stageX, event.stageY))
                        {
                            this.m_DragAutoScrollDirection = 1;
                        }
                        else
                        {
                            this.m_DragAutoScrollDirection = 0;
                        }
                        if (this.m_DragAutoScrollDirection != 0 && !this.m_DragAutoScrollTimer.running)
                        {
                            this.m_DragAutoScrollTimer.start();
                        }
                        this.layoutDropIndicator(_loc_4);
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

        protected function getFirstVisibleIndex() : int
        {
            return this.m_ScrollPosition;
        }// end function

        protected function onScrollButtonDown(event:MouseEvent) : void
        {
            if (event is MouseRepeatEvent)
            {
                MouseRepeatEvent(event).repeatEnabled = true;
            }
            return;
        }// end function

        protected function rebuildNavItems() : void
        {
            var _loc_1:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.m_FirstVisibleIndex = 0;
            this.m_LastVisibleIndex = 0;
            _loc_1 = numChildren - this.m_UIInternalChildren - 1;
            while (_loc_1 >= 0)
            {
                
                this.destroyNavItem(_loc_1);
                _loc_1 = _loc_1 - 1;
            }
            _loc_1 = 0;
            var _loc_2:* = 0;
            if (this.m_DataProvider is IList)
            {
                _loc_3 = IList(this.m_DataProvider);
                _loc_1 = 0;
                _loc_2 = _loc_3.length;
                while (_loc_1 < _loc_2)
                {
                    
                    this.createNavItem(_loc_3.getItemAt(_loc_1));
                    _loc_1++;
                }
            }
            else if (this.m_DataProvider is ViewStack)
            {
                _loc_4 = ViewStack(this.m_DataProvider);
                _loc_1 = 0;
                while (_loc_1 < _loc_2)
                {
                    
                    this.createNavItem(_loc_4.getChildAt(_loc_1));
                    _loc_1++;
                }
            }
            this.selectNavItems();
            return;
        }// end function

        protected function set navItemFactory(param1:ClassFactory) : void
        {
            if (this.m_NavItemFactory != param1)
            {
                this.m_NavItemFactory = param1;
                this.m_UncommittedNavItemFactory = true;
                invalidateDisplayList();
                invalidateSize();
                invalidateProperties();
            }
            return;
        }// end function

        public function get tabResize() : Boolean
        {
            return this.m_TabResize;
        }// end function

        protected function getLastVisibleIndex() : int
        {
            return this.m_LastVisibleIndex;
        }// end function

        private function itemToLabel(param1:Object) : String
        {
            if (param1 is Container)
            {
                return Container(param1).label;
            }
            if (param1 != null && this.m_LabelFunction != null)
            {
                return String(this.m_LabelFunction(param1));
            }
            if (param1 != null && this.m_LabelField != null && param1.hasOwnProperty(this.m_LabelField))
            {
                return String(param1[this.m_LabelField]);
            }
            return null;
        }// end function

        protected function onDropDownMenu(event:MenuEvent) : void
        {
            if (event != null)
            {
                this.destroyDropDownMenu();
                this.selectedIndex = event.index;
            }
            return;
        }// end function

        private function getDropIndex(param1:Number, param2:Number) : int
        {
            var _loc_3:* = this.getFirstVisibleIndex();
            var _loc_4:* = this.getLastVisibleIndex();
            if (_loc_3 >= _loc_4)
            {
                return -1;
            }
            _loc_4 = _loc_4 - 1;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_5 = (_loc_3 + _loc_4) / 2;
                _loc_6 = DynamicTab(getChildAt(_loc_5));
                if (param1 < _loc_6.x)
                {
                    _loc_4 = _loc_5 - 1;
                    continue;
                }
                if (param1 < _loc_6.x + _loc_6.width / 2)
                {
                    return _loc_5;
                }
                if (param1 < _loc_6.x + _loc_6.width)
                {
                    return (_loc_5 + 1);
                }
                _loc_3 = _loc_5 + 1;
            }
            if (param1 < _loc_6.x + _loc_6.width / 2)
            {
                return _loc_5;
            }
            return (_loc_5 + 1);
        }// end function

        public function get dataProvider() : Object
        {
            return this.m_DataProvider;
        }// end function

        public function get dropDownPolicy() : int
        {
            return this.m_DropDownPolicy;
        }// end function

        public function set toolTipField(param1:String) : void
        {
            if (this.m_ToolTipField != param1)
            {
                this.m_ToolTipField = param1;
                this.m_UncommittedToolTipField = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            super.styleChanged(param1);
            switch(param1)
            {
                case "dropIndicatorSkin":
                {
                    this.createDropIndicator();
                    break;
                }
                case "scrollLeftButtonStyle":
                {
                    if (this.m_UILeftButton != null)
                    {
                        this.m_UILeftButton.styleName = getStyle("scrollLeftButtonStyle");
                    }
                    invalidateDisplayList();
                    invalidateSize();
                    break;
                }
                case "scrollRightButtonStyle":
                {
                    if (this.m_UIRightButton != null)
                    {
                        this.m_UIRightButton.styleName = getStyle("scrollRightButtonStyle");
                    }
                    invalidateDisplayList();
                    invalidateSize();
                    break;
                }
                case "dropDownButtonStyle":
                {
                    if (this.m_UIDropDownButton != null)
                    {
                        this.m_UIDropDownButton.styleName = getStyle("dropDownButtonStyle");
                    }
                    invalidateDisplayList();
                    invalidateSize();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function set scrollPolicy(param1:String) : void
        {
            if (this.m_ScrollPolicy != param1)
            {
                this.m_ScrollPolicy = param1;
                this.m_UncommittedScrollPolicy = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            super.commitProperties();
            if (this.m_UncommittedDataProvider)
            {
                this.selectedIndex = this.m_SelectedIndex;
                this.scrollPosition = this.m_ScrollPosition;
                this.rebuildNavItems();
                this.m_UncommittedDataProvider = false;
            }
            if (this.m_UncommittedIconField)
            {
                this.rebuildNavItems();
                this.m_UncommittedIconField = false;
            }
            if (this.m_UncommittedLabelField)
            {
                this.rebuildNavItems();
                this.m_UncommittedLabelField = false;
            }
            if (this.m_UncommittedLabelFunction)
            {
                this.rebuildNavItems();
                this.m_UncommittedLabelField = false;
            }
            if (this.m_UncommittedToolTipField)
            {
                this.rebuildNavItems();
                this.m_UncommittedToolTipField = false;
            }
            if (this.m_UncommittedClosePolicy)
            {
                _loc_1 = this.getDataProviderLength() - 1;
                while (_loc_1 >= 0)
                {
                    
                    DynamicTab(getChildAt(_loc_1)).closePolicy = this.m_ClosePolicy;
                    _loc_1 = _loc_1 - 1;
                }
                this.m_UncommittedClosePolicy = false;
            }
            if (this.m_UncommittedDragEnabled)
            {
                this.m_UncommittedDragEnabled = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                this.selectNavItems();
                this.m_UncommittedSelectedIndex = false;
            }
            if (this.m_UncommittedScrollPolicy)
            {
                if (this.m_ScrollPolicy == ScrollPolicy.OFF)
                {
                    this.scrollPosition = 0;
                }
                this.m_UncommittedScrollPolicy = false;
            }
            if (this.m_UncommittedScrollPosition)
            {
                this.m_UncommittedScrollPosition = false;
            }
            if (this.m_UncommittedTabResize)
            {
                this.m_UncommittedTabResize = false;
            }
            if (this.m_UncommittedTabMinWidth)
            {
                this.m_UncommittedTabMinWidth = false;
            }
            if (this.m_UncommittedTabMaxWidth)
            {
                this.m_UncommittedTabMaxWidth = false;
            }
            if (this.m_UncommittedDropDownPolicy)
            {
                this.m_UncommittedDropDownPolicy = false;
            }
            if (this.m_UncommittedNavItemFactory)
            {
                this.rebuildNavItems();
                this.m_UncommittedNavItemFactory = false;
            }
            return;
        }// end function

        public function set labelField(param1:String) : void
        {
            if (this.m_LabelField != param1)
            {
                this.m_LabelField = param1;
                this.m_UncommittedLabelField = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function layoutDropIndicator(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this.m_UIDropIndicator != null)
            {
                _loc_2 = null;
                _loc_3 = this.getLastVisibleIndex();
                if (param1 >= this.m_ScrollPosition && param1 < _loc_3)
                {
                    _loc_2 = DynamicTab(getChildAt(param1));
                    this.m_UIDropIndicator.x = _loc_2.x - this.m_UIDropIndicator.width / 2;
                    this.m_UIDropIndicator.y = 0;
                    this.m_UIDropIndicator.visible = true;
                }
                else if (param1 == _loc_3)
                {
                    _loc_2 = DynamicTab(getChildAt((param1 - 1)));
                    this.m_UIDropIndicator.x = _loc_2.x + _loc_2.width - this.m_UIDropIndicator.width / 2;
                    this.m_UIDropIndicator.y = 0;
                    this.m_UIDropIndicator.visible = true;
                }
                else
                {
                    this.m_UIDropIndicator.visible = false;
                }
            }
            return;
        }// end function

        public function get toolTipField() : String
        {
            return this.m_ToolTipField;
        }// end function

        public function set labelFunction(param1:Function) : void
        {
            if (this.m_LabelFunction != param1)
            {
                this.m_LabelFunction = param1;
                this.m_UncommittedLabelFunction = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onNavItemSelect(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (event != null)
            {
                _loc_2 = DynamicTab(event.currentTarget);
                _loc_3 = getChildIndex(_loc_2);
                if (_loc_2.enabled)
                {
                    this.selectedIndex = _loc_3;
                }
            }
            return;
        }// end function

        protected function onIListChange(event:CollectionEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (event != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = null;
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        _loc_2 = 0;
                        _loc_4 = event.items.length;
                        while (_loc_2 < _loc_4)
                        {
                            
                            _loc_3 = event.location + _loc_2;
                            _loc_5 = IList(this.m_DataProvider).getItemAt(_loc_3);
                            setChildIndex(this.createNavItem(_loc_5), _loc_3);
                            _loc_2++;
                        }
                        break;
                    }
                    case CollectionEventKind.MOVE:
                    {
                        setChildIndex(getChildAt(event.oldLocation), event.location);
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        _loc_2 = 0;
                        _loc_4 = event.items.length;
                        while (_loc_2 < _loc_4)
                        {
                            
                            this.destroyNavItem(event.location + _loc_2);
                            _loc_2++;
                        }
                        this.selectNavItems();
                        break;
                    }
                    case CollectionEventKind.REFRESH:
                    case CollectionEventKind.RESET:
                    {
                        this.rebuildNavItems();
                        break;
                    }
                    case CollectionEventKind.REPLACE:
                    {
                        _loc_3 = event.location;
                        _loc_5 = IList(this.m_DataProvider).getItemAt(_loc_3);
                        this.destroyNavItem(_loc_3);
                        setChildIndex(this.createNavItem(_loc_5), _loc_3);
                        this.selectNavItems();
                        break;
                    }
                    case CollectionEventKind.UPDATE:
                    {
                        _loc_2 = 0;
                        _loc_4 = event.items.length;
                        while (_loc_2 < _loc_4)
                        {
                            
                            _loc_5 = event.items[_loc_2];
                            if (_loc_5 is PropertyChangeEvent)
                            {
                                _loc_5 = PropertyChangeEvent(_loc_5).target;
                            }
                            _loc_3 = IList(this.m_DataProvider).getItemIndex(_loc_5);
                            if (_loc_3 > -1)
                            {
                                this.destroyNavItem(_loc_3);
                                setChildIndex(this.createNavItem(_loc_5), _loc_3);
                            }
                            else
                            {
                                this.rebuildNavItems();
                                break;
                            }
                            _loc_2++;
                        }
                        this.selectNavItems();
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

        public function set dragEnabled(param1:Boolean) : void
        {
            if (this.m_DragEnabled != param1)
            {
                this.m_DragEnabled = param1;
                this.m_UncommittedDragEnabled = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get labelFunction() : Function
        {
            return this.m_LabelFunction;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (param1 < 0 || param1 >= this.getDataProviderLength())
            {
                param1 = -1;
            }
            if (this.m_SelectedIndex != param1)
            {
                _loc_2 = param1 > -1 && (param1 < this.getFirstVisibleIndex() || param1 >= this.getLastVisibleIndex());
                this.m_SelectedIndex = param1;
                this.m_UncommittedSelectedIndex = true;
                invalidateDisplayList();
                invalidateProperties();
                if (_loc_2)
                {
                    this.scrollPosition = param1;
                }
                _loc_3 = new TabBarEvent(TabBarEvent.SELECT, false, false);
                _loc_3.index = param1;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        protected function onScrollDrag(event:TimerEvent) : void
        {
            if (event != null)
            {
                this.scrollPosition = this.scrollPosition + this.m_DragAutoScrollDirection;
                validateNow();
                this.layoutDropIndicator(this.getDropIndex(mouseX, mouseY));
            }
            return;
        }// end function

        protected function onStackChange(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null && event.target != this)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = null;
                switch(event.type)
                {
                    case ChildExistenceChangedEvent.CHILD_ADD:
                    {
                        _loc_4 = Container(ChildExistenceChangedEvent(event).relatedObject);
                        _loc_4.addEventListener("enabledChanged", this.onStackChildChange);
                        _loc_4.addEventListener("iconChanged", this.onStackChildChange);
                        _loc_4.addEventListener("labelChanged", this.onStackChildChange);
                        _loc_4.addEventListener("toolTipChanged", this.onStackChildChange);
                        _loc_2 = ViewStack(this.m_DataProvider).getChildIndex(_loc_4);
                        setChildIndex(this.createNavItem(_loc_4), _loc_2);
                        break;
                    }
                    case ChildExistenceChangedEvent.CHILD_REMOVE:
                    {
                        _loc_4 = Container(ChildExistenceChangedEvent(event).relatedObject);
                        _loc_4.removeEventListener("enabledChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("iconChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("labelChanged", this.onStackChildChange);
                        _loc_4.removeEventListener("toolTipChanged", this.onStackChildChange);
                        _loc_2 = ViewStack(this.m_DataProvider).getChildIndex(_loc_4);
                        removeChildAt(_loc_2);
                        break;
                    }
                    case IndexChangedEvent.CHILD_INDEX_CHANGE:
                    {
                        _loc_2 = IndexChangedEvent(event).oldIndex;
                        _loc_3 = IndexChangedEvent(event).newIndex;
                        setChildIndex(getChildAt(_loc_2), _loc_3);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_20:* = NaN;
            var _loc_21:* = false;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = param1;
            var _loc_5:* = getStyle("paddingTop");
            var _loc_6:* = param1 - _loc_3 - getStyle("paddingRight");
            var _loc_7:* = param2 - _loc_5 - getStyle("paddingBottom");
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = measuredWidth > param1;
            if (this.m_DropDownPolicy != DROP_DOWN_OFF)
            {
                _loc_8 = this.m_UIDropDownButton.getExplicitOrMeasuredWidth();
                _loc_9 = this.m_UIDropDownButton.getExplicitOrMeasuredHeight();
                this.m_UIDropDownButton.setActualSize(_loc_8, _loc_9);
                this.m_UIDropDownButton.move(_loc_4 - _loc_8, (param2 - _loc_9) / 2);
                this.m_UIDropDownButton.visible = this.m_DropDownPolicy == DROP_DOWN_ON || _loc_11;
                _loc_4 = _loc_4 - _loc_8;
                _loc_6 = _loc_6 - _loc_8;
            }
            else
            {
                this.m_UIDropDownButton.visible = false;
            }
            if (this.m_ScrollPolicy != ScrollPolicy.OFF)
            {
                _loc_8 = this.m_UILeftButton.getExplicitOrMeasuredWidth();
                _loc_9 = this.m_UILeftButton.getExplicitOrMeasuredHeight();
                this.m_UILeftButton.setActualSize(_loc_8, _loc_9);
                this.m_UILeftButton.move(0, (param2 - _loc_9) / 2);
                this.m_UILeftButton.visible = this.m_ScrollPolicy == ScrollPolicy.ON || _loc_11;
                _loc_3 = _loc_3 + _loc_8;
                _loc_6 = _loc_6 - _loc_8;
                _loc_8 = this.m_UIRightButton.getExplicitOrMeasuredWidth();
                _loc_9 = this.m_UIRightButton.getExplicitOrMeasuredHeight();
                this.m_UIRightButton.setActualSize(_loc_8, _loc_9);
                this.m_UIRightButton.move(_loc_4 - _loc_8, (param2 - _loc_9) / 2);
                this.m_UIRightButton.visible = this.m_ScrollPolicy == ScrollPolicy.ON || _loc_11;
                _loc_6 = _loc_6 - _loc_8;
            }
            else
            {
                this.m_UILeftButton.visible = false;
                this.m_UIRightButton.visible = false;
            }
            var _loc_12:* = 0;
            var _loc_13:* = numChildren - this.m_UIInternalChildren;
            var _loc_14:* = null;
            var _loc_15:* = new Vector.<Object>(_loc_13, true);
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            _loc_12 = 0;
            while (_loc_12 < _loc_13)
            {
                
                _loc_14 = DynamicTab(getChildAt(_loc_12));
                _loc_14.visible = false;
                _loc_8 = _loc_14.getExplicitOrMeasuredWidth();
                if (this.m_TabResize && !isNaN(this.m_TabMinWidth))
                {
                    _loc_10 = this.m_TabMinWidth;
                }
                else if (!isNaN(_loc_14.minWidth))
                {
                    _loc_10 = _loc_14.minWidth;
                }
                else
                {
                    _loc_10 = _loc_8;
                }
                if (this.m_TabResize && !isNaN(this.m_TabMaxWidth))
                {
                    _loc_8 = Math.min(_loc_8, this.m_TabMaxWidth);
                }
                _loc_8 = Math.max(_loc_10, _loc_8);
                _loc_15[_loc_12] = {val:_loc_8, max:_loc_8, min:_loc_10};
                _loc_17 = _loc_17 + _loc_8;
                _loc_18 = _loc_18 + _loc_10;
                _loc_16 = Math.max(_loc_16, _loc_14.getExplicitOrMeasuredHeight());
                _loc_12++;
            }
            if (this.m_TabResize && _loc_17 > _loc_18 && _loc_17 > _loc_6)
            {
                _loc_20 = Math.max(0, 1 - (_loc_17 - _loc_6) / (_loc_17 - _loc_18));
                _loc_12 = 0;
                while (_loc_12 < _loc_13)
                {
                    
                    _loc_15[_loc_12].val = Math.floor(_loc_15[_loc_12].min + _loc_20 * (_loc_15[_loc_12].max - _loc_15[_loc_12].min));
                    _loc_12++;
                }
            }
            var _loc_19:* = getStyle("horizontalGap");
            this.m_ScrollPosition = Math.max(0, Math.min(this.m_ScrollPosition, (_loc_13 - 1)));
            _loc_12 = this.m_ScrollPosition;
            while (_loc_12 >= 0 && _loc_12 < _loc_13 && _loc_6 >= _loc_15[_loc_12].val)
            {
                
                _loc_6 = _loc_6 - (_loc_15[_loc_12].val + _loc_19);
                _loc_12++;
            }
            _loc_13 = _loc_12;
            _loc_12 = this.m_ScrollPosition - 1;
            while (_loc_12 >= 0 && _loc_6 >= _loc_15[_loc_12].val)
            {
                
                _loc_6 = _loc_6 - (_loc_15[_loc_12].val + _loc_19);
                _loc_12 = _loc_12 - 1;
                var _loc_22:* = this;
                var _loc_23:* = this.m_ScrollPosition - 1;
                _loc_22.m_ScrollPosition = _loc_23;
            }
            _loc_12 = this.m_ScrollPosition;
            while (_loc_12 < _loc_13)
            {
                
                _loc_14 = DynamicTab(getChildAt(_loc_12));
                _loc_8 = _loc_15[_loc_12].val;
                _loc_9 = _loc_14.getExplicitOrMeasuredHeight();
                _loc_14.setActualSize(_loc_8, _loc_9);
                _loc_14.move(_loc_3, _loc_5 + _loc_7 - _loc_9);
                _loc_14.visible = true;
                _loc_3 = _loc_3 + (_loc_8 + _loc_19);
                _loc_12++;
            }
            this.m_FirstVisibleIndex = this.m_ScrollPosition;
            this.m_LastVisibleIndex = _loc_13;
            if (this.m_ScrollPolicy != ScrollPolicy.OFF)
            {
                _loc_21 = this.m_ScrollPosition > 0;
                if (this.m_UILeftButton.enabled && !_loc_21)
                {
                    var _loc_22:* = this.m_UILeftButton;
                    _loc_22.mx_internal::buttonReleased();
                }
                _loc_22.enabled = _loc_21;
                _loc_21 = _loc_13 < numChildren - this.m_UIInternalChildren;
                if (this.m_UIRightButton.enabled && !_loc_21)
                {
                    var _loc_22:* = this.m_UIRightButton;
                    _loc_22.mx_internal::buttonReleased();
                }
                _loc_22.enabled = _loc_21;
            }
            else
            {
                this.m_UILeftButton.enabled = false;
                _loc_22.enabled = false;
            }
            if (this.m_DropDownPolicy != DROP_DOWN_OFF)
            {
                this.m_UIDropDownButton.enabled = this.m_UILeftButton.enabled || _loc_22.enabled;
            }
            else
            {
                this.m_UIDropDownButton.enabled = false;
            }
            return;
        }// end function

        private static function s_InitializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.disabledSkin = null;
                this.downSkin = null;
                this.overSkin = null;
                this.upSkin = null;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, false);
            Selector;
            Decl = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.disabledSkin = null;
                this.downSkin = null;
                this.overSkin = null;
                this.upSkin = null;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, false);
            Selector;
            Decl = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.disabledSkin = null;
                this.downSkin = null;
                this.overSkin = null;
                this.upSkin = null;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, false);
            Selector;
            Decl = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.horizontalGap = 0;
                this.paddingBottom = 0;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.paddingTop = 0;
                this.dropIndicatorSkin = null;
                this.scrollLeftButtonStyle = "defaultScrollLeftButtonStyle";
                this.scrollRightButtonStyle = "defaultScrollRightButtonStyle";
                this.dropDownButtonStyle = "defaultDropDownButtonStyle";
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
