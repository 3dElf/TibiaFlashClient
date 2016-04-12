package tibia.game
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.managers.*;

    public class FocusNotifier extends UIComponent
    {
        private var m_UILabel:Label = null;
        private var m_CaptureMouse:Boolean = false;
        private var m_IsShown:Boolean = false;
        private static var s_Instance:FocusNotifier = null;
        private static const BUNDLE:String = "Global";

        public function FocusNotifier()
        {
            mouseEnabled = false;
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = Tibia.s_GetInstance();
            if (_loc_1 != null)
            {
                measuredMinHeight = Math.max(measuredMinHeight, _loc_1.height);
                measuredHeight = Math.max(measuredHeight, _loc_1.height);
                measuredMinWidth = Math.max(measuredMinWidth, _loc_1.width);
                measuredWidth = Math.max(measuredWidth, _loc_1.width);
            }
            return;
        }// end function

        public function get isShown() : Boolean
        {
            return this.m_IsShown;
        }// end function

        public function hide(param1:Boolean = true) : void
        {
            var _loc_2:* = null;
            if (this.captureMouse && param1)
            {
                setTimeout(this.hide, 50, false);
            }
            else if (this.m_IsShown)
            {
                _loc_2 = Tibia.s_GetInstance().systemManager;
                _loc_2.removeEventListener(Event.RESIZE, this.onResize);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEvent);
                _loc_2.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onMouseEvent);
                _loc_2.removeChildFromSandboxRoot("popUpChildren", this);
                this.m_IsShown = false;
                if (Tibia.s_GetInputHandler() != null)
                {
                    Tibia.s_GetInputHandler().captureKeyboard = true;
                }
                if (PopUpBase.getCurrent() != null)
                {
                    PopUpBase.getCurrent().setFocus();
                    PopUpBase.getCurrent().drawFocus(false);
                }
            }
            return;
        }// end function

        private function onMouseEvent(event:MouseEvent) : void
        {
            if (this.isShown && this.captureMouse)
            {
                event.preventDefault();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            super.updateDisplayList(param1, param2);
            graphics.clear();
            if (getStyle("modalTransparencyColor") !== undefined)
            {
                _loc_3 = getStyle("modalTransparencyColor");
                _loc_4 = getStyle("modalTransparency");
                graphics.beginFill(_loc_3, _loc_4);
                graphics.drawRect(0, 0, param1, param2);
                graphics.endFill();
            }
            if (this.m_UILabel != null)
            {
                _loc_5 = this.m_UILabel.getExplicitOrMeasuredHeight();
                _loc_6 = this.m_UILabel.getExplicitOrMeasuredWidth();
                this.m_UILabel.move((param1 - _loc_6) / 2, (param2 - _loc_5) / 4);
                this.m_UILabel.setActualSize(_loc_6, _loc_5);
            }
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            invalidateDisplayList();
            invalidateSize();
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UILabel = new Label();
            this.m_UILabel.styleName = this;
            this.m_UILabel.text = resourceManager.getString(BUNDLE, "MSG_CLICK_TO_ACTIVATE");
            addChild(this.m_UILabel);
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:* = null;
            if (!this.m_IsShown)
            {
                if (Tibia.s_GetInputHandler() != null)
                {
                    Tibia.s_GetInputHandler().captureKeyboard = false;
                }
                _loc_1 = Tibia.s_GetInstance().systemManager;
                _loc_1.addChildToSandboxRoot("popUpChildren", this);
                _loc_1.addEventListener(Event.RESIZE, this.onResize);
                _loc_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseEvent);
                _loc_1.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onMouseEvent);
                this.m_IsShown = true;
            }
            return;
        }// end function

        public function set captureMouse(param1:Boolean) : void
        {
            this.m_CaptureMouse = param1;
            return;
        }// end function

        public function get captureMouse() : Boolean
        {
            return this.m_CaptureMouse;
        }// end function

        public static function getInstance() : FocusNotifier
        {
            if (s_Instance == null)
            {
                s_Instance = new FocusNotifier;
            }
            return s_Instance;
        }// end function

    }
}
