package shared.skins
{
    import mx.core.*;
    import mx.skins.*;

    public class VectorBorderSkin extends ProgrammaticSkin implements IBorder
    {
        protected var m_BorderMetrics:EdgeMetrics;

        public function VectorBorderSkin()
        {
            this.m_BorderMetrics = new EdgeMetrics(1, 1, 1, 1);
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
        }// end function

        public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:* = getStyle("borderColor") !== undefined ? (getStyle("borderThickness")) : (0);
            this.m_BorderMetrics.bottom = _loc_1;
            this.m_BorderMetrics.left = _loc_1;
            this.m_BorderMetrics.right = _loc_1;
            this.m_BorderMetrics.top = _loc_1;
            return this.m_BorderMetrics;
        }// end function

        override public function get measuredHeight() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_HEIGHT;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            if (isNaN(param1) || isNaN(param2))
            {
                return;
            }
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
            }
            if (getStyle("backgroundColor") !== undefined)
            {
                _loc_3 = getStyle("backgroundColor");
                _loc_4 = getStyle("backgroundAlpha");
                graphics.beginFill(_loc_3, _loc_4);
            }
            graphics.drawRect(0, 0, param1 - _loc_5, param2 - _loc_5);
            graphics.lineStyle(NaN, 0, NaN);
            graphics.endFill();
            return;
        }// end function

    }
}
