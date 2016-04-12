package shared.controls
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.styles.*;

    public class CustomList extends List
    {

        public function CustomList()
        {
            return;
        }// end function

        override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, false);
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
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

        override protected function drawRowBackgrounds() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_1:* = Sprite(listContent.getChildByName("rowBGs"));
            if (_loc_1 == null)
            {
                _loc_1 = new FlexSprite();
                _loc_1.mouseChildren = false;
                _loc_1.mouseEnabled = false;
                _loc_1.name = "rowBGs";
                listContent.addChildAt(_loc_1, 0);
            }
            var _loc_2:* = _loc_1.numChildren;
            var _loc_3:* = getStyle("alternatingItemColors");
            var _loc_4:* = getStyle("alternatingItemAlphas");
            if (_loc_3 == null || _loc_3.length == 0 || _loc_4 == null || _loc_4.length != _loc_3.length)
            {
                while (--_loc_2 > 0)
                {
                    
                    _loc_1.removeChildAt(--_loc_2);
                }
                return;
            }
            StyleManager.getColorNames(_loc_3);
            var _loc_5:* = 0;
            var _loc_6:* = verticalScrollPosition;
            var _loc_7:* = listItems.length;
            while (_loc_5 < _loc_7)
            {
                
                _loc_8 = null;
                if (_loc_5 < _loc_1.numChildren)
                {
                    _loc_8 = Shape(_loc_1.getChildAt(_loc_5));
                }
                else
                {
                    _loc_8 = new FlexShape();
                    _loc_8.name = "rowBackground";
                    _loc_1.addChild(_loc_8);
                }
                _loc_9 = _loc_3[_loc_6 % _loc_3.length];
                _loc_10 = _loc_4[_loc_6 % _loc_4.length];
                _loc_11 = 0;
                _loc_12 = rowInfo[_loc_5].y;
                _loc_13 = Math.min(rowInfo[_loc_5].height, listContent.height - rowInfo[_loc_5].y);
                _loc_14 = listContent.width;
                _loc_15 = _loc_8.graphics;
                _loc_15.clear();
                _loc_15.beginFill(_loc_9, _loc_10);
                _loc_15.drawRect(0, 0, _loc_14, _loc_13);
                _loc_15.endFill();
                _loc_8.x = _loc_11;
                _loc_8.y = _loc_12;
                _loc_5++;
                _loc_6++;
            }
            do
            {
                
                _loc_1.removeChildAt((_loc_2 - 1));
                var _loc_16:* = _loc_1.numChildren;
                _loc_2 = _loc_1.numChildren;
            }while (_loc_16 > _loc_7)
            return;
        }// end function

    }
}
