package tibia.controls.dynamicTabBarClasses
{
    import flash.events.*;
    import mx.controls.*;
    import mx.controls.tabBarClasses.*;
    import mx.styles.*;
    import shared.controls.*;
    import tibia.controls.*;

    public class DynamicTab extends Tab
    {
        protected var m_UICloseButton:Button = null;
        protected var m_IsEnabled:Boolean = false;
        private var m_UncommittedSelected:Boolean = false;
        protected var m_IsSelected:Boolean = false;
        protected var m_ClosePolicy:int;
        protected var m_IsRollOver:Boolean = false;
        private var m_UncommittedEnabled:Boolean = false;
        private var m_UncommittedClosePolicy:Boolean = false;
        private var m_UIConstructed:Boolean = false;

        public function DynamicTab()
        {
            this.m_ClosePolicy = DynamicTabBar.CLOSE_NEVER;
            mouseChildren = true;
            mouseEnabled = true;
            return;
        }// end function

        override protected function rollOutHandler(event:MouseEvent) : void
        {
            if (event != null && enabled)
            {
                this.m_IsRollOver = false;
                super.rollOutHandler(event);
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            if (enabled != param1)
            {
                super.enabled = param1;
                this.m_UncommittedEnabled = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "closeButtonStyle":
                {
                    this.m_UICloseButton.styleName = this.getStyle("closeButtonStyle");
                    break;
                }
                case "closeButtonRight":
                case "closeButtonTop":
                {
                    invalidateSize();
                    invalidateDisplayList();
                    break;
                }
                case "defaultTextColor":
                case "selectedTextColor":
                {
                    this.updateTextColor();
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

        public function get closePolicy() : int
        {
            return this.m_ClosePolicy;
        }// end function

        public function set closePolicy(param1:int) : void
        {
            if (param1 != DynamicTabBar.CLOSE_ALWAYS && param1 != DynamicTabBar.CLOSE_NEVER && param1 != DynamicTabBar.CLOSE_ROLLOVER && param1 != DynamicTabBar.CLOSE_SELECTED)
            {
                param1 = DynamicTabBar.CLOSE_NEVER;
            }
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

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedClosePolicy)
            {
                this.m_UncommittedClosePolicy = false;
            }
            if (this.m_UncommittedEnabled && this.m_UICloseButton != null)
            {
                this.m_UICloseButton.enabled = enabled;
                this.m_UncommittedEnabled = false;
            }
            if (this.m_UncommittedSelected)
            {
                this.updateTextColor();
                this.m_UncommittedSelected = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UICloseButton = new CustomButton();
                this.m_UICloseButton.enabled = enabled;
                this.m_UICloseButton.styleName = this.getStyle("closeButtonStyle");
                this.m_UICloseButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonEvent);
                this.m_UICloseButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onCloseButtonEvent);
                addChild(this.m_UICloseButton);
                this.updateTextColor();
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = NaN;
            super.measure();
            _loc_1 = this.m_UICloseButton.getExplicitOrMeasuredHeight() + this.getStyle("closeButtonTop");
            var _loc_2:* = this.m_UICloseButton.getExplicitOrMeasuredWidth() + this.getStyle("closeButtonRight");
            if (this.m_ClosePolicy == DynamicTabBar.CLOSE_ALWAYS || this.m_ClosePolicy == DynamicTabBar.CLOSE_SELECTED)
            {
                measuredWidth = measuredWidth + _loc_2;
                measuredMinWidth = measuredMinWidth + _loc_2;
            }
            else if (this.m_ClosePolicy == DynamicTabBar.CLOSE_ROLLOVER)
            {
                measuredWidth = Math.max(measuredWidth, _loc_2);
                measuredMinWidth = Math.max(measuredMinWidth, _loc_2);
            }
            measuredHeight = Math.max(measuredHeight, _loc_1);
            measuredMinHeight = Math.max(measuredMinHeight, _loc_1);
            return;
        }// end function

        override protected function clickHandler(event:MouseEvent) : void
        {
            if (event != null && !enabled)
            {
                event.stopPropagation();
                event.stopImmediatePropagation();
            }
            return;
        }// end function

        override protected function rollOverHandler(event:MouseEvent) : void
        {
            if (event != null && enabled)
            {
                this.m_IsRollOver = true;
                super.rollOverHandler(event);
            }
            return;
        }// end function

        protected function onCloseButtonEvent(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                switch(event.type)
                {
                    case MouseEvent.CLICK:
                    {
                        if (enabled && this.closePolicy != DynamicTabBar.CLOSE_NEVER && (this.closePolicy != DynamicTabBar.CLOSE_SELECTED || selected) && (this.closePolicy != DynamicTabBar.CLOSE_ROLLOVER || this.m_IsRollOver) && this.m_IsEnabled == enabled && this.m_IsSelected == selected)
                        {
                            _loc_2 = new Event(Event.CLOSE, false, true);
                            dispatchEvent(_loc_2);
                            if (!_loc_2.cancelable || !_loc_2.isDefaultPrevented())
                            {
                                this.m_UICloseButton.removeEventListener(MouseEvent.CLICK, this.onCloseButtonEvent);
                                this.m_UICloseButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onCloseButtonEvent);
                            }
                        }
                        break;
                    }
                    case MouseEvent.MOUSE_DOWN:
                    {
                        this.m_IsEnabled = enabled;
                        this.m_IsSelected = selected;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        protected function updateTextColor() : void
        {
            var _loc_1:* = undefined;
            if (selected)
            {
                _loc_1 = this.getStyle("selectedTextColor");
            }
            else
            {
                _loc_1 = this.getStyle("defaultTextColor");
            }
            setStyle("color", _loc_1);
            setStyle("errorColor", _loc_1);
            setStyle("textRollOverColor", _loc_1);
            setStyle("textSelectedColor", _loc_1);
            return;
        }// end function

        override public function set selected(param1:Boolean) : void
        {
            if (selected != param1)
            {
                super.selected = param1;
                this.m_UncommittedSelected = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function getStyle(param1:String)
        {
            var _loc_2:* = NaN;
            switch(param1)
            {
                case "paddingRight":
                {
                    _loc_2 = super.getStyle("paddingRight");
                    if (this.m_ClosePolicy == DynamicTabBar.CLOSE_ALWAYS || this.m_ClosePolicy == DynamicTabBar.CLOSE_SELECTED)
                    {
                        _loc_2 = _loc_2 + (this.m_UICloseButton.getExplicitOrMeasuredWidth() + this.getStyle("closeButtonRight"));
                    }
                    return _loc_2;
                }
                default:
                {
                    return super.getStyle(param1);
                    break;
                }
            }
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            super.updateDisplayList(param1, param2);
            setChildIndex(this.m_UICloseButton, (numChildren - 1));
            if (this.m_ClosePolicy == DynamicTabBar.CLOSE_ALWAYS || this.m_ClosePolicy == DynamicTabBar.CLOSE_SELECTED && selected || this.m_ClosePolicy == DynamicTabBar.CLOSE_ROLLOVER && this.m_IsRollOver)
            {
                _loc_3 = this.m_UICloseButton.getExplicitOrMeasuredWidth();
                _loc_4 = this.m_UICloseButton.getExplicitOrMeasuredHeight();
                _loc_5 = this.getStyle("closeButtonRight");
                _loc_6 = this.getStyle("closeButtonTop");
                this.m_UICloseButton.visible = true;
                this.m_UICloseButton.move(param1 - _loc_3 - _loc_5, _loc_6);
                this.m_UICloseButton.setActualSize(_loc_3, _loc_4);
            }
            else
            {
                this.m_UICloseButton.visible = false;
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
                this.closeButtonRight = 4;
                this.closeButtonStyle = "defaultCloseButtonStyle";
                this.closeButtonTop = 4;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        s_InitializeStyle();
    }
}
