package tibia.controls.dynamicTabBarClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.controls.menuClasses.*;
    import mx.controls.scrollClasses.*;
    import mx.core.*;
    import mx.managers.*;
    import mx.styles.*;

    public class TabBarMenu extends Menu
    {

        public function TabBarMenu()
        {
            setStyle("openDuration", 0);
            return;
        }// end function

        override protected function drawCaretIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, false);
            return;
        }// end function

        override protected function configureScrollBars() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_1:* = listItems.length;
            if (_loc_1 == 0)
            {
                return;
            }
            var _loc_4:* = listItems.length;
            while (_loc_1 > 1 && rowInfo[(_loc_4 - 1)].y + rowInfo[(_loc_4 - 1)].height > listContent.height - listContent.bottomOffset)
            {
                
                _loc_1 = _loc_1 - 1;
                _loc_4 = _loc_4 - 1;
            }
            var _loc_5:* = verticalScrollPosition - lockedRowCount - 1;
            var _loc_6:* = 0;
            while (_loc_1 && listItems[(_loc_1 - 1)].length == 0)
            {
                
                if (collection && _loc_1 + _loc_5 >= collection.length)
                {
                    _loc_1 = _loc_1 - 1;
                    _loc_6++;
                    continue;
                }
                break;
            }
            if (listContent.topOffset)
            {
                _loc_2 = Math.abs(listContent.topOffset);
                _loc_3 = 0;
                while (rowInfo[_loc_3].y + rowInfo[_loc_3].height <= _loc_2)
                {
                    
                    _loc_1 = _loc_1 - 1;
                    _loc_3++;
                    if (_loc_3 == _loc_1)
                    {
                        break;
                    }
                }
            }
            var _loc_7:* = listItems[0].length;
            var _loc_8:* = horizontalScrollBar;
            var _loc_9:* = verticalScrollBar;
            var _loc_10:* = Math.round(unscaledWidth);
            var _loc_11:* = collection ? (collection.length - lockedRowCount) : (0);
            var _loc_12:* = _loc_1 - lockedRowCount;
            setScrollBarProperties(isNaN(_maxHorizontalScrollPosition) ? (Math.round(listContent.width)) : (Math.round(_maxHorizontalScrollPosition + _loc_10)), _loc_10, _loc_11, _loc_12);
            maxVerticalScrollPosition = Math.max(_loc_11 - _loc_12, 0);
            return;
        }// end function

        override public function get verticalScrollPolicy() : String
        {
            return _verticalScrollPolicy;
        }// end function

        override protected function drawRowBackgrounds() : void
        {
            var _loc_1:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            _loc_1 = Sprite(listContent.getChildByName("rowBGs"));
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

        override protected function drawSelectionIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

        override public function set verticalScrollPolicy(param1:String) : void
        {
            var _loc_2:* = null;
            if (_verticalScrollPolicy != param1)
            {
                _verticalScrollPolicy = param1;
                _loc_2 = new Event("verticalScrollPolicyChanged");
                dispatchEvent(_loc_2);
                invalidateDisplayList();
                invalidateSize();
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

        public function openSubMenu(param1:IListItemRenderer) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = getRootMenu();
            if (IMenuItemRenderer(param1).menu == null)
            {
                _loc_3 = new TabBarMenu();
                _loc_3.maxHeight = maxHeight;
                _loc_3.verticalScrollPolicy = this.verticalScrollPolicy;
                _loc_3.parentMenu = this;
                _loc_3.owner = this;
                _loc_3.showRoot = showRoot;
                _loc_3.dataDescriptor = _loc_2.dataDescriptor;
                _loc_3.styleName = _loc_2;
                _loc_3.labelField = _loc_2.labelField;
                _loc_3.labelFunction = _loc_2.labelFunction;
                _loc_3.iconField = _loc_2.iconField;
                _loc_3.iconFunction = _loc_2.iconFunction;
                _loc_3.itemRenderer = _loc_2.itemRenderer;
                _loc_3.rowHeight = _loc_2.rowHeight;
                _loc_3.scaleY = _loc_2.scaleY;
                _loc_3.scaleX = _loc_2.scaleX;
                if (param1.data && _dataDescriptor.isBranch(param1.data) && _dataDescriptor.hasChildren(param1.data))
                {
                    _loc_3.dataProvider = _dataDescriptor.getChildren(param1.data);
                }
                _loc_3.sourceMenuBar = sourceMenuBar;
                _loc_3.sourceMenuBarItem = sourceMenuBarItem;
                IMenuItemRenderer(param1).menu = _loc_3;
                PopUpManager.addPopUp(_loc_3, _loc_2, false);
            }
            super.openSubMenu(param1);
            return;
        }// end function

        override public function show(param1:Object = null, param2:Object = null) : void
        {
            super.show(param1, param2);
            if (stage != null && !isNaN(Number(param2)))
            {
                maxHeight = stage.stageHeight - Number(param2);
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            if (!isNaN(maxHeight) && measuredHeight > maxHeight)
            {
                measuredHeight = maxHeight;
                measuredMinHeight = Math.min(measuredMinHeight, maxHeight);
                measuredWidth = measuredWidth + ScrollBar.THICKNESS;
                measuredMinWidth = measuredMinWidth + ScrollBar.THICKNESS;
            }
            return;
        }// end function

        override protected function drawHighlightIndicator(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:uint, param7:IListItemRenderer) : void
        {
            this.drawIndicator(param1, viewMetrics.left, param3, unscaledWidth - viewMetrics.left - viewMetrics.right, param5, getStyle("backgroundAlpha"), param6, param7, true);
            return;
        }// end function

        public static function s_CreateMenu(param1:DisplayObjectContainer, param2:Object, param3:Boolean = true) : TabBarMenu
        {
            var _loc_4:* = new TabBarMenu;
            _loc_4.tabEnabled = false;
            _loc_4.owner = DisplayObjectContainer(Application.application);
            _loc_4.showRoot = param3;
            Menu.popUpMenu(_loc_4, param1, param2);
            return _loc_4;
        }// end function

    }
}
