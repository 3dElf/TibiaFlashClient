package shared.controls
{
    import flash.display.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.styles.*;

    public class CustomDataGrid extends DataGrid
    {

        public function CustomDataGrid()
        {
            return;
        }// end function

        override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, param2, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, false);
            return;
        }// end function

        override protected function drawRowGraphics(param1:ListBaseContentHolder) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = null;
            var _loc_2:* = Sprite(param1.getChildByName("rowBGs"));
            if (_loc_2 == null)
            {
                _loc_2 = new FlexSprite();
                _loc_2.mouseChildren = false;
                _loc_2.mouseEnabled = false;
                _loc_2.name = "rowBGs";
                param1.addChildAt(_loc_2, 0);
            }
            var _loc_3:* = _loc_2.numChildren;
            var _loc_4:* = getStyle("alternatingItemColors");
            var _loc_5:* = getStyle("alternatingItemAlphas");
            if (_loc_4 == null || _loc_4.length == 0 || _loc_5 == null || _loc_5.length != _loc_4.length)
            {
                while (--_loc_3 > 0)
                {
                    
                    _loc_2.removeChildAt(--_loc_3);
                }
                return;
            }
            StyleManager.getColorNames(_loc_4);
            var _loc_6:* = 0;
            var _loc_7:* = verticalScrollPosition;
            var _loc_8:* = param1.listItems.length;
            while (_loc_6 < _loc_8)
            {
                
                _loc_9 = null;
                if (_loc_6 < _loc_2.numChildren)
                {
                    _loc_9 = Shape(_loc_2.getChildAt(_loc_6));
                }
                else
                {
                    _loc_9 = new FlexShape();
                    _loc_9.name = "rowBackground";
                    _loc_2.addChild(_loc_9);
                }
                _loc_10 = _loc_4[_loc_7 % _loc_4.length];
                _loc_11 = _loc_5[_loc_7 % _loc_5.length];
                _loc_12 = 0;
                _loc_13 = param1.rowInfo[_loc_6].y;
                _loc_14 = Math.min(param1.rowInfo[_loc_6].height, param1.height - param1.rowInfo[_loc_6].y);
                _loc_15 = param1.width;
                _loc_16 = _loc_9.graphics;
                _loc_16.clear();
                _loc_16.beginFill(_loc_10, _loc_11);
                _loc_16.drawRect(0, 0, _loc_15, _loc_14);
                _loc_16.endFill();
                _loc_9.x = _loc_12;
                _loc_9.y = _loc_13;
                _loc_6++;
                _loc_7++;
            }
            do
            {
                
                _loc_2.removeChildAt((_loc_3 - 1));
                var _loc_17:* = _loc_2.numChildren;
                _loc_3 = _loc_2.numChildren;
            }while (_loc_17 > _loc_8)
            return;
        }// end function

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, param2, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
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
            this.drawIndicator(param1, param2, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

    }
}
