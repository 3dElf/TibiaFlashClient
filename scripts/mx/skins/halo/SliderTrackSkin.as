package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class SliderTrackSkin extends Border
    {
        static const VERSION:String = "3.6.0.21751";

        public function SliderTrackSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 200;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 4;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderColor");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("trackColors") as Array;
            StyleManager.getColorNames(_loc_5);
            var _loc_6:* = ColorUtil.adjustBrightness2(_loc_3, -50);
            graphics.clear();
            drawRoundRect(0, 0, param1, param2, 0, 0, 0);
            drawRoundRect(1, 0, param1, (param2 - 1), 1.5, _loc_6, 1, null, GradientType.LINEAR, null, {x:2, y:1, w:param1 - 2, h:1, r:0});
            drawRoundRect(2, 1, param1 - 2, param2 - 2, 1, _loc_3, 1, null, GradientType.LINEAR, null, {x:2, y:1, w:param1 - 2, h:1, r:0});
            drawRoundRect(2, 1, param1 - 2, 1, 0, _loc_5, Math.max(_loc_4[1] - 0.3, 0), horizontalGradientMatrix(2, 1, param1 - 2, 1));
            return;
        }// end function

    }
}
