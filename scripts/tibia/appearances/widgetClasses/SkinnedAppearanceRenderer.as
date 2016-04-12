package tibia.appearances.widgetClasses
{
    import flash.display.*;
    import mx.core.*;
    import mx.styles.*;
    import tibia.appearances.*;

    public class SkinnedAppearanceRenderer extends UIComponent
    {
        private var m_UncommittedHighlighted:Boolean = false;
        private var m_UISkinBackground:IFlexDisplayObject = null;
        private var m_UncommittedAppearance:Boolean = false;
        private var m_Appearance:Object = null;
        private var m_UISkinDisabled:IFlexDisplayObject = null;
        private var m_Highlighted:Boolean = false;
        private var m_UIAppearance:SimpleAppearanceRenderer = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UISkinHighlight:IFlexDisplayObject = null;

        public function SkinnedAppearanceRenderer()
        {
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "backgroundImage":
                {
                    this.m_UISkinBackground = this.updateSkin("backgroundImage");
                    invalidateSize();
                    break;
                }
                case "overlayDisabledImage":
                {
                    this.m_UISkinDisabled = this.updateSkin("overlayDisabledImage");
                    invalidateSize();
                    break;
                }
                case "overlayHighlightImage":
                {
                    this.m_UISkinHighlight = this.updateSkin("overlayHighlightImage");
                    invalidateSize();
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

        public function set appearance(param1) : void
        {
            if (this.m_Appearance != param1)
            {
                this.m_Appearance = param1;
                this.m_UncommittedAppearance = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get highlighted() : Boolean
        {
            return this.m_Highlighted;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            super.commitProperties();
            if (this.m_UncommittedAppearance)
            {
                _loc_1 = Tibia.s_GetAppearanceStorage();
                if (this.m_Appearance is AppearanceInstance)
                {
                    this.m_UIAppearance.appearance = AppearanceInstance(this.m_Appearance);
                }
                else if (this.m_Appearance is AppearanceType && _loc_1 != null)
                {
                    _loc_2 = AppearanceType(this.m_Appearance);
                    this.m_UIAppearance.appearance = _loc_1.createObjectInstance(_loc_2.ID, 0);
                }
                else if (this.m_Appearance is AppearanceTypeRef && _loc_1 != null)
                {
                    _loc_3 = AppearanceTypeRef(this.m_Appearance);
                    this.m_UIAppearance.appearance = _loc_1.createObjectInstance(_loc_3.ID, _loc_3.data);
                }
                else
                {
                    this.m_UIAppearance.appearance = null;
                }
                this.m_UncommittedAppearance = false;
            }
            if (this.m_UncommittedHighlighted)
            {
                this.m_UncommittedHighlighted = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIAppearance = new SimpleAppearanceRenderer();
                this.m_UIAppearance.overlay = false;
                addChild(this.m_UIAppearance);
                this.m_UISkinBackground = this.updateSkin("backgroundImage");
                this.m_UISkinDisabled = this.updateSkin("overlayDisabledImage");
                this.m_UISkinHighlight = this.updateSkin("overlayHighlightImage");
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this.m_UISkinBackground != null)
            {
                _loc_1 = this.m_UISkinBackground.width;
                _loc_2 = this.m_UISkinBackground.height;
            }
            else
            {
                _loc_1 = SimpleAppearanceRenderer.ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                _loc_2 = SimpleAppearanceRenderer.ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
            }
            var _loc_3:* = _loc_1;
            measuredMinWidth = _loc_1;
            measuredWidth = _loc_3;
            var _loc_3:* = _loc_2;
            measuredMinHeight = _loc_2;
            measuredHeight = _loc_3;
            return;
        }// end function

        public function get appearance()
        {
            return this.m_Appearance;
        }// end function

        public function set highlighted(param1:Boolean) : void
        {
            if (this.m_Highlighted != param1)
            {
                this.m_Highlighted = param1;
                this.m_UncommittedHighlighted = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function updateSkin(param1:String) : IFlexDisplayObject
        {
            var _loc_2:* = getChildByName(param1);
            if (_loc_2 != null)
            {
                removeChild(_loc_2);
                _loc_2 = null;
            }
            var _loc_3:* = getStyle(param1) as Class;
            if (_loc_3 != null)
            {
                _loc_2 = DisplayObject(new _loc_3);
                _loc_2.name = param1;
                _loc_2.cacheAsBitmap = true;
                addChild(_loc_2);
            }
            return IFlexDisplayObject(_loc_2);
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            if (this.m_UISkinBackground != null)
            {
                this.m_UISkinBackground.x = (param1 - this.m_UISkinBackground.width) / 2;
                this.m_UISkinBackground.y = (param2 - this.m_UISkinBackground.height) / 2;
                this.m_UISkinBackground.visible = true;
                setChildIndex(DisplayObject(this.m_UISkinBackground), _loc_3++);
            }
            if (this.m_UIAppearance != null)
            {
                _loc_4 = measuredWidth - getStyle("paddingLeft") - getStyle("paddingRight");
                _loc_5 = measuredHeight - getStyle("paddingTop") - getStyle("paddingBottom");
                this.m_UIAppearance.size = Math.min(_loc_4, _loc_5);
                this.m_UIAppearance.x = getStyle("paddingLeft") + (_loc_4 - this.m_UIAppearance.size) / 2;
                this.m_UIAppearance.y = getStyle("paddingTop") + (_loc_5 - this.m_UIAppearance.size) / 2;
                this.m_UIAppearance.visible = true;
                setChildIndex(this.m_UIAppearance, _loc_3++);
            }
            if (this.m_UISkinDisabled != null)
            {
                this.m_UISkinDisabled.x = (param1 - this.m_UISkinDisabled.width) / 2;
                this.m_UISkinDisabled.y = (param2 - this.m_UISkinDisabled.height) / 2;
                this.m_UISkinDisabled.visible = !enabled;
                setChildIndex(DisplayObject(this.m_UISkinDisabled), _loc_3++);
            }
            if (this.m_UISkinHighlight != null)
            {
                this.m_UISkinHighlight.x = (param1 - this.m_UISkinHighlight.width) / 2;
                this.m_UISkinHighlight.y = (param2 - this.m_UISkinHighlight.height) / 2;
                this.m_UISkinHighlight.visible = this.highlighted;
                setChildIndex(DisplayObject(this.m_UISkinHighlight), _loc_3++);
            }
            return;
        }// end function

        private static function initializeStyle() : void
        {
            var Selector:String;
            var Decl:* = StyleManager.getStyleDeclaration(Selector);
            if (Decl == null)
            {
                Decl = new CSSStyleDeclaration();
            }
            Decl.defaultFactory = function () : void
            {
                this.backgroundImage = undefined;
                this.overlayDisabledImage = undefined;
                this.overlayHighlightImage = undefined;
                this.paddingBottom = 2;
                this.paddingLeft = 2;
                this.paddingRight = 2;
                this.paddingTop = 2;
                return;
            }// end function
            ;
            StyleManager.setStyleDeclaration(Selector, Decl, true);
            return;
        }// end function

        initializeStyle();
    }
}
