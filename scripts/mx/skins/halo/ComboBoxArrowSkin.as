package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ComboBoxArrowSkin extends Border
    {
        static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};

        public function ComboBoxArrowSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 22;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 22;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("iconColor");
            var _loc_4:* = getStyle("borderColor");
            var _loc_5:* = getStyle("cornerRadius");
            var _loc_6:* = getStyle("dropdownBorderColor");
            var _loc_7:* = getStyle("fillAlphas");
            var _loc_8:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_8);
            var _loc_9:* = getStyle("highlightAlphas");
            var _loc_10:* = getStyle("themeColor");
            if (!isNaN(_loc_6))
            {
                _loc_4 = _loc_6;
            }
            var _loc_11:* = calcDerivedStyles(_loc_10, _loc_4, _loc_8[0], _loc_8[1]);
            var _loc_12:* = ColorUtil.adjustBrightness2(_loc_4, -50);
            var _loc_13:* = ColorUtil.adjustBrightness2(_loc_10, -25);
            var _loc_14:* = Math.max((_loc_5 - 1), 0);
            var _loc_15:* = {tl:0, tr:_loc_5, bl:0, br:_loc_5};
            var _loc_16:* = {tl:0, tr:_loc_14, bl:0, br:_loc_14};
            var _loc_17:* = true;
            if (name.indexOf("editable") < 0)
            {
                _loc_17 = false;
                var _loc_25:* = _loc_5;
                _loc_15.bl = _loc_5;
                _loc_15.tl = _loc_25;
                var _loc_25:* = _loc_14;
                _loc_16.bl = _loc_14;
                _loc_16.tl = _loc_25;
            }
            var _loc_18:* = graphics;
            _loc_18.clear();
            switch(name)
            {
                case "upSkin":
                case "editableUpSkin":
                {
                    _loc_19 = [_loc_8[0], _loc_8[1]];
                    _loc_20 = [_loc_7[0], _loc_7[1]];
                    drawRoundRect(0, 0, param1, param2, _loc_15, [_loc_4, _loc_12], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_16});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_16, _loc_19, _loc_20, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, {tl:_loc_14, tr:_loc_14, bl:0, br:0}, [16777215, 16777215], _loc_9, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    if (!_loc_17)
                    {
                        drawRoundRect(param1 - 22, 4, 1, param2 - 8, 0, _loc_4, 1);
                        drawRoundRect(param1 - 21, 4, 1, param2 - 8, 0, 16777215, 0.2);
                    }
                    break;
                }
                case "overSkin":
                case "editableOverSkin":
                {
                    if (_loc_8.length > 2)
                    {
                        _loc_21 = [_loc_8[2], _loc_8[3]];
                    }
                    else
                    {
                        _loc_21 = [_loc_8[0], _loc_8[1]];
                    }
                    if (_loc_7.length > 2)
                    {
                        _loc_22 = [_loc_7[2], _loc_7[3]];
                    }
                    else
                    {
                        _loc_22 = [_loc_7[0], _loc_7[1]];
                    }
                    drawRoundRect(0, 0, param1, param2, _loc_15, [_loc_10, _loc_13], 1, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_16});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_16, _loc_21, _loc_22, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, {tl:_loc_14, tr:_loc_14, bl:0, br:0}, [16777215, 16777215], _loc_9, verticalGradientMatrix(0, 0, param1 - 2, (param2 - 2) / 2));
                    if (!_loc_17)
                    {
                        drawRoundRect(param1 - 22, 4, 1, param2 - 8, 0, _loc_11.themeColDrk2, 1);
                        drawRoundRect(param1 - 21, 4, 1, param2 - 8, 0, 16777215, 0.2);
                    }
                    break;
                }
                case "downSkin":
                case "editableDownSkin":
                {
                    drawRoundRect(0, 0, param1, param2, _loc_15, [_loc_10, _loc_13], 1, verticalGradientMatrix(0, 0, param1, param2));
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_16, [_loc_11.fillColorPress1, _loc_11.fillColorPress2], 1, verticalGradientMatrix(1, 1, param1 - 2, param2 - 2));
                    drawRoundRect(1, 1, param1 - 2, (param2 - 2) / 2, {tl:_loc_14, tr:_loc_14, bl:0, br:0}, [16777215, 16777215], _loc_9, verticalGradientMatrix(1, 1, param1 - 2, (param2 - 2) / 2));
                    if (!_loc_17)
                    {
                        drawRoundRect(param1 - 22, 4, 1, param2 - 8, 0, _loc_13, 1);
                        drawRoundRect(param1 - 21, 4, 1, param2 - 8, 0, 16777215, 0.2);
                    }
                    break;
                }
                case "disabledSkin":
                case "editableDisabledSkin":
                {
                    _loc_23 = [_loc_8[0], _loc_8[1]];
                    _loc_24 = [Math.max(0, _loc_7[0] - 0.15), Math.max(0, _loc_7[1] - 0.15)];
                    drawRoundRect(0, 0, param1, param2, _loc_15, [_loc_4, _loc_12], 0.5, verticalGradientMatrix(0, 0, param1, param2), GradientType.LINEAR, null, {x:1, y:1, w:param1 - 2, h:param2 - 2, r:_loc_16});
                    drawRoundRect(1, 1, param1 - 2, param2 - 2, _loc_16, _loc_23, _loc_24, verticalGradientMatrix(0, 0, param1 - 2, param2 - 2));
                    if (!_loc_17)
                    {
                        drawRoundRect(param1 - 22, 4, 1, param2 - 8, 0, 10066329, 0.5);
                    }
                    _loc_3 = getStyle("disabledIconColor");
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_18.beginFill(_loc_3);
            _loc_18.moveTo(param1 - 11.5, param2 / 2 + 3);
            _loc_18.lineTo(param1 - 15, param2 / 2 - 2);
            _loc_18.lineTo(param1 - 8, param2 / 2 - 2);
            _loc_18.lineTo(param1 - 11.5, param2 / 2 + 3);
            _loc_18.endFill();
            return;
        }// end function

        private static function calcDerivedStyles(param1:uint, param2:uint, param3:uint, param4:uint) : Object
        {
            var _loc_6:* = null;
            var _loc_5:* = HaloColors.getCacheKey(param1, param2, param3, param4);
            if (!cache[_loc_5])
            {
                var _loc_7:* = {};
                cache[_loc_5] = {};
                _loc_6 = _loc_7;
                HaloColors.addHaloColors(_loc_6, param1, param3, param4);
            }
            return cache[_loc_5];
        }// end function

    }
}
