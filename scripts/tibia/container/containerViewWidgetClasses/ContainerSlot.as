package tibia.container.containerViewWidgetClasses
{
    import flash.display.*;
    import mx.core.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;

    public class ContainerSlot extends UIComponent
    {
        protected var m_UIAppearanceRenderer:SimpleAppearanceRenderer = null;
        protected var m_StyleBackgroundImage:Bitmap = null;
        private var m_UncommittedAppearance:Boolean = true;
        protected var m_Appearance:AppearanceInstance = null;
        protected var m_Position:int = 0;
        private var m_UncommittedPosition:Boolean = true;
        protected var m_StyleBackgroundValue:Object = null;
        private var m_InvalidStyle:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private static const DEFAULT_ICON_SIZE:int = 32;

        public function ContainerSlot()
        {
            this.invalidateStyle();
            return;
        }// end function

        protected function validateStyle() : void
        {
            var _loc_1:* = getStyle("backgroundImage") as Class;
            if (this.m_StyleBackgroundValue != _loc_1)
            {
                this.m_StyleBackgroundValue = _loc_1;
                this.m_StyleBackgroundImage = _loc_1 != null ? (Bitmap(new _loc_1)) : (null);
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "backgroundImage":
                {
                    this.invalidateStyle();
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

        protected function layoutChrome(param1:Graphics, param2:Number, param3:Number) : void
        {
            param1.clear();
            if (this.m_StyleBackgroundImage != null)
            {
                param1.beginBitmapFill(this.m_StyleBackgroundImage.bitmapData, null, true, false);
            }
            else if (getStyle("backgroundColor") !== undefined)
            {
                param1.beginFill(getStyle("backgroundColor"), getStyle("backgroundAlpha"));
            }
            param1.drawRect(0, 0, param2, param3);
            param1.endFill();
            return;
        }// end function

        public function set appearance(param1:AppearanceInstance) : void
        {
            if (param1 != this.m_Appearance)
            {
                this.m_Appearance = param1;
                this.m_UncommittedAppearance = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedAppearance)
            {
                this.m_UIAppearanceRenderer.appearance = this.m_Appearance;
                invalidateDisplayList();
                this.m_UncommittedAppearance = false;
            }
            if (this.m_UncommittedPosition)
            {
                invalidateDisplayList();
                this.m_UncommittedPosition = false;
            }
            if (this.m_InvalidStyle)
            {
                this.validateStyle();
                this.m_InvalidStyle = false;
            }
            return;
        }// end function

        public function set position(param1:int) : void
        {
            if (param1 != this.m_Position)
            {
                this.m_Position = param1;
                this.m_UncommittedPosition = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            this.validateStyle();
            if (this.m_StyleBackgroundImage != null)
            {
                var _loc_1:* = this.m_StyleBackgroundImage.width;
                measuredWidth = this.m_StyleBackgroundImage.width;
                measuredMinWidth = _loc_1;
                var _loc_1:* = this.m_StyleBackgroundImage.height;
                measuredHeight = this.m_StyleBackgroundImage.height;
                measuredMinHeight = _loc_1;
            }
            else
            {
                var _loc_1:* = DEFAULT_ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredWidth = DEFAULT_ICON_SIZE + getStyle("paddingLeft") + getStyle("paddingRight");
                measuredMinWidth = _loc_1;
                var _loc_1:* = DEFAULT_ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredHeight = DEFAULT_ICON_SIZE + getStyle("paddingTop") + getStyle("paddingBottom");
                measuredMinHeight = _loc_1;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIAppearanceRenderer = new SimpleAppearanceRenderer();
                this.m_UIAppearanceRenderer.overlay = true;
                this.m_UIAppearanceRenderer.size = DEFAULT_ICON_SIZE;
                this.m_UIAppearanceRenderer.smooth = false;
                addChild(this.m_UIAppearanceRenderer);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get position() : int
        {
            return this.m_Position;
        }// end function

        public function get appearance() : AppearanceInstance
        {
            return this.m_Appearance;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            this.validateStyle();
            this.layoutChrome(graphics, param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingTop");
            var _loc_5:* = param1 - _loc_3 - getStyle("paddingRight");
            var _loc_6:* = param2 - _loc_4 - getStyle("paddingBottom");
            var _loc_7:* = Math.min(_loc_5, _loc_6);
            this.m_UIAppearanceRenderer.x = _loc_3 + (_loc_5 - _loc_7) / 2;
            this.m_UIAppearanceRenderer.y = _loc_4 + (_loc_6 - _loc_7) / 2;
            this.m_UIAppearanceRenderer.size = _loc_7;
            this.m_UIAppearanceRenderer.draw();
            return;
        }// end function

        protected function invalidateStyle() : void
        {
            this.m_InvalidStyle = true;
            invalidateProperties();
            return;
        }// end function

    }
}
