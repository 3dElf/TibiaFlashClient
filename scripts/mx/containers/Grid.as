package mx.containers
{
    import mx.containers.gridClasses.*;
    import mx.core.*;

    public class Grid extends Box
    {
        private var columnWidths:Array;
        private var rowHeights:Array;
        private var needToRemeasure:Boolean = true;
        static const VERSION:String = "3.6.0.21751";

        public function Grid()
        {
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (needToRemeasure)
            {
                measure();
            }
            super.updateDisplayList(param1, param2);
            var _loc_3:* = 0;
            var _loc_6:* = [];
            var _loc_7:* = 0;
            while (_loc_7 < numChildren)
            {
                
                _loc_5 = GridRow(getChildAt(_loc_7));
                if (_loc_5.includeInLayout)
                {
                    _loc_6.push(_loc_5);
                    _loc_3++;
                }
                _loc_7++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_6[_loc_4];
                rowHeights[_loc_4].y = _loc_5.y;
                rowHeights[_loc_4].height = _loc_5.height;
                _loc_4++;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_6[_loc_4];
                _loc_5.doRowLayout(_loc_5.width * _loc_5.scaleX, _loc_5.height * _loc_5.scaleY);
                _loc_4++;
            }
            return;
        }// end function

        private function distributeItemWidth(param1:GridItem, param2:int, param3:Number, param4:Array) : void
        {
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_5:* = param1.maxWidth;
            var _loc_6:* = param1.getExplicitOrMeasuredWidth();
            var _loc_7:* = param1.minWidth;
            var _loc_8:* = param1.colSpan;
            var _loc_9:* = param1.percentWidth;
            var _loc_10:* = 0;
            var _loc_11:* = false;
            _loc_12 = param2;
            while (_loc_12 < param2 + _loc_8)
            {
                
                _loc_13 = param4[_loc_12];
                _loc_6 = _loc_6 - _loc_13.preferred;
                _loc_7 = _loc_7 - _loc_13.min;
                _loc_10 = _loc_10 + _loc_13.flex;
                _loc_12++;
            }
            if (_loc_8 > 1)
            {
                _loc_14 = param3 * (_loc_8 - 1);
                _loc_6 = _loc_6 - _loc_14;
                _loc_7 = _loc_7 - _loc_14;
            }
            if (_loc_10 == 0)
            {
                _loc_10 = _loc_8;
                _loc_11 = true;
            }
            _loc_6 = _loc_6 > 0 ? (Math.ceil(_loc_6 / _loc_10)) : (0);
            _loc_7 = _loc_7 > 0 ? (Math.ceil(_loc_7 / _loc_10)) : (0);
            _loc_12 = param2;
            while (_loc_12 < param2 + _loc_8)
            {
                
                _loc_13 = param4[_loc_12];
                _loc_15 = _loc_11 ? (1) : (_loc_13.flex);
                _loc_13.preferred = _loc_13.preferred + _loc_6 * _loc_15;
                _loc_13.min = _loc_13.min + _loc_7 * _loc_15;
                if (_loc_9)
                {
                    _loc_13.percent = Math.max(_loc_13.percent, _loc_9 / _loc_8);
                }
                _loc_12++;
            }
            if (_loc_8 == 1 && _loc_5 < _loc_13.max)
            {
                _loc_13.max = _loc_5;
            }
            return;
        }// end function

        private function distributeItemHeight(param1:GridItem, param2:Number, param3:Number, param4:Array) : void
        {
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_5:* = param1.maxHeight;
            var _loc_6:* = param1.getExplicitOrMeasuredHeight();
            var _loc_7:* = param1.minHeight;
            var _loc_8:* = param1.rowSpan;
            var _loc_9:* = 0;
            var _loc_10:* = false;
            _loc_11 = param2;
            while (_loc_11 < param2 + _loc_8)
            {
                
                _loc_12 = param4[_loc_11];
                _loc_6 = _loc_6 - _loc_12.preferred;
                _loc_7 = _loc_7 - _loc_12.min;
                _loc_9 = _loc_9 + _loc_12.flex;
                _loc_11++;
            }
            if (_loc_8 > 1)
            {
                _loc_13 = param3 * (_loc_8 - 1);
                _loc_6 = _loc_6 - _loc_13;
                _loc_7 = _loc_7 - _loc_13;
            }
            if (_loc_9 == 0)
            {
                _loc_9 = _loc_8;
                _loc_10 = true;
            }
            _loc_6 = _loc_6 > 0 ? (Math.ceil(_loc_6 / _loc_9)) : (0);
            _loc_7 = _loc_7 > 0 ? (Math.ceil(_loc_7 / _loc_9)) : (0);
            _loc_11 = param2;
            while (_loc_11 < param2 + _loc_8)
            {
                
                _loc_12 = param4[_loc_11];
                _loc_14 = _loc_10 ? (1) : (_loc_12.flex);
                _loc_12.preferred = _loc_12.preferred + _loc_6 * _loc_14;
                _loc_12.min = _loc_12.min + _loc_7 * _loc_14;
                _loc_11++;
            }
            if (_loc_8 == 1 && _loc_5 < _loc_12.max)
            {
                _loc_12.max = _loc_5;
            }
            return;
        }// end function

        override public function invalidateSize() : void
        {
            if (!isNaN(explicitWidth) && !isNaN(explicitHeight))
            {
                needToRemeasure = true;
            }
            super.invalidateSize();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_12:* = 0;
            var _loc_19:* = NaN;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = 0;
            var _loc_28:* = undefined;
            var _loc_29:* = undefined;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = [];
            var _loc_9:* = [];
            var _loc_10:* = 0;
            while (_loc_10 < numChildren)
            {
                
                _loc_4 = GridRow(getChildAt(_loc_10));
                if (_loc_4.includeInLayout)
                {
                    _loc_9.push(_loc_4);
                    _loc_1++;
                }
                _loc_10++;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_8 = 0;
                _loc_4 = _loc_9[_loc_6];
                _loc_4.numGridItems = _loc_4.numChildren;
                _loc_4.rowIndex = _loc_6;
                _loc_7 = 0;
                while (_loc_7 < _loc_4.numGridItems)
                {
                    
                    if (_loc_6 > 0)
                    {
                        _loc_25 = _loc_3[_loc_8];
                        while (!isNaN(_loc_25) && _loc_25 >= _loc_6)
                        {
                            
                            _loc_8++;
                            _loc_25 = _loc_3[_loc_8];
                        }
                    }
                    _loc_5 = GridItem(_loc_4.getChildAt(_loc_7));
                    _loc_5.colIndex = _loc_8;
                    if (_loc_5.rowSpan > 1)
                    {
                        _loc_26 = _loc_6 + _loc_5.rowSpan - 1;
                        _loc_27 = 0;
                        while (_loc_27 < _loc_5.colSpan)
                        {
                            
                            _loc_3[_loc_8 + _loc_27] = _loc_26;
                            _loc_27++;
                        }
                    }
                    _loc_8 = _loc_8 + _loc_5.colSpan;
                    _loc_7++;
                }
                if (_loc_8 > _loc_2)
                {
                    _loc_2 = _loc_8;
                }
                _loc_6++;
            }
            rowHeights = new Array(_loc_1);
            columnWidths = new Array(_loc_2);
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                rowHeights[_loc_6] = new GridRowInfo();
                _loc_6++;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_2)
            {
                
                columnWidths[_loc_6] = new GridColumnInfo();
                _loc_6++;
            }
            var _loc_11:* = int.MAX_VALUE;
            var _loc_13:* = 1;
            var _loc_14:* = getStyle("horizontalGap");
            var _loc_15:* = getStyle("verticalGap");
            do
            {
                
                _loc_12 = _loc_13;
                _loc_13 = _loc_11;
                _loc_6 = 0;
                while (_loc_6 < _loc_1)
                {
                    
                    _loc_4 = _loc_9[_loc_6];
                    _loc_4.columnWidths = columnWidths;
                    _loc_4.rowHeights = rowHeights;
                    _loc_7 = 0;
                    while (_loc_7 < _loc_4.numGridItems)
                    {
                        
                        _loc_5 = GridItem(_loc_4.getChildAt(_loc_7));
                        _loc_28 = _loc_5.rowSpan;
                        _loc_29 = _loc_5.colSpan;
                        if (_loc_28 == _loc_12)
                        {
                            distributeItemHeight(_loc_5, _loc_6, _loc_15, rowHeights);
                        }
                        else if (_loc_28 > _loc_12 && _loc_28 < _loc_13)
                        {
                            _loc_13 = _loc_28;
                        }
                        if (_loc_29 == _loc_12)
                        {
                            distributeItemWidth(_loc_5, _loc_5.colIndex, _loc_14, columnWidths);
                        }
                        else if (_loc_29 > _loc_12 && _loc_29 < _loc_13)
                        {
                            _loc_13 = _loc_29;
                        }
                        _loc_7++;
                    }
                    _loc_6++;
                }
            }while (_loc_13 < _loc_11)
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = 0;
            _loc_19 = 0;
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_30 = rowHeights[_loc_6];
                if (_loc_30.min > _loc_30.preferred)
                {
                    _loc_30.min = _loc_30.preferred;
                }
                if (_loc_30.max < _loc_30.preferred)
                {
                    _loc_30.max = _loc_30.preferred;
                }
                _loc_17 = _loc_17 + _loc_30.min;
                _loc_19 = _loc_19 + _loc_30.preferred;
                _loc_6++;
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_2)
            {
                
                _loc_31 = columnWidths[_loc_6];
                if (_loc_31.min > _loc_31.preferred)
                {
                    _loc_31.min = _loc_31.preferred;
                }
                if (_loc_31.max < _loc_31.preferred)
                {
                    _loc_31.max = _loc_31.preferred;
                }
                _loc_16 = _loc_16 + _loc_31.min;
                _loc_18 = _loc_18 + _loc_31.preferred;
                _loc_6++;
            }
            var _loc_20:* = viewMetricsAndPadding;
            var _loc_21:* = _loc_20.left + _loc_20.right;
            var _loc_24:* = 0;
            if (_loc_2 > 1)
            {
                _loc_21 = _loc_21 + getStyle("horizontalGap") * (_loc_2 - 1);
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_22 = _loc_9[_loc_6];
                _loc_23 = _loc_22.viewMetricsAndPadding;
                _loc_32 = _loc_23.left + _loc_23.right;
                if (_loc_32 > _loc_24)
                {
                    _loc_24 = _loc_32;
                }
                _loc_6++;
            }
            _loc_21 = _loc_21 + _loc_24;
            _loc_16 = _loc_16 + _loc_21;
            _loc_18 = _loc_18 + _loc_21;
            _loc_21 = _loc_20.top + _loc_20.bottom;
            if (_loc_1 > 1)
            {
                _loc_21 = _loc_21 + getStyle("verticalGap") * (_loc_1 - 1);
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_22 = _loc_9[_loc_6];
                _loc_23 = _loc_22.viewMetricsAndPadding;
                _loc_21 = _loc_21 + (_loc_23.top + _loc_23.bottom);
                _loc_6++;
            }
            _loc_17 = _loc_17 + _loc_21;
            _loc_19 = _loc_19 + _loc_21;
            _loc_6 = 0;
            while (_loc_6 < _loc_1)
            {
                
                _loc_22 = _loc_9[_loc_6];
                _loc_22.updateRowMeasurements();
                _loc_6++;
            }
            super.measure();
            measuredMinWidth = Math.max(measuredMinWidth, _loc_16);
            measuredMinHeight = Math.max(measuredMinHeight, _loc_17);
            measuredWidth = Math.max(measuredWidth, _loc_18);
            measuredHeight = Math.max(measuredHeight, _loc_19);
            needToRemeasure = false;
            return;
        }// end function

    }
}
