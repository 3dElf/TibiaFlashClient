package tibia.market.marketWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.containers.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.game.*;
    import tibia.ingameshop.*;
    import tibia.market.*;

    public class AppearanceTypeTileRenderer extends HBox
    {
        private var m_UIDepotCount:FlexShape = null;
        private var m_UncommittedSelection:Boolean = false;
        private var m_UncommittedAppearance:Boolean = false;
        private var m_Appearance:AppearanceType = null;
        private var m_UncommittedMarket:Boolean = false;
        private var m_Market:MarketWidget = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIAppearance:SkinnedAppearanceRenderer = null;
        private var m_UncommittedDepotCount:Boolean = false;
        private static var s_Rect:Rectangle = new Rectangle();
        private static var s_TextCache:TextFieldCache = new TextFieldCache(32, 17, 512, true);
        private static var s_Trans:Matrix = new Matrix();

        public function AppearanceTypeTileRenderer()
        {
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            return;
        }// end function

        protected function set appearance(param1:AppearanceType) : void
        {
            if (this.m_Appearance != param1)
            {
                this.m_Appearance = param1;
                this.m_UncommittedAppearance = true;
                this.invalidateDepotCount();
                this.invalidateSelection();
                invalidateProperties();
            }
            return;
        }// end function

        override public function get data() : Object
        {
            return this.appearance;
        }// end function

        protected function invalidateSelection() : void
        {
            this.m_UncommittedSelection = true;
            invalidateDisplayList();
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            this.appearance = param1 as AppearanceType;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedAppearance)
            {
                _loc_1 = null;
                var _loc_2:* = Tibia.s_GetAppearanceStorage();
                _loc_1 = Tibia.s_GetAppearanceStorage();
                if (this.appearance != null && _loc_2 != null)
                {
                    this.m_UIAppearance.appearance = _loc_1.createObjectInstance(this.appearance.marketShowAs, 0);
                    this.m_UIAppearance.highlighted = owner is ListBase && ListBase(owner).selectedItem === this.appearance;
                }
                else
                {
                    this.m_UIAppearance.appearance = null;
                    this.m_UIAppearance.highlighted = false;
                }
                this.m_UncommittedAppearance = false;
            }
            if (this.m_UncommittedMarket)
            {
                this.m_UncommittedMarket = false;
            }
            return;
        }// end function

        protected function invalidateDepotCount() : void
        {
            this.m_UncommittedDepotCount = true;
            invalidateDisplayList();
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIAppearance = new SkinnedAppearanceRenderer();
                this.m_UIAppearance.styleName = "marketWidgetAppearanceRenderer";
                addChild(this.m_UIAppearance);
                this.m_UIDepotCount = new FlexShape();
                rawChildren.addChild(this.m_UIDepotCount);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function get appearance() : AppearanceType
        {
            return this.m_Appearance;
        }// end function

        private function onDepotChange(event:Event) : void
        {
            if (event != null)
            {
                this.invalidateDepotCount();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            super.updateDisplayList(param1, param2);
            if (this.m_UncommittedDepotCount)
            {
                _loc_3 = this.m_UIDepotCount.graphics;
                _loc_3.clear();
                _loc_4 = 0;
                _loc_5 = null;
                var _loc_6:* = this.market.getDepotAmount(this.appearance);
                _loc_4 = this.market.getDepotAmount(this.appearance);
                var _loc_6:* = s_TextCache.getItem(_loc_4, String(_loc_4), 4294967295);
                _loc_5 = s_TextCache.getItem(_loc_4, String(_loc_4), 4294967295);
                if (this.appearance != null && this.market != null && this.appearance.ID != IngameShopManager.TIBIA_COINS_APPEARANCE_TYPE_ID && _loc_6 > 0 && _loc_6 != null)
                {
                    s_Rect.x = this.m_UIAppearance.getExplicitOrMeasuredWidth() - this.m_UIAppearance.getStyle("paddingRight") - _loc_5.width;
                    s_Rect.y = this.m_UIAppearance.getExplicitOrMeasuredHeight() - this.m_UIAppearance.getStyle("paddingBottom") - _loc_5.height;
                    s_Trans.tx = -_loc_5.x + s_Rect.x;
                    s_Trans.ty = -_loc_5.y + s_Rect.y;
                    _loc_3.beginBitmapFill(s_TextCache, s_Trans, false, false);
                    _loc_3.drawRect(s_Rect.x, s_Rect.y, _loc_5.width, _loc_5.height);
                    _loc_3.endFill();
                }
                this.m_UIDepotCount.x = this.m_UIAppearance.x;
                this.m_UIDepotCount.y = this.m_UIAppearance.y;
                this.m_UncommittedDepotCount = false;
            }
            if (this.m_UncommittedSelection)
            {
                this.m_UIAppearance.highlighted = this.market != null && this.market.selectedType == this.appearance;
                this.m_UncommittedSelection = false;
            }
            return;
        }// end function

        protected function set market(param1:MarketWidget) : void
        {
            if (this.m_Market != param1)
            {
                if (this.m_Market != null)
                {
                    this.m_Market.removeEventListener(MarketWidget.DEPOT_CONTENT_CHANGE, this.onDepotChange);
                    this.m_Market.removeEventListener(MarketWidget.SELECTED_TYPE_CHANGE, this.onSelectionChange);
                }
                this.m_Market = param1;
                if (this.m_Market != null)
                {
                    this.m_Market.addEventListener(MarketWidget.DEPOT_CONTENT_CHANGE, this.onDepotChange, false, EventPriority.DEFAULT, true);
                    this.m_Market.addEventListener(MarketWidget.SELECTED_TYPE_CHANGE, this.onSelectionChange);
                }
                this.m_UncommittedMarket = true;
                this.invalidateDepotCount();
                this.invalidateSelection();
                invalidateProperties();
            }
            return;
        }// end function

        protected function get market() : MarketWidget
        {
            return this.m_Market;
        }// end function

        private function onSelectionChange(event:Event) : void
        {
            if (event != null)
            {
                this.invalidateSelection();
            }
            return;
        }// end function

        private function onCreationComplete(event:Event) : void
        {
            removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            this.market = PopUpBase.getParentPopUp(this) as MarketWidget;
            return;
        }// end function

    }
}
