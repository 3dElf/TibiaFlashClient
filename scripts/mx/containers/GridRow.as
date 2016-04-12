package mx.containers
{
    import flash.display.*;
    import mx.containers.gridClasses.*;
    import mx.containers.utilityClasses.*;
    import mx.core.*;

    public class GridRow extends HBox
    {
        var rowIndex:int = 0;
        var columnWidths:Array;
        var rowHeights:Array;
        var numGridItems:int;
        static const VERSION:String = "3.6.0.21751";

        public function GridRow()
        {
            super.clipContent = false;
            return;
        }// end function

        override public function getStyle(param1:String)
        {
            return param1 == "horizontalGap" && parent ? (Grid(parent).getStyle("horizontalGap")) : (super.getStyle(param1));
        }// end function

        override public function invalidateDisplayList() : void
        {
            super.invalidateDisplayList();
            if (parent)
            {
                Grid(parent).invalidateDisplayList();
            }
            return;
        }// end function

        override public function get clipContent() : Boolean
        {
            return false;
        }// end function

        override public function set horizontalScrollPolicy(param1:String) : void
        {
            return;
        }// end function

        override public function set clipContent(param1:Boolean) : void
        {
            return;
        }// end function

        function doRowLayout(param1:Number, param2:Number) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            layoutChrome(param1, param2);
            var _loc_3:* = numChildren;
            if (_loc_3 == 0)
            {
                return;
            }
            var _loc_4:* = invalidateSizeFlag;
            var _loc_5:* = invalidateDisplayListFlag;
            invalidateSizeFlag = true;
            invalidateDisplayListFlag = true;
            if (parent.getChildIndex(this) == 0 || isNaN(columnWidths[0].x) || columnWidths.minWidth != minWidth || columnWidths.maxWidth != maxWidth || columnWidths.preferredWidth != getExplicitOrMeasuredWidth() || columnWidths.percentWidth != percentWidth || columnWidths.width != param1 || columnWidths.paddingLeft != getStyle("paddingLeft") || columnWidths.paddingRight != getStyle("paddingRight") || columnWidths.horizontalAlign != getStyle("horizontalAlign") || columnWidths.borderStyle != getStyle("borderStyle"))
            {
                calculateColumnWidths();
                columnWidths.minWidth = minWidth;
                columnWidths.maxWidth = maxWidth;
                columnWidths.preferredWidth = getExplicitOrMeasuredWidth();
                columnWidths.percentWidth = percentWidth;
                columnWidths.width = param1;
                columnWidths.paddingLeft = getStyle("paddingLeft");
                columnWidths.paddingRight = getStyle("paddingRight");
                columnWidths.horizontalAlign = getStyle("horizontalAlign");
                columnWidths.borderStyle = getStyle("borderStyle");
            }
            var _loc_6:* = viewMetricsAndPadding;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_3)
            {
                
                _loc_8 = GridItem(getChildAt(_loc_7));
                _loc_9 = _loc_8.colIndex;
                _loc_10 = columnWidths[_loc_9].x;
                _loc_11 = _loc_6.top;
                _loc_12 = _loc_8.percentHeight;
                _loc_13 = Math.min(_loc_9 + _loc_8.colSpan, columnWidths.length);
                _loc_14 = columnWidths[(_loc_13 - 1)];
                _loc_15 = _loc_14.x + _loc_14.width - _loc_10;
                _loc_16 = Math.min(rowIndex + _loc_8.rowSpan, rowHeights.length);
                _loc_17 = rowHeights[(_loc_16 - 1)];
                _loc_18 = _loc_17.y + _loc_17.height - rowHeights[rowIndex].y - _loc_6.top - _loc_6.bottom;
                _loc_19 = _loc_15 - _loc_8.maxWidth;
                if (_loc_19 > 0)
                {
                    _loc_10 = _loc_10 + _loc_19 * layoutObject.getHorizontalAlignValue();
                    _loc_15 = _loc_15 - _loc_19;
                }
                _loc_19 = _loc_18 - _loc_8.maxHeight;
                if (_loc_12 && _loc_12 < 100)
                {
                    _loc_19 = Math.max(_loc_19, _loc_18 * (100 - _loc_12));
                }
                if (_loc_19 > 0)
                {
                    _loc_11 = _loc_19 * layoutObject.getVerticalAlignValue();
                    _loc_18 = _loc_18 - _loc_19;
                }
                _loc_15 = Math.ceil(_loc_15);
                _loc_18 = Math.ceil(_loc_18);
                _loc_8.move(_loc_10, _loc_11);
                _loc_8.setActualSize(_loc_15, _loc_18);
                _loc_7++;
            }
            invalidateSizeFlag = _loc_4;
            invalidateDisplayListFlag = _loc_5;
            return;
        }// end function

        private function calculateColumnWidths() : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_1:* = viewMetricsAndPadding;
            var _loc_2:* = getStyle("horizontalGap");
            var _loc_3:* = columnWidths.length;
            var _loc_4:* = unscaledWidth - _loc_1.left - _loc_1.right - (_loc_3 - 1) * _loc_2;
            var _loc_9:* = 0;
            var _loc_10:* = [];
            _loc_5 = _loc_4;
            _loc_8 = 0;
            while (_loc_8 < _loc_3)
            {
                
                _loc_6 = columnWidths[_loc_8];
                _loc_11 = _loc_6.percent;
                if (_loc_11)
                {
                    _loc_9 = _loc_9 + _loc_11;
                    _loc_10.push(_loc_6);
                }
                else
                {
                    var _loc_14:* = _loc_6.preferred;
                    _loc_6.width = _loc_6.preferred;
                    _loc_12 = _loc_14;
                    _loc_5 = _loc_5 - _loc_12;
                }
                _loc_8++;
            }
            if (_loc_9)
            {
                _loc_5 = Flex.flexChildrenProportionally(_loc_4, _loc_5, _loc_9, _loc_10);
                _loc_13 = _loc_10.length;
                _loc_8 = 0;
                while (_loc_8 < _loc_13)
                {
                    
                    _loc_6 = _loc_10[_loc_8];
                    _loc_6.width = _loc_6.size;
                    _loc_8++;
                }
            }
            _loc_7 = _loc_1.left + _loc_5 * layoutObject.getHorizontalAlignValue();
            _loc_8 = 0;
            while (_loc_8 < _loc_3)
            {
                
                _loc_6 = columnWidths[_loc_8];
                _loc_6.x = _loc_7;
                _loc_7 = _loc_7 + (_loc_6.width + _loc_2);
                _loc_8++;
            }
            return;
        }// end function

        override public function get horizontalScrollPolicy() : String
        {
            return ScrollPolicy.OFF;
        }// end function

        override public function invalidateSize() : void
        {
            super.invalidateSize();
            if (parent)
            {
                Grid(parent).invalidateSize();
            }
            return;
        }// end function

        function updateRowMeasurements() : void
        {
            var _loc_6:* = NaN;
            var _loc_8:* = null;
            var _loc_1:* = columnWidths.length;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_1)
            {
                
                _loc_8 = columnWidths[_loc_4];
                _loc_2 = _loc_2 + _loc_8.min;
                _loc_3 = _loc_3 + _loc_8.preferred;
                _loc_4++;
            }
            var _loc_5:* = layoutObject.widthPadding(_loc_1);
            _loc_6 = layoutObject.heightPadding(0);
            var _loc_7:* = rowHeights[rowIndex];
            measuredMinWidth = _loc_2 + _loc_5;
            measuredMinHeight = _loc_7.min + _loc_6;
            measuredWidth = _loc_3 + _loc_5;
            measuredHeight = _loc_7.preferred + _loc_6;
            return;
        }// end function

        override public function set verticalScrollPolicy(param1:String) : void
        {
            return;
        }// end function

        override public function get verticalScrollPolicy() : String
        {
            return ScrollPolicy.OFF;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            return;
        }// end function

        override public function setChildIndex(param1:DisplayObject, param2:int) : void
        {
            super.setChildIndex(param1, param2);
            Grid(parent).invalidateSize();
            Grid(parent).invalidateDisplayList();
            return;
        }// end function

    }
}
