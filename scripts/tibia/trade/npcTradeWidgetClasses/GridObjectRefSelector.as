package tibia.trade.npcTradeWidgetClasses
{
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.styles.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.trade.*;

    public class GridObjectRefSelector extends ObjectRefSelectorBase
    {
        protected var m_UIProperties:Label = null;
        private var m_InvalidObjectRenderer:Boolean = false;
        private var m_InvalidObjectState:Boolean = false;
        protected var m_UIName:Label = null;
        private var m_UncommittedSelectedIndex:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIInfo:VBox = null;
        private var m_InvalidObjectInfo:Boolean = false;
        protected var m_UITile:Tile = null;
        private static const BUNDLE:String = "NPCTradeWidget";
        private static const TILE_STYLE_FILTER:Object = {slotHorizontalAlign:"horizontalAlign", slotVerticalAlign:"verticalAlign", slotHorizontalGap:"horizontalGap", slotVerticalGap:"verticalGap", slotPaddingBottom:"paddingBottom", slotPaddingLeft:"paddingLeft", slotPaddingRight:"paddingRight", slotPaddingTop:"paddingTop"};
        private static const INFO_STYLE_FILTER:Object = {infoBorderAlpha:"borderAlpha", infoBorderColor:"borderColor", infoBorderStyle:"borderStyle", infoBorderThickness:"borderThickness", infoBackgroundAlpha:"backgroundAlpha", infoBackgroundColor:"backgroundColor", infoHorizontalAlign:"horizontalAlign", infoVerticalAlign:"verticalAlign", infoHorizontalGap:"horizontalGap", infoVerticalGap:"verticalGap", infoPaddingBottom:"paddingBottom", infoPaddingLeft:"paddingLeft", infoPaddingRight:"paddingRight", infoPaddingTop:"paddingTop"};

        public function GridObjectRefSelector()
        {
            return;
        }// end function

        protected function onDataProviderChange(event:CollectionEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (event != null)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_4 = 0;
                _loc_5 = null;
                _loc_6 = null;
                switch(event.kind)
                {
                    case CollectionEventKind.ADD:
                    {
                        _loc_2 = 0;
                        _loc_4 = event.items.length;
                        while (_loc_2 < _loc_4)
                        {
                            
                            _loc_3 = event.location + _loc_2;
                            _loc_5 = TradeObjectRef(event.items[_loc_2]);
                            _loc_6 = new SkinnedAppearanceRenderer();
                            _loc_6.enabled = _loc_5.amount > 0;
                            _loc_6.appearance = _loc_5;
                            _loc_6.highlighted = _loc_3 == selectedIndex;
                            _loc_6.styleName = "npcTradeWidgetView";
                            this.m_UITile.addChildAt(_loc_6, _loc_3);
                            _loc_2++;
                        }
                        break;
                    }
                    case CollectionEventKind.MOVE:
                    {
                        this.m_UITile.setChildIndex(this.m_UITile.getChildAt(event.oldLocation), event.location);
                        break;
                    }
                    case CollectionEventKind.REMOVE:
                    {
                        _loc_2 = 0;
                        _loc_4 = event.items.length;
                        while (_loc_2 < _loc_4)
                        {
                            
                            _loc_3 = event.location + _loc_2;
                            _loc_6 = SkinnedAppearanceRenderer(this.m_UITile.removeChildAt(_loc_3));
                            _loc_2++;
                        }
                        break;
                    }
                    case CollectionEventKind.UPDATE:
                    {
                        break;
                    }
                    case CollectionEventKind.REFRESH:
                    case CollectionEventKind.REPLACE:
                    case CollectionEventKind.RESET:
                    {
                        this.invalidateObjectRenderers();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.invalidateObjectInfo();
                this.invalidateObjectStates();
            }
            return;
        }// end function

        protected function invalidateObjectRenderers() : void
        {
            this.m_InvalidObjectRenderer = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this.m_InvalidObjectInfo)
            {
                _loc_3 = selectedObject;
                if (_loc_3 != null)
                {
                    this.m_UIName.text = _loc_3.name;
                    this.m_UIProperties.text = resourceManager.getString(BUNDLE, "LBL_MONEY_AND_WEIGHT_FORMAT", [_loc_3.price, (_loc_3.weight / 100).toFixed(2)]);
                }
                else
                {
                    this.m_UIName.text = null;
                    this.m_UIProperties.text = null;
                }
                this.m_InvalidObjectInfo = false;
            }
            if (this.m_InvalidObjectRenderer)
            {
                _loc_1 = this.m_UITile.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_4 = SkinnedAppearanceRenderer(this.m_UITile.removeChildAt(_loc_1));
                    _loc_1 = _loc_1 - 1;
                }
                if (dataProvider != null)
                {
                    _loc_1 = 0;
                    _loc_2 = dataProvider.length;
                    while (_loc_1 < _loc_2)
                    {
                        
                        _loc_3 = TradeObjectRef(dataProvider.getItemAt(_loc_1));
                        _loc_4 = new SkinnedAppearanceRenderer();
                        _loc_4.enabled = _loc_3.amount > 0;
                        _loc_4.appearance = _loc_3;
                        _loc_4.highlighted = _loc_1 == selectedIndex;
                        _loc_4.styleName = "npcTradeWidgetView";
                        this.m_UITile.addChild(_loc_4);
                        _loc_1++;
                    }
                }
                this.m_InvalidObjectRenderer = false;
            }
            if (this.m_InvalidObjectState)
            {
                _loc_1 = this.m_UITile.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_4 = SkinnedAppearanceRenderer(this.m_UITile.getChildAt(_loc_1));
                    _loc_3 = TradeObjectRef(_loc_4.appearance);
                    _loc_4.enabled = _loc_3 != null && _loc_3.amount > 0;
                    _loc_4.highlighted = _loc_3 != null && _loc_1 == selectedIndex;
                    _loc_1 = _loc_1 - 1;
                }
                this.m_InvalidObjectState = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                if (selectedIndex < 0)
                {
                    this.m_UITile.verticalScrollPosition = 0;
                }
                this.m_UncommittedSelectedIndex = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITile = new Tile();
                this.m_UITile.percentHeight = 100;
                this.m_UITile.percentWidth = 100;
                this.m_UITile.verticalScrollPolicy = ScrollPolicy.ON;
                this.m_UITile.styleName = new StyleProxy(this, TILE_STYLE_FILTER);
                addChild(this.m_UITile);
                this.m_UIInfo = new VBox();
                this.m_UIInfo.percentHeight = NaN;
                this.m_UIInfo.percentWidth = 100;
                this.m_UIInfo.styleName = new StyleProxy(this, INFO_STYLE_FILTER);
                this.m_UIName = new Label();
                this.m_UIName.percentHeight = NaN;
                this.m_UIName.percentWidth = 100;
                this.m_UIInfo.addChild(this.m_UIName);
                this.m_UIProperties = new Label();
                this.m_UIProperties.percentHeight = NaN;
                this.m_UIProperties.percentWidth = 100;
                this.m_UIInfo.addChild(this.m_UIProperties);
                addChild(this.m_UIInfo);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_3:* = NaN;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            super.measure();
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            _loc_3 = 0;
            var _loc_4:* = 0;
            var _loc_5:* = numChildren - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_8 = IUIComponent(getChildAt(_loc_5));
                _loc_9 = _loc_8.getExplicitOrMeasuredWidth();
                _loc_10 = _loc_8.getExplicitOrMeasuredHeight();
                _loc_2 = Math.max(_loc_2, _loc_9);
                _loc_1 = Math.max(_loc_1, !isNaN(_loc_8.minWidth) ? (_loc_8.minWidth) : (_loc_9));
                _loc_4 = _loc_4 + _loc_10;
                _loc_3 = _loc_3 + (!isNaN(_loc_8.minHeight) ? (_loc_8.minHeight) : (_loc_10));
                _loc_5 = _loc_5 - 1;
            }
            var _loc_6:* = getStyle("paddingTop") + Math.max((numChildren - 1), 0) * getStyle("verticalGap") + getStyle("paddingBottom");
            var _loc_7:* = getStyle("paddingLeft") + getStyle("paddingRight");
            measuredWidth = _loc_2 + _loc_7;
            measuredMinWidth = _loc_1 + _loc_7;
            measuredHeight = _loc_4 + _loc_6;
            measuredMinHeight = _loc_3 + _loc_6;
            return;
        }// end function

        override public function get layout() : int
        {
            return ObjectRefSelectorBase.LAYOUT_GRID;
        }// end function

        override public function set selectedIndex(param1:int) : void
        {
            if (selectedIndex != param1)
            {
                super.selectedIndex = param1;
                this.invalidateObjectInfo();
                this.invalidateObjectStates();
                this.m_UncommittedSelectedIndex = true;
            }
            return;
        }// end function

        override public function set dataProvider(param1:IList) : void
        {
            if (dataProvider != param1)
            {
                if (dataProvider != null)
                {
                    dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
                super.dataProvider = param1;
                this.invalidateObjectInfo();
                this.invalidateObjectRenderers();
                this.invalidateObjectStates();
                if (dataProvider != null)
                {
                    dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onDataProviderChange);
                }
            }
            return;
        }// end function

        protected function invalidateObjectInfo() : void
        {
            this.m_InvalidObjectInfo = true;
            invalidateProperties();
            return;
        }// end function

        protected function invalidateObjectStates() : void
        {
            this.m_InvalidObjectState = true;
            invalidateProperties();
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            var _loc_3:* = getStyle("paddingLeft");
            var _loc_4:* = getStyle("paddingTop");
            var _loc_5:* = getStyle("horizontalGap");
            var _loc_6:* = getStyle("verticalGap");
            var _loc_7:* = param1 - _loc_3 - getStyle("paddingRight");
            var _loc_8:* = param2 - _loc_4 - getStyle("paddingBottom");
            var _loc_9:* = this.m_UIInfo.getExplicitOrMeasuredWidth();
            var _loc_10:* = this.m_UIInfo.getExplicitOrMeasuredHeight();
            this.m_UIInfo.move(_loc_3, _loc_4 + _loc_8 - _loc_10);
            this.m_UIInfo.setActualSize(_loc_7, _loc_10);
            _loc_8 = _loc_8 - (_loc_10 + _loc_6);
            this.m_UITile.move(_loc_3, _loc_4);
            this.m_UITile.setActualSize(_loc_7, _loc_8);
            return;
        }// end function

    }
}
