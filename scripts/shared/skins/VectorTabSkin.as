package shared.skins
{
    import flash.display.*;
    import mx.core.*;
    import mx.skins.*;

    public class VectorTabSkin extends Border
    {
        protected var m_BorderMetrics:EdgeMetrics;

        public function VectorTabSkin()
        {
            this.m_BorderMetrics = new EdgeMetrics(1, 1, 1, 1);
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return UIComponent.DEFAULT_MEASURED_MIN_WIDTH;
        }// end function

        private function getTabIndex() : int
        {
            var _loc_1:* = parent;
            var _loc_2:* = _loc_1 != null ? (_loc_1.parent) : (null);
            return _loc_2 != null ? (_loc_2.getChildIndex(_loc_1)) : (-1);
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:* = Math.max(getStyle("defaultBorderThickness"), getStyle("selectedBorderThickness"));
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
            var _loc_10:* = 0;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = this.getTabIndex() > 0;
            var _loc_9:* = false;
            switch(name)
            {
                case "selectedDisabledSkin":
                case "selectedDownSkin":
                case "selectedOverSkin":
                case "selectedUpSkin":
                {
                    _loc_3 = getStyle("selectedBorderAlpha");
                    _loc_6 = getStyle("selectedBorderColor");
                    _loc_4 = getStyle("selectedBorderThickness");
                    _loc_5 = getStyle("selectedBackgroundAlpha");
                    _loc_7 = getStyle("selectedBackgroundColor");
                    _loc_9 = true;
                    break;
                }
                case "disabledSkin":
                case "downSkin":
                case "overSkin":
                {
                    _loc_10 = 0;
                }
                case "upSkin":
                {
                }
                default:
                {
                    _loc_3 = getStyle("defaultBorderAlpha");
                    _loc_6 = getStyle("defaultBorderColor");
                    _loc_4 = getStyle("defaultBorderThickness");
                    _loc_5 = getStyle("defaultBackgroundAlpha");
                    _loc_7 = getStyle("defaultBackgroundColor");
                    break;
                    break;
                }
            }
            graphics.clear();
            graphics.beginFill(_loc_7, _loc_5);
            graphics.drawRect(_loc_4, _loc_4, param1 - 2 * _loc_4, param2 - 2 * _loc_4);
            graphics.endFill();
            graphics.lineStyle(_loc_4, _loc_6, _loc_3);
            graphics.moveTo(param1 - _loc_4, param2 - _loc_4);
            graphics.lineTo(param1 - _loc_4, 0);
            if (!_loc_8 || _loc_9)
            {
                graphics.lineTo(0, 0);
                graphics.lineTo(0, param2 - _loc_4);
            }
            else
            {
                graphics.lineTo(_loc_4, 0);
            }
            return;
        }// end function

    }
}
