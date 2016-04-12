package tibia.container.containerViewWidgetClasses
{
    import mx.containers.*;
    import mx.core.*;

    public class ContainerSlotHolder extends Tile
    {
        private var m_MeasuredMaxHeight:Number = NaN;

        public function ContainerSlotHolder()
        {
            direction = TileDirection.HORIZONTAL;
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = null;
            .mx_internal::findCellSize();
            var _loc_1:* = getStyle("horizontalGap");
            var _loc_2:* = getStyle("verticalGap");
            var _loc_3:* = viewMetricsAndPadding;
            var _loc_4:* = numChildren;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_12 = getChildAt(_loc_6) as ContainerSlot;
                if (_loc_12 != null && _loc_12.appearance != null)
                {
                    _loc_5++;
                }
                _loc_6++;
            }
            var _loc_7:* = -1;
            var _loc_8:* = -1;
            var _loc_9:* = -1;
            if (!isNaN(explicitWidth))
            {
                _loc_7 = Math.floor((explicitWidth + _loc_1 - _loc_3.left - _loc_3.right) / (mx_internal::cellWidth + _loc_1));
            }
            if (_loc_7 < 0)
            {
                _loc_7 = Math.floor(Math.sqrt(_loc_4));
            }
            if (_loc_7 < 1)
            {
                _loc_7 = 1;
            }
            _loc_8 = Math.ceil(_loc_4 / _loc_7);
            if (_loc_8 < 1)
            {
                _loc_8 = 1;
            }
            _loc_9 = Math.ceil(_loc_5 / _loc_7);
            if (_loc_9 < 1)
            {
                _loc_9 = 1;
            }
            _loc_10 = _loc_3.left + _loc_3.right;
            _loc_11 = _loc_3.top + _loc_3.bottom;
            measuredMinWidth = _loc_10 + mx_internal::cellWidth;
            measuredWidth = _loc_10 + (_loc_7 - 1) * _loc_1 + _loc_7 * mx_internal::cellWidth;
            measuredMinHeight = _loc_11 + mx_internal::cellHeight;
            measuredHeight = _loc_11 + (_loc_9 - 1) * _loc_2 + _loc_9 * mx_internal::cellHeight;
            this.measuredMaxHeight = _loc_11 + (_loc_8 - 1) * _loc_2 + _loc_8 * mx_internal::cellHeight;
            return;
        }// end function

        public function set measuredMaxHeight(param1:Number) : void
        {
            this.m_MeasuredMaxHeight = param1;
            return;
        }// end function

        public function get measuredMaxHeight() : Number
        {
            return this.m_MeasuredMaxHeight;
        }// end function

    }
}
