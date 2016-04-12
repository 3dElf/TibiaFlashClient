package tibia.help
{
    import flash.events.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.managers.*;

    public class TransparentHintLayer extends Container
    {
        private static var s_Instance:TransparentHintLayer = null;

        public function TransparentHintLayer()
        {
            this.mouseEnabled = false;
            this.mouseChildren = false;
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        public function hide() : void
        {
            var _loc_1:* = Tibia.s_GetInstance().systemManager;
            if (_loc_1.popUpChildren.contains(this))
            {
                _loc_1.popUpChildren.removeChild(this);
            }
            var _loc_2:* = Tibia.s_GetInstance().m_UITibiaRootContainer;
            if (_loc_2 != null)
            {
                _loc_2.removeEventListener(Event.RESIZE, this.onResize);
            }
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:* = Tibia.s_GetInstance().systemManager;
            _loc_1.popUpChildren.addChild(this);
            var _loc_2:* = Tibia.s_GetInstance().m_UITibiaRootContainer;
            if (_loc_2 != null)
            {
                _loc_2.addEventListener(Event.RESIZE, this.onResize);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = Tibia.s_GetInstance().m_UITibiaRootContainer;
            if (_loc_1 != null)
            {
                measuredMinHeight = _loc_1.height;
                measuredHeight = _loc_1.height;
                measuredMinWidth = Math.max(measuredMinWidth, _loc_1.width);
                measuredWidth = Math.max(measuredWidth, _loc_1.width);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var unscaledWidth:* = param1;
            var unscaledHeight:* = param2;
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var _loc_4:* = this.graphics;
            with (this.graphics)
            {
                clear();
                beginFill(16711680, 0);
                drawRect(0, 0, unscaledWidth, unscaledHeight);
                endFill();
            }
            return;
        }// end function

        public static function getInstance() : TransparentHintLayer
        {
            if (s_Instance == null)
            {
                s_Instance = new TransparentHintLayer;
            }
            return s_Instance;
        }// end function

    }
}
