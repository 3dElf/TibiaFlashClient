package shared.skins
{
    import mx.core.*;
    import mx.skins.*;

    public class VectorDataGridHeaderSeparatorSkin extends ProgrammaticSkin
    {

        public function VectorDataGridHeaderSeparatorSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 1 + getStyle("borderThickness");
        }// end function

        override public function get measuredHeight() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            graphics.clear();
            if (getStyle("borderColor") !== undefined)
            {
                _loc_3 = getStyle("borderColor");
                _loc_4 = getStyle("borderAlpha");
                _loc_5 = getStyle("borderThickness");
                graphics.lineStyle(_loc_5, _loc_3, _loc_4);
                graphics.moveTo(param1 - _loc_5, 0);
                graphics.lineTo(param1 - _loc_5, param2 - _loc_5);
                graphics.lineStyle(NaN, 0, NaN);
            }
            return;
        }// end function

    }
}
