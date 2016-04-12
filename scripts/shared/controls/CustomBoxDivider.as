package shared.controls
{
    import mx.containers.*;
    import mx.containers.dividedBoxClasses.*;
    import mx.core.*;
    import shared.skins.*;

    public class CustomBoxDivider extends BoxDivider
    {
        private var m_Background:BitmapGrid;
        private var m_Knob:BitmapGrid;

        public function CustomBoxDivider()
        {
            this.m_Background = new BitmapGrid(null, "dividerBackground");
            this.m_Knob = new BitmapGrid(null, "dividerKnob");
            return;
        }// end function

        override public function set styleName(param1:Object) : void
        {
            super.styleName = param1;
            this.m_Background.styleName = param1;
            this.m_Knob.styleName = param1;
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            alpha = mx_internal::state == DividerState.DOWN ? (0.5) : (1);
            graphics.clear();
            this.m_Background.drawGrid(graphics, 0, 0, param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = this.m_Knob.measuredHeight;
            var _loc_6:* = this.m_Knob.measuredWidth;
            switch(getStyle("dividerKnobAlignment"))
            {
                case "top":
                {
                    _loc_3 = (param1 - _loc_6) / 2;
                    _loc_4 = 0;
                    break;
                }
                case "topLeft":
                {
                    _loc_3 = 0;
                    _loc_4 = 0;
                    break;
                }
                case "left":
                {
                    _loc_3 = 0;
                    _loc_4 = (param2 - _loc_5) / 2;
                    break;
                }
                case "bottomLeft":
                {
                    _loc_3 = 0;
                    _loc_4 = param2 - _loc_5;
                    break;
                }
                case "bottom":
                {
                    _loc_3 = (param1 - _loc_6) / 2;
                    _loc_4 = param2 - _loc_5;
                    break;
                }
                case "bottomRight":
                {
                    _loc_3 = param1 - _loc_6;
                    _loc_4 = param2 - _loc_5;
                    break;
                }
                case "right":
                {
                    _loc_3 = param1 - _loc_6;
                    _loc_4 = (param2 - _loc_5) / 2;
                    break;
                }
                case "topRight":
                {
                    _loc_3 = param1 - _loc_6;
                    _loc_4 = 0;
                    break;
                }
                case "center":
                {
                }
                default:
                {
                    _loc_3 = (param1 - _loc_6) / 2;
                    _loc_4 = (param2 - _loc_5) / 2;
                    break;
                    break;
                }
            }
            this.m_Knob.drawGrid(graphics, _loc_3, _loc_4, _loc_6, _loc_5);
            graphics.endFill();
            return;
        }// end function

    }
}
