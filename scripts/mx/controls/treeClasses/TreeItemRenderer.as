package mx.controls.treeClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;

    public class TreeItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent
    {
        protected var disclosureIcon:IFlexDisplayObject;
        private var _listData:TreeListData;
        private var _data:Object;
        protected var label:IUITextField;
        private var listOwner:Tree;
        protected var icon:IFlexDisplayObject;
        static const VERSION:String = "3.6.0.21751";

        public function TreeItemRenderer()
        {
            return;
        }// end function

        public function set fontContext(param1:IFlexModuleFactory) : void
        {
            this.moduleFactory = param1;
            return;
        }// end function

        function getLabel() : IUITextField
        {
            return label;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.commitProperties();
            if (hasFontContextChanged() && label != null)
            {
                _loc_1 = getChildIndex(DisplayObject(label));
                removeLabel();
                createLabel(_loc_1);
            }
            if (icon)
            {
                removeChild(DisplayObject(icon));
                icon = null;
            }
            if (disclosureIcon)
            {
                disclosureIcon.removeEventListener(MouseEvent.MOUSE_DOWN, disclosureMouseDownHandler);
                removeChild(DisplayObject(disclosureIcon));
                disclosureIcon = null;
            }
            if (_data != null)
            {
                listOwner = Tree(_listData.owner);
                if (_listData.disclosureIcon)
                {
                    _loc_2 = _listData.disclosureIcon;
                    _loc_3 = new _loc_2;
                    if (!(_loc_3 is InteractiveObject))
                    {
                        _loc_4 = new SpriteAsset();
                        _loc_4.addChild(_loc_3 as DisplayObject);
                        disclosureIcon = _loc_4 as IFlexDisplayObject;
                    }
                    else
                    {
                        disclosureIcon = _loc_3;
                    }
                    addChild(disclosureIcon as DisplayObject);
                    disclosureIcon.addEventListener(MouseEvent.MOUSE_DOWN, disclosureMouseDownHandler);
                }
                if (_listData.icon)
                {
                    _loc_5 = _listData.icon;
                    icon = new _loc_5;
                    addChild(DisplayObject(icon));
                }
                label.text = _listData.label;
                label.multiline = listOwner.variableRowHeight;
                label.wordWrap = listOwner.wordWrap;
            }
            else
            {
                label.text = " ";
                toolTip = null;
            }
            invalidateDisplayList();
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return label.y + label.baselinePosition;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = TreeListData(param1);
            invalidateProperties();
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            _data = param1;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        function createLabel(param1:int) : void
        {
            if (!label)
            {
                label = IUITextField(createInFontContext(UITextField));
                label.styleName = this;
                if (param1 == -1)
                {
                    addChild(DisplayObject(label));
                }
                else
                {
                    addChildAt(DisplayObject(label), param1);
                }
            }
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            var _loc_1:* = _data ? (_listData.indent) : (0);
            if (disclosureIcon)
            {
                _loc_1 = _loc_1 + disclosureIcon.width;
            }
            if (icon)
            {
                _loc_1 = _loc_1 + icon.measuredWidth;
            }
            if (label.width < 4 || label.height < 4)
            {
                label.width = 4;
                label.height = 16;
            }
            if (isNaN(explicitWidth))
            {
                _loc_1 = _loc_1 + label.getExplicitOrMeasuredWidth();
                measuredWidth = _loc_1;
                measuredHeight = label.getExplicitOrMeasuredHeight();
            }
            else
            {
                label.width = Math.max(explicitWidth - _loc_1, 4);
                measuredHeight = label.getExplicitOrMeasuredHeight();
                if (icon && icon.measuredHeight > measuredHeight)
                {
                    measuredHeight = icon.measuredHeight;
                }
            }
            return;
        }// end function

        function removeLabel() : void
        {
            if (label != null)
            {
                removeChild(DisplayObject(label));
                label = null;
            }
            return;
        }// end function

        public function get fontContext() : IFlexModuleFactory
        {
            return moduleFactory;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            createLabel(-1);
            addEventListener(ToolTipEvent.TOOL_TIP_SHOW, toolTipShowHandler);
            return;
        }// end function

        private function toolTipShowHandler(event:ToolTipEvent) : void
        {
            var _loc_5:* = null;
            var _loc_8:* = null;
            var _loc_2:* = event.toolTip;
            var _loc_3:* = systemManager.topLevelSystemManager;
            var _loc_4:* = _loc_3.getSandboxRoot();
            var _loc_6:* = new Point(0, 0);
            _loc_6 = label.localToGlobal(_loc_6);
            _loc_6 = _loc_4.globalToLocal(_loc_6);
            _loc_2.move(_loc_6.x, _loc_6.y + (height - _loc_2.height) / 2);
            if (_loc_3 != _loc_4)
            {
                _loc_8 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                _loc_4.dispatchEvent(_loc_8);
                _loc_5 = Rectangle(_loc_8.value);
            }
            else
            {
                _loc_5 = _loc_3.getVisibleApplicationRect();
            }
            var _loc_7:* = _loc_5.x + _loc_5.width;
            _loc_6.x = _loc_2.x;
            _loc_6.y = _loc_2.y;
            _loc_6 = _loc_4.localToGlobal(_loc_6);
            if (_loc_6.x + _loc_2.width > _loc_7)
            {
                _loc_2.move(_loc_2.x - (_loc_6.x + _loc_2.width - _loc_7), _loc_2.y);
            }
            return;
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        private function disclosureMouseDownHandler(event:Event) : void
        {
            event.stopPropagation();
            if (listOwner.isOpening || !listOwner.enabled)
            {
                return;
            }
            var _loc_2:* = _listData.open;
            _listData.open = !_loc_2;
            listOwner.dispatchTreeEvent(TreeEvent.ITEM_OPENING, _listData.item, this, event, !_loc_2, true, true);
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        function getDisclosureIcon() : IFlexDisplayObject
        {
            return disclosureIcon;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_5:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = _data ? (_listData.indent) : (0);
            if (disclosureIcon)
            {
                disclosureIcon.x = _loc_3;
                _loc_3 = disclosureIcon.x + disclosureIcon.width;
                disclosureIcon.setActualSize(disclosureIcon.width, disclosureIcon.height);
                disclosureIcon.visible = _data ? (_listData.hasChildren) : (false);
            }
            if (icon)
            {
                icon.x = _loc_3;
                _loc_3 = icon.x + icon.measuredWidth;
                icon.setActualSize(icon.measuredWidth, icon.measuredHeight);
            }
            label.x = _loc_3;
            label.setActualSize(param1 - _loc_3, measuredHeight);
            var _loc_4:* = getStyle("verticalAlign");
            if (getStyle("verticalAlign") == "top")
            {
                label.y = 0;
                if (icon)
                {
                    icon.y = 0;
                }
                if (disclosureIcon)
                {
                    disclosureIcon.y = 0;
                }
            }
            else if (_loc_4 == "bottom")
            {
                label.y = param2 - label.height + 2;
                if (icon)
                {
                    icon.y = param2 - icon.height;
                }
                if (disclosureIcon)
                {
                    disclosureIcon.y = param2 - disclosureIcon.height;
                }
            }
            else
            {
                label.y = (param2 - label.height) / 2;
                if (icon)
                {
                    icon.y = (param2 - icon.height) / 2;
                }
                if (disclosureIcon)
                {
                    disclosureIcon.y = (param2 - disclosureIcon.height) / 2;
                }
            }
            if (data && parent)
            {
                if (!enabled)
                {
                    _loc_5 = getStyle("disabledColor");
                }
                else if (listOwner.isItemHighlighted(listData.uid))
                {
                    _loc_5 = getStyle("textRollOverColor");
                }
                else if (listOwner.isItemSelected(listData.uid))
                {
                    _loc_5 = getStyle("textSelectedColor");
                }
                else
                {
                    _loc_5 = getStyle("color");
                }
                label.setColor(_loc_5);
            }
            if (_data != null)
            {
                if (listOwner.showDataTips)
                {
                    if (label.textWidth > label.width || listOwner.dataTipFunction != null)
                    {
                        toolTip = listOwner.itemToDataTip(_data);
                    }
                    else
                    {
                        toolTip = null;
                    }
                }
                else
                {
                    toolTip = null;
                }
            }
            return;
        }// end function

    }
}
