package shared.skins
{
    import mx.core.*;
    import mx.skins.*;

    public class VectorDataGridHeaderBackgroundSkin extends ProgrammaticSkin
    {

        public function VectorDataGridHeaderBackgroundSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
        }// end function

        override public function get measuredHeight() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            graphics.clear();
            if (getStyle("borderColor") !== undefined)
            {
                _loc_3 = getStyle("borderColor");
                _loc_4 = getStyle("borderAlpha");
                _loc_5 = getStyle("borderThickness");
                graphics.lineStyle(_loc_5, _loc_3, _loc_4);
                graphics.moveTo(0, param2 - _loc_5);
                graphics.lineTo(param1 - _loc_5, param2 - _loc_5);
                graphics.lineStyle(NaN, 0, NaN);
            }
            if (getStyle("backgroundColor") !== undefined)
            {
                _loc_3 = getStyle("backgroundColor");
                _loc_4 = getStyle("backgroundAlpha");
                graphics.beginFill(_loc_3, _loc_4);
                graphics.drawRect(0, 0, param1, param2 - _loc_5);
                graphics.endFill();
            }
            return;
        }// end function

    }
}
