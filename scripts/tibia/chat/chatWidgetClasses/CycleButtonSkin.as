package tibia.chat.chatWidgetClasses
{
    import shared.skins.*;

    public class CycleButtonSkin extends BitmapButtonSkin
    {

        public function CycleButtonSkin()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            switch(name)
            {
                case "disabledSkin":
                case "selectedDisabledSkin":
                {
                    _loc_3 = getStyle("disabledColor");
                    break;
                }
                case "downSkin":
                case "selectedDownSkin":
                {
                    _loc_3 = getStyle("textSelectedColor");
                    break;
                }
                case "overSkin":
                case "selectedOverSkin":
                {
                    _loc_3 = getStyle("textRollOverColor");
                    break;
                }
                case "upSkin":
                case "selectedUpSkin":
                {
                }
                default:
                {
                    _loc_3 = getStyle("color");
                    break;
                    break;
                }
            }
            var _loc_4:* = getStyle("arrowPadding");
            var _loc_5:* = getStyle("arrowWidth");
            var _loc_6:* = getStyle("arrowHeight");
            graphics.beginFill(_loc_3, 1);
            graphics.moveTo(_loc_4, param2 / 2);
            graphics.lineTo(_loc_4 + _loc_5, (param2 - _loc_6) / 2);
            graphics.lineTo(_loc_4 + _loc_5, (param2 + _loc_6) / 2);
            graphics.endFill();
            graphics.beginFill(_loc_3, 1);
            graphics.moveTo(param1 - _loc_4, param2 / 2);
            graphics.lineTo(param1 - _loc_4 - _loc_5, (param2 + _loc_6) / 2);
            graphics.lineTo(param1 - _loc_4 - _loc_5, (param2 - _loc_6) / 2);
            graphics.endFill();
            return;
        }// end function

    }
}
