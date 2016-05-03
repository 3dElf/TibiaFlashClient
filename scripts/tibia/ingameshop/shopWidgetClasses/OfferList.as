package tibia.ingameshop.shopWidgetClasses
{
    import flash.errors.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;

    public class OfferList extends CustomTileList implements IIngameShopWidgetComponent, IDataRenderer
    {
        private var m_LastStoreEventOffer:int;
        private var m_UncommittedCategory:Boolean;
        private var m_ShopWindow:IngameShopWidget;
        private static const LIST_ITEM_HEIGHT:int = 140;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const LIST_ITEM_WIDTH:int = 120;

        public function OfferList()
        {
            styleName = "ingameShopOfferList";
            itemRenderer = new ClassFactory(OfferRenderer);
            columnWidth = LIST_ITEM_WIDTH;
            rowHeight = LIST_ITEM_HEIGHT;
            doubleClickEnabled = true;
            addEventListener(ListEvent.CHANGE, this.onOfferSelected);
            addEventListener(ListEvent.ITEM_CLICK, this.onOfferClicked);
            this.m_UncommittedCategory = true;
            return;
        }// end function

        override protected function mouseWheelHandler(event:MouseEvent) : void
        {
            event.delta = Math.max(-1, Math.min(1, event.delta));
            super.mouseWheelHandler(event);
            return;
        }// end function

        private function updateUIOnOfferSelection(param1:IngameShopOffer) : void
        {
            if (this.m_ShopWindow != null)
            {
                this.m_ShopWindow.mainView.setShowButtonBar(param1 != null);
                this.m_ShopWindow.mainView.detailsList.offer = param1;
            }
            return;
        }// end function

        protected function onOfferSelected(event:ListEvent) : void
        {
            var _loc_2:* = event.itemRenderer.data as IngameShopOffer;
            this.updateUIOnOfferSelection(_loc_2);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            super.commitProperties();
            if (this.m_UncommittedCategory)
            {
                selectedItem = null;
                this.updateUIOnOfferSelection(null);
                _loc_1 = data as IngameShopCategory;
                if (_loc_1 != null)
                {
                    _loc_2 = new Array();
                    _loc_3 = 0;
                    while (_loc_3 < _loc_1.offers.length)
                    {
                        
                        _loc_2.push(_loc_1.offers[_loc_3]);
                        _loc_3++;
                    }
                    dataProvider = new ArrayCollection(_loc_2);
                }
                else
                {
                    dataProvider = null;
                }
                this.m_UncommittedCategory = false;
            }
            return;
        }// end function

        public function getSelectedOffer() : IngameShopOffer
        {
            return selectedItem as IngameShopOffer;
        }// end function

        protected function onOfferClicked(event:ListEvent) : void
        {
            var _loc_2:* = event.itemRenderer.data as IngameShopOffer;
            if (_loc_2 != null && this.m_LastStoreEventOffer != _loc_2.offerID)
            {
                this.m_LastStoreEventOffer = _loc_2.offerID;
                Tibia.s_GetCommunication().sendCSTOREEVENT(IngameShopManager.STORE_EVENT_SELECT_OFFER, _loc_2.offerID);
            }
            return;
        }// end function

        protected function onCurrentOffersChanged(event:IngameShopEvent) : void
        {
            this.m_UncommittedCategory = true;
            invalidateProperties();
            return;
        }// end function

        public function set shopWidget(param1:IngameShopWidget) : void
        {
            if (this.m_ShopWindow != null)
            {
                throw new IllegalOperationError("IngameShopOfferList.shopWidget: Attempted to set reference twice");
            }
            this.m_ShopWindow = param1;
            return;
        }// end function

        protected function onOfferDoubleClicked(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this.getSelectedOffer();
            if (_loc_2 != null)
            {
                _loc_3 = new IngameShopEvent(IngameShopEvent.OFFER_ACTIVATED);
                _loc_3.data = _loc_2;
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            var _loc_2:* = super.data as IngameShopCategory;
            if (_loc_2 != null)
            {
                _loc_2.removeEventListener(IngameShopEvent.CATEGORY_OFFERS_CHANGED, this.onCurrentOffersChanged);
            }
            var _loc_3:* = param1 as IngameShopCategory;
            if (_loc_3 != null)
            {
                _loc_3.addEventListener(IngameShopEvent.CATEGORY_OFFERS_CHANGED, this.onCurrentOffersChanged);
            }
            super.data = param1;
            this.m_UncommittedCategory = true;
            invalidateProperties();
            return;
        }// end function

        public function dispose() : void
        {
            removeEventListener(ListEvent.CHANGE, this.onOfferSelected);
            removeEventListener(ListEvent.ITEM_CLICK, this.onOfferClicked);
            this.data = null;
            this.m_ShopWindow = null;
            return;
        }// end function

    }
}
