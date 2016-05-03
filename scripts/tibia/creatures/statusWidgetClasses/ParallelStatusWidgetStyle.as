package tibia.creatures.statusWidgetClasses
{
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class ParallelStatusWidgetStyle extends BoxLayout
    {
        public static const DIRECTION_LEFT_TO_RIGHT:String = "lr";
        public static const DIRECTION_BOTTOM_TO_TOP:String = "bt";
        public static const DIRECTION_RIGHT_TO_LEFT:String = "rl";
        public static const DIRECTION_TOP_TO_BOTTOM:String = "tb";
        public static const DIRECTION_AUTO:String = "a";

        public function ParallelStatusWidgetStyle()
        {
            return;
        }// end function

        override public function measure() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_10:* = null;
            _loc_1 = target.viewMetricsAndPadding;
            _loc_2 = 0;
            var _loc_3:* = 0;
            _loc_4 = 0;
            _loc_5 = 0;
            var _loc_6:* = target.getStyle("horizontalGap");
            var _loc_7:* = target.getStyle("horizontalBigGap");
            var _loc_8:* = target.getStyle("verticalGap");
            var _loc_9:* = target.getStyle("verticalBigGap");
            _loc_10 = BitmapProgressBar(target.getChildByName("hitpoints"));
            var _loc_11:* = _loc_10.getStyle("paddingBottom");
            var _loc_12:* = BitmapProgressBar(target.getChildByName("mana"));
            var _loc_13:* = SkillProgressBar(target.getChildByName("skill"));
            var _loc_14:* = StateRenderer(target.getChildByName("state"));
            _loc_3 = Math.max(_loc_10.measuredMinWidth, _loc_12.measuredMinWidth, _loc_14.measuredMinWidth) + _loc_7;
            _loc_2 = Math.max(_loc_10.getExplicitOrMeasuredWidth(), _loc_12.getExplicitOrMeasuredWidth(), _loc_14.getExplicitOrMeasuredWidth()) + _loc_7;
            _loc_5 = _loc_10.measuredMinHeight - _loc_11 + _loc_12.measuredMinHeight + _loc_8;
            _loc_4 = _loc_10.getExplicitOrMeasuredHeight() - _loc_11 + _loc_12.getExplicitOrMeasuredHeight() + _loc_8 + _loc_14.getExplicitOrMeasuredHeight();
            if (_loc_13.includeInLayout)
            {
                _loc_3 = Math.max(_loc_3, _loc_13.measuredMinWidth);
                _loc_2 = Math.max(_loc_2, _loc_13.getExplicitOrMeasuredWidth());
                _loc_5 = _loc_5 + (_loc_13.measuredMinHeight + _loc_8);
                _loc_4 = _loc_4 + (_loc_13.getExplicitOrMeasuredHeight() + _loc_8);
            }
            target.measuredMinWidth = _loc_3 + _loc_1.left + _loc_1.right;
            target.measuredWidth = _loc_2 + _loc_1.left + _loc_1.right;
            target.measuredMinHeight = _loc_5 + _loc_1.top + _loc_1.bottom;
            target.measuredHeight = _loc_4 + _loc_1.top + _loc_1.bottom;
            return;
        }// end function

        override public function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_12:* = null;
            var _loc_3:* = target.viewMetricsAndPadding;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = target.getStyle("horizontalGap");
            var _loc_7:* = target.getStyle("horizontalBigGap");
            var _loc_8:* = target.getStyle("verticalGap");
            var _loc_9:* = target.getStyle("verticalBigGap");
            var _loc_10:* = param1 - _loc_3.left - _loc_3.right;
            var _loc_11:* = param2 - _loc_3.top - _loc_3.bottom;
            _loc_12 = BitmapProgressBar(target.getChildByName("hitpoints"));
            var _loc_13:* = target.getStyle("hitpointsOffsetY");
            var _loc_14:* = _loc_12.getStyle("paddingBottom");
            var _loc_15:* = BitmapProgressBar(target.getChildByName("mana"));
            var _loc_16:* = target.getStyle("manaOffsetY");
            var _loc_17:* = SkillProgressBar(target.getChildByName("skill"));
            var _loc_18:* = StateRenderer(target.getChildByName("state"));
            var _loc_19:* = _loc_3.top;
            var _loc_20:* = direction == DIRECTION_TOP_TO_BOTTOM ? (DIRECTION_RIGHT_TO_LEFT) : (DIRECTION_LEFT_TO_RIGHT);
            _loc_5 = _loc_12.getExplicitOrMeasuredHeight() - _loc_14;
            _loc_12.direction = _loc_20;
            _loc_12.move(_loc_3.left + _loc_7 / 2, _loc_19 + _loc_13);
            _loc_12.setActualSize(_loc_10 - _loc_7, _loc_5);
            _loc_19 = _loc_19 + (_loc_13 + _loc_5);
            _loc_5 = _loc_15.getExplicitOrMeasuredHeight();
            _loc_15.direction = _loc_20;
            _loc_15.move(_loc_3.left + _loc_7 / 2, _loc_19 + _loc_16);
            _loc_15.setActualSize(_loc_10 - _loc_7, _loc_5);
            _loc_19 = _loc_19 + (_loc_16 + _loc_5 + _loc_8);
            if (_loc_17.includeInLayout)
            {
                _loc_5 = _loc_17.getExplicitOrMeasuredHeight();
                _loc_17.progressDirection = _loc_20;
                _loc_17.move(_loc_3.left, _loc_19);
                _loc_17.setActualSize(_loc_10, _loc_5);
                _loc_19 = _loc_19 + (_loc_5 + _loc_8);
            }
            _loc_5 = _loc_18.getExplicitOrMeasuredHeight();
            _loc_4 = _loc_18.getExplicitOrMeasuredWidth();
            _loc_18.move(_loc_3.left + (_loc_10 - _loc_4) / 2, _loc_19);
            _loc_18.setActualSize(_loc_4, _loc_5);
            return;
        }// end function

    }
}
