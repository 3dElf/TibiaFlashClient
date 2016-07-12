package tibia.sidebar
{
    import flash.display.*;
    import flash.events.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.options.*;

    public class ToggleBar extends UIComponent
    {
        private var m_UIRawChildren:int = 0;
        private var m_UncommittedLocations:Boolean = false;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_UIBorderStyle:Object = null;
        protected var m_Location:Array = null;
        protected var m_Options:OptionsStorage = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_SideBarSet:SideBarSet = null;
        protected var m_UIButtons:Array = null;
        private var m_UncommittedSideBarSet:Boolean = false;
        protected var m_UIBorderInstance:IFlexDisplayObject = null;

        public function ToggleBar()
        {
            return;
        }// end function

        private function layoutChrome(param1:Number, param2:Number) : void
        {
            if (this.m_UIBorderInstance != null)
            {
                this.m_UIBorderInstance.move(0, 0);
                this.m_UIBorderInstance.setActualSize(param1, param2);
            }
            return;
        }// end function

        function get sideBarSet() : SideBarSet
        {
            return this.m_SideBarSet;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedSideBarSet)
            {
                this.updateToggleButtons();
                this.m_UncommittedSideBarSet = false;
            }
            if (this.m_UncommittedLocations)
            {
                this.updateToggleButtons();
                this.m_UncommittedLocations = false;
            }
            return;
        }// end function

        private function updateToggleButtons() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_1 = numChildren - 1;
            while (_loc_1 >= this.m_UIRawChildren)
            {
                
                _loc_3 = removeChildAt(_loc_1);
                _loc_3.removeEventListener(MouseEvent.CLICK, this.onToggleButtonClick);
                _loc_1 = _loc_1 - 1;
            }
            if (this.m_Location != null)
            {
                _loc_1 = 0;
                _loc_2 = this.m_Location.length;
                while (_loc_1 < _loc_2)
                {
                    
                    _loc_4 = new CustomButton();
                    _loc_4.data = this.m_Location[_loc_1];
                    _loc_4.selected = this.m_SideBarSet != null && this.m_SideBarSet.getSideBar(this.m_Location[_loc_1]).visible;
                    _loc_4.styleName = getStyle("toggleButtonStyle");
                    _loc_4.toggle = true;
                    _loc_4.addEventListener(MouseEvent.CLICK, this.onToggleButtonClick);
                    addChild(_loc_4);
                    _loc_1++;
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
                    this.m_SideBarSet.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarSetPropertyChange);
                }
                this.m_SideBarSet = param1;
                if (this.m_SideBarSet != null)
                {
                    this.m_SideBarSet.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarSetPropertyChange);
                }
                this.m_UncommittedSideBarSet = true;
                invalidateProperties();
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

        protected function onSideBarSetPropertyChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (event != null)
            {
                switch(event.property as String)
                {
                    case "sideBarInstanceOptions":
                    {
                        _loc_2 = event.source as SideBar;
                        if (_loc_2 != null)
                        {
                            _loc_3 = numChildren - 1;
                            while (_loc_3 >= 0)
                            {
                                
                                _loc_4 = getChildAt(_loc_3) as Button;
                                if (_loc_4 != null && int(_loc_4.data) == _loc_2.location)
                                {
                                    _loc_4.selected = _loc_2.visible;
                                    break;
                                }
                                _loc_3 = _loc_3 - 1;
                            }
                        }
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

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            super.updateDisplayList(param1, param2);
            this.layoutChrome(param1, param2);
            var _loc_3:* = getStyle("verticalGap");
            var _loc_4:* = getStyle("paddingLeft");
            var _loc_5:* = getStyle("paddingTop");
            var _loc_6:* = param2 - _loc_5 - getStyle("paddingBottom");
            var _loc_7:* = param1 - _loc_4 - getStyle("paddingRight");
            _loc_5 = _loc_5 + (_loc_6 - measuredHeight) / 2;
            var _loc_8:* = this.m_UIRawChildren;
            var _loc_9:* = numChildren;
            while (_loc_8 < _loc_9)
            {
                
                _loc_10 = UIComponent(getChildAt(_loc_8));
                _loc_11 = _loc_10.getExplicitOrMeasuredWidth();
                _loc_12 = _loc_10.getExplicitOrMeasuredHeight();
                _loc_10.move(_loc_4 + (_loc_7 - _loc_11) / 2, _loc_5);
                _loc_10.setActualSize(_loc_11, _loc_12);
                _loc_5 = _loc_5 + (_loc_12 + _loc_3);
                _loc_8++;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.updateToggleButtons();
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function updateBorder() : void
        {
            var _loc_1:* = getStyle("borderSkin") as Class;
            if (this.m_UIBorderStyle != _loc_1)
            {
                if (this.m_UIBorderInstance != null)
                {
                    removeChildAt(0);
                    this.m_UIRawChildren = 0;
                }
                this.m_UIBorderStyle = _loc_1;
                if (this.m_UIBorderStyle != null)
                {
                    this.m_UIBorderInstance = IFlexDisplayObject(new this.m_UIBorderStyle());
                    if (this.m_UIBorderInstance is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(this.m_UIBorderInstance).styleName = this;
                    }
                    if (this.m_UIBorderInstance is IInvalidating)
                    {
                        IInvalidating(this.m_UIBorderInstance).validateNow();
                    }
                    addChildAt(DisplayObject(this.m_UIBorderInstance), 0);
                    this.m_UIRawChildren = 1;
                }
                else
                {
                    this.m_UIBorderInstance = null;
                }
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        protected function onToggleButtonClick(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = event.currentTarget as Button;
            }
            if (_loc_2 != null && this.m_SideBarSet != null)
            {
                _loc_3 = int(_loc_2.data);
                _loc_4 = this.m_SideBarSet.getSideBar(_loc_3);
                if (_loc_4 != null)
                {
                    _loc_4.visible = !_loc_4.visible;
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_3:* = NaN;
            var _loc_6:* = null;
            super.measure();
            var _loc_1:* = getStyle("verticalGap");
            var _loc_2:* = 0;
            _loc_3 = -_loc_1;
            var _loc_4:* = numChildren - 1;
            while (_loc_4 >= this.m_UIRawChildren)
            {
                
                _loc_6 = UIComponent(getChildAt(_loc_4));
                _loc_2 = Math.max(_loc_2, _loc_6.getExplicitOrMeasuredWidth());
                _loc_3 = _loc_3 + (_loc_6.getExplicitOrMeasuredHeight() + _loc_1);
                _loc_4 = _loc_4 - 1;
            }
            _loc_3 = Math.max(0, _loc_3);
            this.updateBorder();
            var _loc_5:* = EdgeMetrics.EMPTY;
            if (this.m_UIBorderInstance is IBorder)
            {
                _loc_5 = IBorder(this.m_UIBorderInstance).borderMetrics;
            }
            var _loc_7:* = Math.max(_loc_5.left + _loc_5.right, getStyle("paddingLeft") + _loc_2 + getStyle("paddingRight"));
            measuredMinWidth = Math.max(_loc_5.left + _loc_5.right, getStyle("paddingLeft") + _loc_2 + getStyle("paddingRight"));
            measuredWidth = _loc_7;
            var _loc_7:* = Math.max(_loc_5.top + _loc_5.bottom, getStyle("paddingTop") + _loc_3 + getStyle("paddingBottom"));
            measuredMinHeight = Math.max(_loc_5.top + _loc_5.bottom, getStyle("paddingTop") + _loc_3 + getStyle("paddingBottom"));
            measuredHeight = _loc_7;
            return;
        }// end function

        public function set location(param1:Array) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (param1 != null)
            {
                _loc_2 = param1.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = int(param1[_loc_2]);
                    if (!SideBarSet.s_CheckLocation(_loc_3))
                    {
                        throw new ArgumentError("ToggleBar.set location: Invalid location ID.");
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            if (this.m_Location != param1)
            {
                this.m_Location = param1;
                this.m_UncommittedLocations = true;
                invalidateProperties();
            }
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

        public function get location() : Array
        {
            return this.m_Location;
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

        private static function s_InitializeStyle() : void
        {
            var Style:* = StyleManager.getStyleDeclaration("ToggleBar");
            if (Style == null)
            {
                Style = new CSSStyleDeclaration();
            }
            Style.defaultFactory = function () : void
            {
                this.borderSkin = undefined;
                this.verticalGap = 4;
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration("ToggleBar", Style, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
