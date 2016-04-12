package tibia.worldmap.widgetClasses
{
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import shared.utility.*;

    public class OnscreenMessageCache extends BitmapCache
    {
        private var m_TextField:TextField = null;
        private static var s_Matrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);

        public function OnscreenMessageCache(param1:Number, param2:Number, param3:uint)
        {
            super(param1, param2, param3);
            this.m_TextField = new TextField();
            this.m_TextField.autoSize = TextFieldAutoSize.LEFT;
            this.m_TextField.height = slotHeight - 2;
            this.m_TextField.defaultTextFormat = new TextFormat("Verdana", 11, 0, true);
            this.m_TextField.filters = [new GlowFilter(0, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false)];
            this.m_TextField.width = slotWidth - 2;
            this.m_TextField.wordWrap = true;
            return;
        }// end function

        override protected function addItem(param1:Rectangle, param2:Array) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            if (param2 != null && param2.length == 1)
            {
                this.m_TextField.htmlText = param2[0] as String;
                _loc_3 = Math.min(slotHeight, this.m_TextField.textHeight + 2);
                _loc_4 = Math.min(slotWidth, this.m_TextField.textWidth + 2);
                param1.height = _loc_3;
                param1.width = _loc_4;
                s_Matrix.tx = param1.x - Math.floor((slotWidth - _loc_4) / 2);
                s_Matrix.ty = param1.y - 2;
                draw(this.m_TextField, s_Matrix, null, null, null, false);
            }
            return;
        }// end function

    }
}
