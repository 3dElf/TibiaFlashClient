package mx.skins.halo
{
    import flash.display.*;
    import mx.skins.*;
    import mx.styles.*;
    import mx.utils.*;

    public class SliderThumbSkin extends Border
    {
        static const VERSION:String = "3.6.0.21751";
        private static var cache:Object = {};

        public function SliderThumbSkin()
        {
            return;
        }// end function

        override public function get measuredWidth() : Number
        {
            return 12;
        }// end function

        override public function get measuredHeight() : Number
        {
            return 12;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("borderColor");
            var _loc_4:* = getStyle("fillAlphas");
            var _loc_5:* = getStyle("fillColors");
            StyleManager.getColorNames(_loc_5);
            var _loc_6:* = getStyle("themeColor");
            var _loc_7:* = calcDerivedStyles(_loc_6, _loc_3, _loc_5[0], _loc_5[1]);
            var _loc_8:* = graphics;
            _loc_8.clear();
            switch(name)
            {
                case "thumbUpSkin":
                {
                    drawThumbState(param1, param2, [_loc_3, _loc_7.borderColorDrk1], [_loc_5[0], _loc_5[1]], [_loc_4[0], _loc_4[1]], true, true);
                    break;
                }
                case "thumbOverSkin":
                {
                    if (_loc_5.length > 2)
                    {
                        _loc_9 = [_loc_5[2], _loc_5[3]];
                    }
                    else
                    {
                        _loc_9 = [_loc_5[0], _loc_5[1]];
                    }
                    if (_loc_4.length > 2)
                    {
                        _loc_10 = [_loc_4[2], _loc_4[3]];
                    }
                    else
                    {
                        _loc_10 = [_loc_4[0], _loc_4[1]];
                    }
                    drawThumbState(param1, param2, [_loc_7.themeColDrk2, _loc_7.themeColDrk1], _loc_9, _loc_10, true, true);
                    break;
                }
                case "thumbDownSkin":
                {
                    drawThumbState(param1, param2, [_loc_7.themeColDrk2, _loc_7.themeColDrk1], [_loc_7.fillColorPress1, _loc_7.fillColorPress2], [1, 1], true, false);
                    break;
                }
                case "thumbDisabledSkin":
                {
                    drawThumbState(param1, param2, [_loc_3, _loc_7.borderColorDrk1], [_loc_5[0], _loc_5[1]], [Math.max(0, _loc_4[0] - 0.15), Math.max(0, _loc_4[1] - 0.15)], false, false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function drawThumbState(param1:Number, param2:Number, param3:Array, param4:Array, param5:Array, param6:Boolean, param7:Boolean) : void
        {
            var _loc_8:* = graphics;
            var _loc_9:* = getStyle("invertThumbDirection");
            var _loc_10:* = getStyle("invertThumbDirection") ? (param2) : (0);
            var _loc_11:* = _loc_9 ? ((param2 - 1)) : (1);
            var _loc_12:* = _loc_9 ? (param2 - 2) : (2);
            var _loc_13:* = _loc_9 ? (2) : (param2 - 2);
            var _loc_14:* = _loc_9 ? (1) : ((param2 - 1));
            var _loc_15:* = _loc_9 ? (0) : (param2);
            if (_loc_9)
            {
                param3 = [param3[1], param3[0]];
                param4 = [param4[1], param4[0]];
                param5 = [param5[1], param5[0]];
            }
            if (param6)
            {
                _loc_8.beginGradientFill(GradientType.LINEAR, [16777215, 16777215], [0.6, 0.6], [0, 255], verticalGradientMatrix(0, 0, param1, param2));
                _loc_8.moveTo(param1 / 2, _loc_10);
                _loc_8.curveTo(param1 / 2, _loc_10, param1 / 2 - 2, _loc_12);
                _loc_8.lineTo(0, _loc_13);
                _loc_8.curveTo(0, _loc_13, 2, _loc_15);
                _loc_8.lineTo(param1 - 2, _loc_15);
                _loc_8.curveTo(param1 - 2, _loc_15, param1, _loc_13);
                _loc_8.lineTo(param1 / 2 + 2, _loc_12);
                _loc_8.curveTo(param1 / 2 + 2, _loc_12, param1 / 2, _loc_10);
                _loc_8.endFill();
            }
            _loc_8.beginGradientFill(GradientType.LINEAR, param3, [1, 1], [0, 255], verticalGradientMatrix(0, 0, param1, param2));
            _loc_8.moveTo(param1 / 2, _loc_10);
            _loc_8.curveTo(param1 / 2, _loc_10, param1 / 2 - 2, _loc_12);
            _loc_8.lineTo(0, _loc_13);
            _loc_8.curveTo(0, _loc_13, 2, _loc_15);
            _loc_8.lineTo(param1 - 2, _loc_15);
            _loc_8.curveTo(param1 - 2, _loc_15, param1, _loc_13);
            _loc_8.lineTo(param1 / 2 + 2, _loc_12);
            _loc_8.curveTo(param1 / 2 + 2, _loc_12, param1 / 2, _loc_10);
            if (param7)
            {
                _loc_8.moveTo(param1 / 2, _loc_11);
                _loc_8.curveTo(param1 / 2, _loc_10, param1 / 2 - 1, _loc_12);
                _loc_8.lineTo(1, _loc_14);
                _loc_8.curveTo(1, _loc_14, 1, _loc_14);
                _loc_8.lineTo((param1 - 1), _loc_14);
                _loc_8.curveTo((param1 - 1), _loc_14, (param1 - 1), _loc_13);
                _loc_8.lineTo(param1 / 2 + 1, _loc_12);
                _loc_8.curveTo(param1 / 2 + 1, _loc_12, param1 / 2, _loc_11);
                _loc_8.endFill();
            }
            _loc_8.beginGradientFill(GradientType.LINEAR, param4, param5, [0, 255], verticalGradientMatrix(0, 0, param1, param2));
            _loc_8.moveTo(param1 / 2, _loc_11);
            _loc_8.curveTo(param1 / 2, _loc_10, param1 / 2 - 1, _loc_12);
            _loc_8.lineTo(1, _loc_14);
            _loc_8.curveTo(1, _loc_14, 1, _loc_14);
            _loc_8.lineTo((param1 - 1), _loc_14);
            _loc_8.curveTo((param1 - 1), _loc_14, (param1 - 1), _loc_13);
            _loc_8.lineTo(param1 / 2 + 1, _loc_12);
            _loc_8.curveTo(param1 / 2 + 1, _loc_12, param1 / 2, _loc_11);
            _loc_8.endFill();
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
                _loc_6.borderColorDrk1 = ColorUtil.adjustBrightness2(param2, -50);
            }
            return cache[_loc_5];
        }// end function

    }
}
