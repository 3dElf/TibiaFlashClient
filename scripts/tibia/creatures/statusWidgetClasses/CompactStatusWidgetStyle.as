package tibia.creatures.statusWidgetClasses
{
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class CompactStatusWidgetStyle extends BoxLayout
    {
        public static const DIRECTION_LEFT_TO_RIGHT:String = "lr";
        public static const DIRECTION_BOTTOM_TO_TOP:String = "bt";
        public static const DIRECTION_RIGHT_TO_LEFT:String = "rl";
        public static const DIRECTION_TOP_TO_BOTTOM:String = "tb";
        public static const DIRECTION_AUTO:String = "a";

        public function CompactStatusWidgetStyle()
        {
            return;
        }// end function

        override public function measure() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            _loc_1 = target.viewMetricsAndPadding;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_4 = 0;
            _loc_5 = 0;
            var _loc_6:* = target.getStyle("horizontalGap");
            var _loc_7:* = target.getStyle("horizontalBigGap");
            var _loc_8:* = target.getStyle("verticalGap");
            var _loc_9:* = target.getStyle("verticalBigGap");
            var _loc_10:* = BitmapProgressBar(target.getChildByName("hitpoints"));
            var _loc_11:* = target.getStyle("hitpointsOffsetX");
            var _loc_12:* = target.getStyle("hitpointsOffsetY");
            var _loc_13:* = BitmapProgressBar(target.getChildByName("mana"));
            var _loc_14:* = target.getStyle("manaOffsetX");
            var _loc_15:* = target.getStyle("manaOffsetY");
            var _loc_16:* = SkillProgressBar(target.getChildByName("skill"));
            var _loc_17:* = StateRenderer(target.getChildByName("state"));
            _loc_3 = _loc_10.measuredMinWidth + _loc_11 + _loc_7 + _loc_17.measuredMinWidth + _loc_7 + _loc_13.measuredMinWidth + _loc_14;
            _loc_2 = _loc_10.getExplicitOrMeasuredWidth() + _loc_11 + _loc_7 + _loc_17.getExplicitOrMeasuredWidth() + _loc_7 + _loc_13.getExplicitOrMeasuredWidth() + _loc_14;
            _loc_5 = Math.max(_loc_10.measuredMinHeight + _loc_12, _loc_17.measuredMinHeight, _loc_13.measuredMinHeight + _loc_15);
            _loc_4 = Math.max(_loc_10.getExplicitOrMeasuredHeight() + _loc_12, _loc_17.getExplicitOrMeasuredHeight(), _loc_13.getExplicitOrMeasuredHeight() + _loc_15);
            if (_loc_16.includeInLayout)
            {
                _loc_3 = Math.max(_loc_3, _loc_16.measuredMinWidth);
                _loc_2 = Math.max(_loc_2, _loc_16.getExplicitOrMeasuredWidth());
                _loc_5 = _loc_5 + (_loc_8 + _loc_16.measuredMinHeight);
                _loc_4 = _loc_4 + (_loc_8 + _loc_16.getExplicitOrMeasuredHeight());
            }
            else
            {
                _loc_18 = target.getStyle("paddingBottom");
                _loc_19 = Math.max(_loc_10.getStyle("paddingBottom"), _loc_13.getStyle("paddingBottom"));
                _loc_5 = _loc_5 - (_loc_18 + _loc_19);
                _loc_4 = _loc_4 - (_loc_18 + _loc_19);
            }
            target.measuredMinWidth = _loc_3 + _loc_1.left + _loc_1.right;
            target.measuredWidth = _loc_2 + _loc_1.left + _loc_1.right;
            target.measuredMinHeight = _loc_5 + _loc_1.top + _loc_1.bottom;
            target.measuredHeight = _loc_4 + _loc_1.top + _loc_1.bottom;
            return;
        }// end function

        override public function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_11:* = null;
            var _loc_15:* = null;
            var _loc_3:* = target.borderMetrics;
            var _loc_4:* = target.viewMetricsAndPadding;
            var _loc_5:* = target.getStyle("horizontalGap");
            var _loc_6:* = target.getStyle("horizontalBigGap");
            var _loc_7:* = target.getStyle("verticalGap");
            var _loc_8:* = target.getStyle("verticalBigGap");
            var _loc_9:* = param1 - _loc_4.left - _loc_4.right;
            var _loc_10:* = param2 - _loc_4.top - _loc_4.bottom;
            _loc_11 = BitmapProgressBar(target.getChildByName("hitpoints"));
            var _loc_12:* = target.getStyle("hitpointsOffsetX");
            var _loc_13:* = target.getStyle("hitpointsOffsetY");
            var _loc_14:* = _loc_11.getStyle("paddingBottom");
            _loc_15 = BitmapProgressBar(target.getChildByName("mana"));
            var _loc_16:* = target.getStyle("manaOffsetX");
            var _loc_17:* = target.getStyle("manaOffsetY");
            var _loc_18:* = _loc_15.getStyle("paddingBottom");
            var _loc_19:* = SkillProgressBar(target.getChildByName("skill"));
            var _loc_20:* = StateRenderer(target.getChildByName("state"));
            var _loc_21:* = Math.max(_loc_20.getExplicitOrMeasuredWidth(), _loc_20.measuredMinWidth);
            var _loc_22:* = Math.round((_loc_9 - _loc_21 - 2 * _loc_6) / 2);
            var _loc_23:* = Math.max(_loc_11.getExplicitOrMeasuredHeight() + _loc_13 - _loc_14, _loc_15.getExplicitOrMeasuredHeight() + _loc_17 - _loc_18);
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            _loc_25 = _loc_11.getExplicitOrMeasuredHeight();
            if (!_loc_19.includeInLayout)
            {
                _loc_25 = _loc_25 - _loc_14;
            }
            _loc_11.direction = DIRECTION_LEFT_TO_RIGHT;
            _loc_11.move(_loc_4.left + _loc_12, _loc_4.top + _loc_13);
            _loc_11.setActualSize(_loc_22, _loc_25);
            _loc_26 = _loc_25 + _loc_13;
            _loc_25 = _loc_15.getExplicitOrMeasuredHeight();
            if (!_loc_19.includeInLayout)
            {
                _loc_25 = _loc_25 - _loc_18;
            }
            _loc_15.direction = DIRECTION_RIGHT_TO_LEFT;
            _loc_15.move(_loc_4.left + _loc_9 - _loc_22 + _loc_16, _loc_4.top + _loc_17);
            _loc_15.setActualSize(_loc_22, _loc_25);
            _loc_26 = _loc_4.top + Math.max(_loc_26, _loc_25 + _loc_17) + _loc_7;
            _loc_25 = _loc_20.getExplicitOrMeasuredHeight();
            _loc_20.move(_loc_4.left + _loc_22 + _loc_6, _loc_4.top + (_loc_23 - _loc_25) / 2);
            _loc_20.setActualSize(_loc_21, _loc_25);
            if (_loc_19.includeInLayout)
            {
                _loc_25 = _loc_19.getExplicitOrMeasuredHeight();
                _loc_19.progressDirection = direction == DIRECTION_TOP_TO_BOTTOM ? (DIRECTION_RIGHT_TO_LEFT) : (DIRECTION_LEFT_TO_RIGHT);
                _loc_19.move(_loc_4.left, _loc_26);
                _loc_19.setActualSize(_loc_9, _loc_25);
            }
            return;
        }// end function

    }
}
