package shared.skins
{

    public class StyleSizedBitmapButtonSkin extends BitmapButtonSkinBase
    {

        public function StyleSizedBitmapButtonSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            var _loc_1:* = super.measuredWidth;
            var _loc_2:* = getStyle("width");
            if (_loc_2)
            {
                return _loc_2;
            }
            return _loc_1;
        }// end function

        override public function get measuredHeight() : Number
        {
            var _loc_1:* = super.measuredHeight;
            var _loc_2:* = getStyle("height");
            if (_loc_2)
            {
                return _loc_2;
            }
            return _loc_1;
        }// end function

        override protected function doValidateStyle() : void
        {
            super.doValidateStyle();
            switch(name)
            {
                case "disabledSkin":
                {
                    stylePrefix = "defaultDisabled";
                    break;
                }
                case "downSkin":
                {
                    stylePrefix = "defaultDown";
                    break;
                }
                case "upSkin":
                {
                    stylePrefix = "defaultUp";
                    break;
                }
                case "overSkin":
                {
                    stylePrefix = "defaultOver";
                    break;
                }
                case "selectedDisabledSkin":
                {
                    stylePrefix = "selectedDisabled";
                    break;
                }
                case "selectedDownSkin":
                {
                    stylePrefix = "selectedDown";
                    break;
                }
                case "selectedUpSkin":
                {
                    stylePrefix = "selectedUp";
                    break;
                }
                case "selectedOverSkin":
                {
                    stylePrefix = "selectedOver";
                    break;
                }
                default:
                {
                    stylePrefix = null;
                    break;
                    break;
                }
            }
            return;
        }// end function

    }
}
