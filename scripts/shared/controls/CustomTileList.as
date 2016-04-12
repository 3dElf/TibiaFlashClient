package shared.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.styles.*;

    public class CustomTileList extends TileList
    {

        public function CustomTileList()
        {
            return;
        }// end function

        override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, param7.x, param7.y, param4, param5, getStyle("backgroundAlpha"), param6, param7, false);
            return;
        }// end function

        override protected function drawTileBackgrounds() : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_1:* = Sprite(listContent.getChildByName("tileBGs"));
            if (_loc_1 == null)
            {
                _loc_1 = new FlexSprite();
                _loc_1.mouseChildren = false;
                _loc_1.mouseEnabled = false;
                _loc_1.name = "tileBGs";
                listContent.addChildAt(_loc_1, 0);
            }
            var _loc_2:* = _loc_1.numChildren;
            var _loc_3:* = 0;
            var _loc_4:* = getStyle("alternatingItemColors");
            var _loc_5:* = getStyle("alternatingItemAlphas");
            if (_loc_4 == null || _loc_4.length == 0 || _loc_5 == null || _loc_5.length != _loc_4.length)
            {
                while (--_loc_2 > 0)
                {
                    
                    _loc_1.removeChildAt(--_loc_2);
                }
                return;
            }
            StyleManager.getColorNames(_loc_4);
            var _loc_6:* = 0;
            while (_loc_6 < rowCount)
            {
                
                _loc_7 = 0;
                while (_loc_7 < columnCount)
                {
                    
                    _loc_8 = _loc_6 * columnCount + _loc_7;
                    _loc_9 = (verticalScrollPosition + _loc_6) * columnCount + (horizontalScrollPosition + _loc_7);
                    _loc_10 = null;
                    if (_loc_8 < _loc_1.numChildren)
                    {
                        _loc_10 = Shape(_loc_1.getChildAt(_loc_8));
                    }
                    else
                    {
                        _loc_10 = new FlexShape();
                        _loc_10.name = "tileBackground";
                        _loc_1.addChild(_loc_10);
                    }
                    _loc_11 = _loc_4[_loc_9 % _loc_4.length];
                    _loc_12 = _loc_5[_loc_9 % _loc_5.length];
                    _loc_13 = Math.min(rowHeight, listContent.height - (rowCount - 1) * rowHeight);
                    _loc_14 = Math.min(columnWidth, listContent.width - (columnCount - 1) * columnWidth);
                    _loc_15 = _loc_10.graphics;
                    _loc_15.clear();
                    _loc_15.beginFill(_loc_11, _loc_12);
                    _loc_15.drawRect(0, 0, _loc_14, _loc_13);
                    _loc_15.endFill();
                    _loc_10.x = _loc_7 * columnWidth;
                    _loc_10.y = _loc_6 * rowHeight;
                    _loc_7++;
                }
                _loc_6++;
            }
            _loc_2 = _loc_1.numChildren;
            _loc_3 = rowCount * columnCount;
            while (--_loc_2 > _loc_3)
            {
                
                _loc_1.removeChildAt(--_loc_2);
            }
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, param7.x, param7.y, param4, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = null;
            if (event.keyCode == Keyboard.SPACE)
            {
                _loc_2 = indexToRow(caretIndex);
                _loc_3 = indexToColumn(caretIndex);
                _loc_4 = _loc_2 - verticalScrollPosition >= 0 && _loc_2 - verticalScrollPosition < listItems.length;
                _loc_5 = _loc_4 && _loc_3 - horizontalScrollPosition >= 0 && _loc_3 - horizontalScrollPosition < listItems[_loc_2 - verticalScrollPosition].length;
                if (_loc_4 && _loc_5)
                {
                    _loc_6 = listItems[_loc_2 - verticalScrollPosition][_loc_3 - horizontalScrollPosition];
                    selectItem(_loc_6, event.shiftKey, event.ctrlKey);
                }
            }
            else
            {
                super.keyDownHandler(event);
            }
            return;
        }// end function

        private function drawIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint, param8:IListItemRenderer, param9:Boolean) : void
        {
            var _loc_10:* = param1.graphics;
            _loc_10.clear();
            if (param9)
            {
                _loc_10.beginFill(param7, param6);
                _loc_10.drawRect(0, 0, param4, param5);
                _loc_10.endFill();
            }
            else
            {
                _loc_10.lineStyle(1, param7, param6);
                _loc_10.drawRect(0, 0, (param4 - 1), (param5 - 1));
            }
            param1.x = param2;
            param1.y = param3;
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, param7.x, param7.y, param4, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

    }
}
