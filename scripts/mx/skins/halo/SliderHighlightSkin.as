package mx.skins.halo
{
    import mx.skins.*;

    public class SliderHighlightSkin extends Border
    {
        static const VERSION:String = "3.6.0.21751";

        public function SliderHighlightSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 1;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 2;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("themeColor");
            graphics.clear();
            drawRoundRect(0, 0, param1, 1, 0, _loc_3, 0.7);
            drawRoundRect(0, (param2 - 1), param1, 1, 0, _loc_3, 1);
            drawRoundRect(0, param2 - 2, param1, 1, 0, _loc_3, 0.4);
            return;
        }// end function

    }
}
