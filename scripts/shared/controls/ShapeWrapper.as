package shared.controls
{
    import flash.display.*;
    import flash.geom.*;
    import mx.core.*;

    public class ShapeWrapper extends UIComponent
    {

        public function ShapeWrapper()
        {
            return;
        }// end function

        override public function removeChildren(param1:int = 0, param2:int = 2.14748e+009) : void
        {
            invalidateDisplayList();
            invalidateSize();
            super.removeChildren(param1, param2);
            return;
        }// end function

        override public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
        {
            invalidateDisplayList();
            invalidateSize();
            return super.addChildAt(param1, param2);
        }// end function

        override public function removeChildAt(param1:int) : DisplayObject
        {
            invalidateDisplayList();
            invalidateSize();
            return super.removeChildAt(param1);
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            switch(getStyle("horizontalAlign"))
            {
                case "left":
                {
                    _loc_3 = 0;
                    break;
                }
                case "center":
                {
                    _loc_3 = 1;
                    break;
                }
                case "right":
                {
                    _loc_3 = 2;
                    break;
                }
                default:
                {
                    _loc_3 = 0;
                    break;
                    break;
                }
            }
            switch(getStyle("verticalAlign"))
            {
                case "top":
                {
                    _loc_4 = 0;
                    break;
                }
                case "middle":
                {
                    _loc_4 = 1;
                    break;
                }
                case "bottom":
                {
                    _loc_4 = 2;
                    break;
                }
                default:
                {
                    _loc_4 = 0;
                    break;
                    break;
                }
            }
            var _loc_5:* = numChildren - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = getChildAt(_loc_5);
                _loc_7 = _loc_6.getRect(_loc_6);
                _loc_6.x = _loc_3 * (param1 - _loc_7.width) / 2;
                _loc_6.y = _loc_4 * (param2 - _loc_7.height) / 2;
                _loc_5 = _loc_5 - 1;
            }
            return;
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            invalidateDisplayList();
            invalidateSize();
            return super.removeChild(param1);
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            invalidateDisplayList();
            invalidateSize();
            return super.addChild(param1);
        }// end function

        override protected function measure() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = numChildren - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = getChildAt(_loc_3);
                _loc_5 = _loc_4.getRect(_loc_4);
                _loc_1 = Math.max(_loc_1, _loc_5.width);
                _loc_2 = Math.max(_loc_2, _loc_5.height);
                _loc_3 = _loc_3 - 1;
            }
            var _loc_6:* = _loc_1;
            measuredWidth = _loc_1;
            measuredMinWidth = _loc_6;
            var _loc_6:* = _loc_2;
            measuredHeight = _loc_2;
            measuredMinHeight = _loc_6;
            return;
        }// end function

    }
}
