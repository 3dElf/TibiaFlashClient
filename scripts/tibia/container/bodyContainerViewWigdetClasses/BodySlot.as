package tibia.container.bodyContainerViewWigdetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import tibia.container.containerViewWidgetClasses.*;

    public class BodySlot extends ContainerSlot
    {
        protected var m_StyleEmptyBackgroundValue:Object = null;
        protected var m_UIMouseOver:Boolean = false;
        protected var m_StyleEmptyBackgroundImage:Bitmap = null;

        public function BodySlot()
        {
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseEvent);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseEvent);
            invalidateStyle();
            return;
        }// end function

        override protected function layoutChrome(param1:Graphics, param2:Number, param3:Number) : void
        {
            var _loc_8:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            var _loc_7:* = 1;
            if (appearance != null)
            {
                _loc_4 = m_StyleBackgroundImage;
                _loc_5 = getStyle("backgroundColor") !== undefined;
                _loc_6 = getStyle("backgroundColor");
                _loc_7 = this.getSafeNumericStyle(this.m_UIMouseOver ? ("backgroundOverAlpha") : ("backgroundOutAlpha"), "backgroundAlpha");
            }
            else
            {
                _loc_4 = this.m_StyleEmptyBackgroundImage;
                _loc_5 = getStyle("emptyBackgroundColor") !== undefined;
                _loc_6 = getStyle("emptyBackgroundColor");
                _loc_7 = this.getSafeNumericStyle(this.m_UIMouseOver ? ("emptyBackgroundOverAlpha") : ("emptyBackgroundOutAlpha"), "emptyBackgroundAlpha");
            }
            if (_loc_4 != null)
            {
                _loc_8 = new BitmapData(_loc_4.width, _loc_4.height, true, 0);
                _loc_8.draw(_loc_4, null, new ColorTransform(1, 1, 1, _loc_7, 0, 0, 0, 0), null, null, false);
                param1.clear();
                param1.beginBitmapFill(_loc_8, null, false, false);
                param1.drawRect(0, 0, param2, param3);
                param1.endFill();
            }
            else if (_loc_5)
            {
                param1.clear();
                param1.beginFill(_loc_6, _loc_7);
                param1.drawRect(0, 0, param2, param3);
                param1.endFill();
            }
            return;
        }// end function

        private function getSafeNumericStyle(... args) : Number
        {
            var _loc_4:* = NaN;
            args = 0;
            var _loc_3:* = args.length;
            while (args < _loc_3)
            {
                
                _loc_4 = getStyle(String(args[args]));
                if (!isNaN(_loc_4))
                {
                    return _loc_4;
                }
                args++;
            }
            return NaN;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "emptyBackgroundImage":
                {
                    invalidateStyle();
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

        protected function onMouseEvent(event:MouseEvent) : void
        {
            if (event != null)
            {
                this.m_UIMouseOver = event.type == MouseEvent.ROLL_OVER;
                invalidateDisplayList();
            }
            return;
        }// end function

        override protected function validateStyle() : void
        {
            super.validateStyle();
            var _loc_1:* = getStyle("emptyBackgroundImage") as Class;
            if (this.m_StyleEmptyBackgroundValue != _loc_1)
            {
                this.m_StyleEmptyBackgroundValue = _loc_1;
                this.m_StyleEmptyBackgroundImage = _loc_1 != null ? (Bitmap(new _loc_1)) : (null);
                invalidateDisplayList();
                invalidateSize();
            }
            return;
        }// end function

    }
}
