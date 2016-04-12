package tibia.sidebar.sideBarWidgetClasses
{
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.sidebar.*;

    public class SideBarHeader extends Container
    {
        private var m_UIFoldButton:Button = null;
        private var m_UncommittedLocation:Boolean = false;
        private var m_Location:int = -1;
        private var m_Fold:Boolean = false;
        private var m_UncommittedSideBarSet:Boolean = false;
        private var m_SideBarSet:SideBarSet = null;
        private var m_UncommittedFold:Boolean = false;
        static const DEFAULT_WIDGET_HEIGHT:Number = 200;
        static const DEFAULT_WIDGET_WIDTH:Number = 184;
        private static const BUNDLE:String = "SideBarHeader";
        private static const COMPONENT_DEFINITIONS:Array = [{toolTip:"TIP_GENERAL", type:Widget.TYPE_GENERALBUTTONS, styleName:"buttonGeneralStyle", left:6, top:19}, {toolTip:"TIP_COMBAT", type:Widget.TYPE_COMBATCONTROL, styleName:"buttonCombatStyle", left:18, top:4}, {toolTip:"TIP_MINIMAP", type:Widget.TYPE_MINIMAP, styleName:"buttonMinimapStyle", left:42, top:19}, {toolTip:"TIP_CONTAINER", type:Widget.TYPE_CONTAINER, styleName:"buttonContainerStyle", left:126, top:4}, {toolTip:"TIP_BODY", type:Widget.TYPE_BODY, styleName:"buttonBodyStyle", left:54, top:4}, {toolTip:"TIP_BATTLELIST", type:Widget.TYPE_BATTLELIST, styleName:"buttonBattlelistStyle", left:90, top:4}, {toolTip:"TIP_BUDDYLIST", type:Widget.TYPE_BUDDYLIST, styleName:"buttonBuddylistStyle", left:78, top:19}, {toolTip:"TIP_TRADE", type:Widget.TYPE_NPCTRADE, styleName:"buttonTradeStyle", left:114, top:19}, {toolTip:"TIP_UNJUSTPOINTS", type:Widget.TYPE_UNJUSTPOINTS, styleName:"buttonUnjustPointsStyle", left:148, top:19}];

        public function SideBarHeader()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            return;
        }// end function

        public function get fold() : Boolean
        {
            return this.m_Fold;
        }// end function

        public function set fold(param1:Boolean) : void
        {
            if (this.m_Fold != param1)
            {
                this.m_Fold = param1;
                this.m_UncommittedFold = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get sideBarSet() : SideBarSet
        {
            return this.m_SideBarSet;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedLocation || this.m_UncommittedSideBarSet)
            {
                this.updateWidgetButtons();
                if (this.sideBar != null)
                {
                    this.fold = this.sideBar.foldHeader;
                }
                this.m_UncommittedLocation = false;
                this.m_UncommittedSideBarSet = false;
            }
            if (this.m_UncommittedFold)
            {
                this.m_UIFoldButton.selected = this.fold;
                this.m_UncommittedFold = false;
            }
            return;
        }// end function

        private function onWidgetButtonClick(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = null;
            var _loc_4:* = event.currentTarget as Button;
            _loc_2 = event.currentTarget as Button;
            if (event != null && _loc_4 != null && this.sideBarSet != null)
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                _loc_3 = int(_loc_2.data);
                if (!Widget.s_GetUnique(_loc_3))
                {
                    this.sideBarSet.setDefaultLocation(_loc_3, this.location);
                }
                else if (this.sideBarSet.countWidgetType(_loc_3, this.location) > 0)
                {
                    this.sideBarSet.hideWidgetType(_loc_3, this.location);
                }
                else
                {
                    this.sideBarSet.showWidgetType(_loc_3, this.location, -1);
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = null;
            layoutChrome(param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = numChildren - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = getChildAt(_loc_5) as Button;
                if (_loc_6 != null)
                {
                    _loc_7 = 0;
                    _loc_8 = 0;
                    for each (_loc_9 in COMPONENT_DEFINITIONS)
                    {
                        
                        if (_loc_6.data == _loc_9.type)
                        {
                            _loc_7 = _loc_9.left;
                            _loc_8 = _loc_9.top;
                            break;
                        }
                    }
                    _loc_3 = _loc_6.getExplicitOrMeasuredWidth();
                    _loc_4 = _loc_6.getExplicitOrMeasuredHeight();
                    _loc_6.move(_loc_7, _loc_8);
                    _loc_6.setActualSize(_loc_3, _loc_4);
                }
                _loc_5 = _loc_5 - 1;
            }
            _loc_3 = this.m_UIFoldButton.getExplicitOrMeasuredWidth();
            _loc_4 = this.m_UIFoldButton.getExplicitOrMeasuredHeight();
            this.m_UIFoldButton.move(Math.round((param1 - _loc_3) / 2), param2 - _loc_4);
            this.m_UIFoldButton.setActualSize(_loc_3, _loc_4);
            return;
        }// end function

        public function set sideBarSet(param1:SideBarSet) : void
        {
            if (this.m_SideBarSet != param1)
            {
                if (this.m_SideBarSet != null)
                {
                    this.m_SideBarSet.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarSetChange);
                }
                this.m_SideBarSet = param1;
                this.m_UncommittedSideBarSet = true;
                invalidateProperties();
                if (this.m_SideBarSet != null)
                {
                    this.m_SideBarSet.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarSetChange);
                }
            }
            return;
        }// end function

        protected function updateWidgetButtons() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_1:* = numChildren - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = getChildAt(_loc_1) as Button;
                if (_loc_2 != null)
                {
                    _loc_3 = int(_loc_2.data);
                    if (this.sideBarSet == null)
                    {
                        _loc_2.selected = false;
                    }
                    else if (!Widget.s_GetUnique(_loc_3))
                    {
                        _loc_2.selected = this.sideBarSet.getDefaultLocation(_loc_3) == this.location;
                    }
                    else
                    {
                        _loc_2.selected = this.sideBarSet.countWidgetType(_loc_3, this.location) > 0;
                    }
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        private function onSideBarSetChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "defaultLocation" || event.property == "sideBarInstanceOptions")
            {
                this.updateWidgetButtons();
                if (this.sideBar != null)
                {
                    this.fold = this.sideBar.foldHeader;
                }
            }
            return;
        }// end function

        private function onFoldButtonClick(event:MouseEvent) : void
        {
            if (this.sideBar != null)
            {
                this.sideBar.foldHeader = !this.sideBar.foldHeader;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.createChildren();
            this.m_UIFoldButton = new CustomButton();
            this.m_UIFoldButton.selected = this.fold;
            this.m_UIFoldButton.styleName = getStyle("foldButtonStyleName");
            this.m_UIFoldButton.toggle = true;
            this.m_UIFoldButton.addEventListener(MouseEvent.CLICK, this.onFoldButtonClick);
            rawChildren.addChild(this.m_UIFoldButton);
            for each (_loc_1 in COMPONENT_DEFINITIONS)
            {
                
                _loc_2 = new CustomButton();
                _loc_2.data = _loc_1.type;
                _loc_2.styleName = getStyle(_loc_1.styleName);
                _loc_2.toggle = true;
                _loc_2.toolTip = resourceManager.getString(BUNDLE, _loc_1.toolTip);
                _loc_2.addEventListener(MouseEvent.CLICK, this.onWidgetButtonClick, false, (EventPriority.DEFAULT + 1), false);
                addChild(_loc_2);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:* = NaN;
            var _loc_1:* = 0;
            _loc_2 = 0;
            if (mx_internal::border != null)
            {
                if (!isNaN(mx_internal::border.measuredWidth))
                {
                    _loc_1 = mx_internal::border.measuredWidth;
                }
                if (!isNaN(mx_internal::border.measuredHeight))
                {
                    _loc_2 = mx_internal::border.measuredHeight;
                }
            }
            var _loc_3:* = _loc_1;
            measuredWidth = _loc_1;
            measuredMinWidth = _loc_3;
            if (this.fold)
            {
                var _loc_3:* = Math.max(viewMetrics.bottom, this.m_UIFoldButton.getExplicitOrMeasuredHeight());
                measuredHeight = Math.max(viewMetrics.bottom, this.m_UIFoldButton.getExplicitOrMeasuredHeight());
                measuredMinHeight = _loc_3;
            }
            else
            {
                var _loc_3:* = _loc_2;
                measuredHeight = _loc_2;
                measuredMinHeight = _loc_3;
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

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        protected function get sideBar() : SideBar
        {
            if (this.sideBarSet != null)
            {
                return this.sideBarSet.getSideBar(this.location);
            }
            return null;
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
