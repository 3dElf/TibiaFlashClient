package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.dataGridClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.market.*;

    public class OwnOffersView extends MarketComponent
    {
        private var m_SellOffersView:ArrayCollection;
        private var m_UISellOffers:DataGrid = null;
        private var m_BuyOffersView:ArrayCollection;
        private var m_UISellCancel:Button = null;
        private var m_UIBuyOffers:DataGrid = null;
        private var m_UIBuyCancel:Button = null;
        private var m_UIConstructed:Boolean = false;
        private static const BUNDLE:String = "MarketWidget";

        public function OwnOffersView(param1:MarketWidget)
        {
            this.m_BuyOffersView = new ArrayCollection();
            this.m_SellOffersView = new ArrayCollection();
            super(param1);
            direction = BoxDirection.VERTICAL;
            label = resourceManager.getString(BUNDLE, "OWN_OFFERS_VIEW_LABEL");
            this.m_BuyOffersView = new ArrayCollection();
            this.m_BuyOffersView.filterFunction = Utility.createFilter({kind:Offer.BUY_OFFER});
            this.m_BuyOffersView.refresh();
            this.m_SellOffersView = new ArrayCollection();
            this.m_SellOffersView.filterFunction = Utility.createFilter({kind:Offer.SELL_OFFER});
            this.m_SellOffersView.refresh();
            market.addEventListener(MarketWidget.BROWSE_OFFERS_CHANGE, this.onOffersChange);
            return;
        }// end function

        private function onOfferDoubleClick(event:ListEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.itemRenderer.data as Offer;
            _loc_2 = event.itemRenderer.data as Offer;
            if (event != null && event.itemRenderer != null && _loc_3 != null && MarketWidget.isValidTypeID(_loc_2.typeID))
            {
                market.selectedType = _loc_2.typeID;
                market.selectedView = MarketWidget.VIEW_MARKET_OFFERS;
            }
            return;
        }// end function

        private function onCancelClose(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as CancelOfferDialog;
            _loc_2 = event.currentTarget as CancelOfferDialog;
            if (event != null && event.detail == EmbeddedDialog.YES && _loc_3 != null)
            {
                market.cancelOffer(_loc_2.offer);
                this.updateOfferSelection(null);
            }
            return;
        }// end function

        private function onOfferClick(event:ListEvent) : void
        {
            if (event != null && event.itemRenderer != null)
            {
                this.updateOfferSelection(event.itemRenderer.data as Offer);
            }
            return;
        }// end function

        private function createOffersListColumns() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_TYPEID");
            _loc_2.dataField = "typeID";
            _loc_2.editable = false;
            _loc_2.labelFunction = Utility.formatOfferTypeID;
            _loc_2.resizable = false;
            _loc_2.sortCompareFunction = Utility.compareOfferByItemName;
            _loc_2.width = 290;
            _loc_1.push(_loc_2);
            _loc_2 = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_AMOUNT");
            _loc_2.dataField = "amount";
            _loc_2.editable = false;
            _loc_2.resizable = false;
            _loc_2.width = 80;
            _loc_1.push(_loc_2);
            _loc_2 = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_TOTALPRICE");
            _loc_2.dataField = "totalPrice";
            _loc_2.editable = false;
            _loc_2.labelFunction = Utility.formatOfferTotalPrice;
            _loc_2.resizable = false;
            _loc_2.width = 80;
            _loc_1.push(_loc_2);
            _loc_2 = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_PIECEPRICE");
            _loc_2.dataField = "piecePrice";
            _loc_2.editable = false;
            _loc_2.labelFunction = Utility.formatOfferPiecePrice;
            _loc_2.resizable = false;
            _loc_2.width = 80;
            _loc_1.push(_loc_2);
            _loc_2 = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_TIMESTAMP");
            _loc_2.dataField = "terminationTimestamp";
            _loc_2.labelFunction = Utility.formatOfferTerminationTimestamp;
            _loc_2.editable = false;
            _loc_2.resizable = false;
            _loc_2.width = 140;
            _loc_1.push(_loc_2);
            return _loc_1;
        }// end function

        private function onOffersChange(event:Event) : void
        {
            if (event != null && (market.browseTypeID == MarketWidget.REQUEST_OWN_OFFERS || market.browseTypeID == -1))
            {
                this.updateOfferList(market.browseOffers);
            }
            return;
        }// end function

        private function updateOfferList(param1:Array) : void
        {
            var _loc_2:* = new Sort();
            var _loc_3:* = new SortField("typeID", false, false, false);
            _loc_3.compareFunction = Utility.compareOfferByItemName;
            _loc_2.fields = [_loc_3, new SortField("terminationTimestamp", false, false, true)];
            this.m_BuyOffersView.sort = _loc_2;
            this.m_BuyOffersView.source = param1;
            this.m_BuyOffersView.refresh();
            this.m_SellOffersView.sort = _loc_2;
            this.m_SellOffersView.source = param1;
            this.m_SellOffersView.refresh();
            this.updateOfferSelection(null);
            return;
        }// end function

        private function onCancelClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            var _loc_4:* = event.currentTarget == this.m_UIBuyCancel ? (this.m_UIBuyOffers.selectedItem as Offer) : (this.m_UISellOffers.selectedItem as Offer);
            _loc_2 = event.currentTarget == this.m_UIBuyCancel ? (this.m_UIBuyOffers.selectedItem as Offer) : (this.m_UISellOffers.selectedItem as Offer);
            if (event != null && _loc_4 != null && !market.serverResponsePending)
            {
                _loc_3 = new CancelOfferDialog();
                _loc_3.offer = _loc_2;
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onCancelClose, false, EventPriority.DEFAULT, true);
                market.embeddedDialog = _loc_3;
            }
            return;
        }// end function

        private function updateOfferSelection(param1:Offer) : void
        {
            if (param1 != null && param1.kind == Offer.BUY_OFFER)
            {
                this.m_UIBuyCancel.enabled = !market.serverResponsePending;
                this.m_UISellCancel.enabled = false;
                this.m_UISellOffers.selectedItem = null;
            }
            else if (param1 != null)
            {
                this.m_UIBuyCancel.enabled = false;
                this.m_UIBuyOffers.selectedItem = null;
                this.m_UISellCancel.enabled = !market.serverResponsePending;
            }
            else
            {
                this.m_UIBuyCancel.enabled = false;
                this.m_UIBuyOffers.selectedItem = null;
                this.m_UISellCancel.enabled = false;
                this.m_UISellOffers.selectedItem = null;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_2 = new Label();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.text = resourceManager.getString(BUNDLE, "OWN_OFFERS_VIEW_SELLOFFERS");
                _loc_2.setStyle("fontWeight", "bold");
                _loc_1.addChild(_loc_2);
                this.m_UISellCancel = new CustomButton();
                this.m_UISellCancel.enabled = false;
                this.m_UISellCancel.label = resourceManager.getString(BUNDLE, "OWN_OFFERS_VIEW_SELLCANCEL");
                this.m_UISellCancel.addEventListener(MouseEvent.CLICK, this.onCancelClick);
                _loc_1.addChild(this.m_UISellCancel);
                addChild(_loc_1);
                this.m_UISellOffers = new CustomDataGrid();
                this.m_UISellOffers.columns = this.createOffersListColumns();
                this.m_UISellOffers.dataProvider = this.m_SellOffersView;
                this.m_UISellOffers.doubleClickEnabled = true;
                this.m_UISellOffers.draggableColumns = false;
                this.m_UISellOffers.percentHeight = 100;
                this.m_UISellOffers.percentWidth = 100;
                this.m_UISellOffers.resizableColumns = false;
                this.m_UISellOffers.styleName = "marketWidgetOffers";
                this.m_UISellOffers.verticalScrollPolicy = ScrollPolicy.ON;
                this.m_UISellOffers.addEventListener(ListEvent.CHANGE, this.onOfferClick);
                this.m_UISellOffers.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onOfferDoubleClick);
                addChild(this.m_UISellOffers);
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_2 = new Label();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.text = resourceManager.getString(BUNDLE, "OWN_OFFERS_VIEW_BUYOFFERS");
                _loc_2.setStyle("fontWeight", "bold");
                _loc_1.addChild(_loc_2);
                this.m_UIBuyCancel = new CustomButton();
                this.m_UIBuyCancel.enabled = false;
                this.m_UIBuyCancel.label = resourceManager.getString(BUNDLE, "OWN_OFFERS_VIEW_BUYCANCEL");
                this.m_UIBuyCancel.addEventListener(MouseEvent.CLICK, this.onCancelClick);
                _loc_1.addChild(this.m_UIBuyCancel);
                addChild(_loc_1);
                this.m_UIBuyOffers = new CustomDataGrid();
                this.m_UIBuyOffers.columns = this.createOffersListColumns();
                this.m_UIBuyOffers.dataProvider = this.m_BuyOffersView;
                this.m_UIBuyOffers.doubleClickEnabled = true;
                this.m_UIBuyOffers.draggableColumns = false;
                this.m_UIBuyOffers.percentHeight = 100;
                this.m_UIBuyOffers.percentWidth = 100;
                this.m_UIBuyOffers.resizableColumns = false;
                this.m_UIBuyOffers.styleName = "marketWidgetOffers";
                this.m_UIBuyOffers.verticalScrollPolicy = ScrollPolicy.ON;
                this.m_UIBuyOffers.addEventListener(ListEvent.CHANGE, this.onOfferClick);
                this.m_UIBuyOffers.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.onOfferDoubleClick);
                addChild(this.m_UIBuyOffers);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
