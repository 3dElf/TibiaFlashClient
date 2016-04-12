package mx.containers
{
    import flash.events.*;
    import mx.core.*;

    public class Tile extends Container
    {
        private var _direction:String = "horizontal";
        var cellWidth:Number;
        var cellHeight:Number;
        private var _tileHeight:Number;
        private var _tileWidth:Number;
        static const VERSION:String = "3.6.0.21751";

        public function Tile()
        {
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            super.measure();
            findCellSize();
            _loc_3 = cellWidth;
            _loc_4 = cellHeight;
            var _loc_5:* = numChildren;
            var _loc_6:* = numChildren;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5)
            {
                
                if (!IUIComponent(getChildAt(_loc_7)).includeInLayout)
                {
                    _loc_6 = _loc_6 - 1;
                }
                _loc_7++;
            }
            _loc_5 = _loc_6;
            if (_loc_5 > 0)
            {
                _loc_11 = getStyle("horizontalGap");
                _loc_12 = getStyle("verticalGap");
                if (direction == TileDirection.HORIZONTAL)
                {
                    _loc_15 = explicitWidth / Math.abs(scaleX);
                    if (!isNaN(_loc_15))
                    {
                        _loc_13 = Math.floor((_loc_15 + _loc_11) / (cellWidth + _loc_11));
                    }
                }
                else
                {
                    _loc_16 = explicitHeight / Math.abs(scaleY);
                    if (!isNaN(_loc_16))
                    {
                        _loc_13 = Math.floor((_loc_16 + _loc_12) / (cellHeight + _loc_12));
                    }
                }
                if (isNaN(_loc_13))
                {
                    _loc_13 = Math.ceil(Math.sqrt(_loc_5));
                }
                if (_loc_13 < 1)
                {
                    _loc_13 = 1;
                }
                _loc_14 = Math.ceil(_loc_5 / _loc_13);
                if (direction == TileDirection.HORIZONTAL)
                {
                    _loc_1 = _loc_13 * cellWidth + (_loc_13 - 1) * _loc_11;
                    _loc_2 = _loc_14 * cellHeight + (_loc_14 - 1) * _loc_12;
                }
                else
                {
                    _loc_1 = _loc_14 * cellWidth + (_loc_14 - 1) * _loc_11;
                    _loc_2 = _loc_13 * cellHeight + (_loc_13 - 1) * _loc_12;
                }
            }
            else
            {
                _loc_1 = _loc_3;
                _loc_2 = _loc_4;
            }
            var _loc_8:* = viewMetricsAndPadding;
            var _loc_9:* = _loc_8.left + _loc_8.right;
            var _loc_10:* = _loc_8.top + _loc_8.bottom;
            _loc_3 = _loc_3 + _loc_9;
            _loc_1 = _loc_1 + _loc_9;
            _loc_4 = _loc_4 + _loc_10;
            _loc_2 = _loc_2 + _loc_10;
            measuredMinWidth = Math.ceil(_loc_3);
            measuredMinHeight = Math.ceil(_loc_4);
            measuredWidth = Math.ceil(_loc_1);
            measuredHeight = Math.ceil(_loc_2);
            return;
        }// end function

        public function set tileHeight(param1:Number) : void
        {
            _tileHeight = param1;
            invalidateSize();
            return;
        }// end function

        function calcHorizontalOffset(param1:Number, param2:String) : Number
        {
            var _loc_3:* = NaN;
            if (param2 == "left")
            {
                _loc_3 = 0;
            }
            else if (param2 == "center")
            {
                _loc_3 = (cellWidth - param1) / 2;
            }
            else if (param2 == "right")
            {
                _loc_3 = cellWidth - param1;
            }
            return _loc_3;
        }// end function

        function calcVerticalOffset(param1:Number, param2:String) : Number
        {
            var _loc_3:* = NaN;
            if (param2 == "top")
            {
                _loc_3 = 0;
            }
            else if (param2 == "middle")
            {
                _loc_3 = (cellHeight - param1) / 2;
            }
            else if (param2 == "bottom")
            {
                _loc_3 = cellHeight - param1;
            }
            return _loc_3;
        }// end function

        public function set tileWidth(param1:Number) : void
        {
            _tileWidth = param1;
            invalidateSize();
            return;
        }// end function

        public function get tileHeight() : Number
        {
            return _tileHeight;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            super.updateDisplayList(param1, param2);
            if (isNaN(cellWidth) || isNaN(cellHeight))
            {
                findCellSize();
            }
            var _loc_3:* = viewMetricsAndPadding;
            var _loc_4:* = getStyle("paddingLeft");
            var _loc_5:* = getStyle("paddingTop");
            var _loc_6:* = getStyle("horizontalGap");
            var _loc_7:* = getStyle("verticalGap");
            var _loc_8:* = getStyle("horizontalAlign");
            var _loc_9:* = getStyle("verticalAlign");
            var _loc_10:* = _loc_4;
            var _loc_11:* = _loc_5;
            var _loc_14:* = numChildren;
            if (direction == TileDirection.HORIZONTAL)
            {
                _loc_17 = Math.ceil(param1) - _loc_3.right;
                _loc_15 = 0;
                while (_loc_15 < _loc_14)
                {
                    
                    _loc_16 = IUIComponent(getChildAt(_loc_15));
                    if (!_loc_16.includeInLayout)
                    {
                    }
                    else
                    {
                        if (_loc_10 + cellWidth > _loc_17)
                        {
                            if (_loc_10 != _loc_4)
                            {
                                _loc_11 = _loc_11 + (cellHeight + _loc_7);
                                _loc_10 = _loc_4;
                            }
                        }
                        setChildSize(_loc_16);
                        _loc_12 = Math.floor(calcHorizontalOffset(_loc_16.width, _loc_8));
                        _loc_13 = Math.floor(calcVerticalOffset(_loc_16.height, _loc_9));
                        _loc_16.move(_loc_10 + _loc_12, _loc_11 + _loc_13);
                        _loc_10 = _loc_10 + (cellWidth + _loc_6);
                    }
                    _loc_15++;
                }
            }
            else
            {
                _loc_18 = Math.ceil(param2) - _loc_3.bottom;
                _loc_15 = 0;
                while (_loc_15 < _loc_14)
                {
                    
                    _loc_16 = IUIComponent(getChildAt(_loc_15));
                    if (!_loc_16.includeInLayout)
                    {
                    }
                    else
                    {
                        if (_loc_11 + cellHeight > _loc_18)
                        {
                            if (_loc_11 != _loc_5)
                            {
                                _loc_10 = _loc_10 + (cellWidth + _loc_6);
                                _loc_11 = _loc_5;
                            }
                        }
                        setChildSize(_loc_16);
                        _loc_12 = Math.floor(calcHorizontalOffset(_loc_16.width, _loc_8));
                        _loc_13 = Math.floor(calcVerticalOffset(_loc_16.height, _loc_9));
                        _loc_16.move(_loc_10 + _loc_12, _loc_11 + _loc_13);
                        _loc_11 = _loc_11 + (cellHeight + _loc_7);
                    }
                    _loc_15++;
                }
            }
            cellWidth = NaN;
            cellHeight = NaN;
            return;
        }// end function

        public function get tileWidth() : Number
        {
            return _tileWidth;
        }// end function

        private function setChildSize(param1:IUIComponent) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (param1.percentWidth > 0)
            {
                _loc_2 = Math.min(cellWidth, cellWidth * param1.percentWidth / 100);
            }
            else
            {
                _loc_2 = param1.getExplicitOrMeasuredWidth();
                if (_loc_2 > cellWidth)
                {
                    _loc_4 = isNaN(param1.explicitWidth) ? (0) : (param1.explicitWidth);
                    _loc_5 = isNaN(param1.explicitMinWidth) ? (0) : (param1.explicitMinWidth);
                    _loc_2 = _loc_4 > cellWidth || _loc_5 > cellWidth ? (Math.max(_loc_5, _loc_4)) : (cellWidth);
                }
            }
            if (param1.percentHeight > 0)
            {
                _loc_3 = Math.min(cellHeight, cellHeight * param1.percentHeight / 100);
            }
            else
            {
                _loc_3 = param1.getExplicitOrMeasuredHeight();
                if (_loc_3 > cellHeight)
                {
                    _loc_4 = isNaN(param1.explicitHeight) ? (0) : (param1.explicitHeight);
                    _loc_5 = isNaN(param1.explicitMinHeight) ? (0) : (param1.explicitMinHeight);
                    _loc_3 = _loc_4 > cellHeight || _loc_5 > cellHeight ? (Math.max(_loc_5, _loc_4)) : (cellHeight);
                }
            }
            param1.setActualSize(_loc_2, _loc_3);
            return;
        }// end function

        function findCellSize() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_1:* = !isNaN(tileWidth);
            var _loc_2:* = !isNaN(tileHeight);
            if (_loc_1 && _loc_2)
            {
                cellWidth = tileWidth;
                cellHeight = tileHeight;
                return;
            }
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = numChildren;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = IUIComponent(getChildAt(_loc_6));
                if (!_loc_7.includeInLayout)
                {
                }
                else
                {
                    _loc_8 = _loc_7.getExplicitOrMeasuredWidth();
                    if (_loc_8 > _loc_3)
                    {
                        _loc_3 = _loc_8;
                    }
                    _loc_9 = _loc_7.getExplicitOrMeasuredHeight();
                    if (_loc_9 > _loc_4)
                    {
                        _loc_4 = _loc_9;
                    }
                }
                _loc_6++;
            }
            cellWidth = _loc_1 ? (tileWidth) : (_loc_3);
            cellHeight = _loc_2 ? (tileHeight) : (_loc_4);
            return;
        }// end function

        public function set direction(param1:String) : void
        {
            _direction = param1;
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("directionChanged"));
            return;
        }// end function

        public function get direction() : String
        {
            return _direction;
        }// end function

    }
}
