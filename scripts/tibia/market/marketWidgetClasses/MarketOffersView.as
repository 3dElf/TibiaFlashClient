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

    public class MarketOffersView extends MarketComponent
    {
        private var m_SellOffersView:ArrayCollection;
        private var m_UISellAccept:Button = null;
        private var m_UISellOffers:DataGrid = null;
        private var m_BuyOffersView:ArrayCollection;
        private var m_UncommittedSelectedType:Boolean = false;
        private var m_UIBuyAccept:Button = null;
        private var m_UIBuyOffers:DataGrid = null;
        private var m_UIConstructed:Boolean = false;
        private static const BUNDLE:String = "MarketWidget";

        public function MarketOffersView(param1:MarketWidget)
        {
            this.m_BuyOffersView = new ArrayCollection();
            this.m_SellOffersView = new ArrayCollection();
            super(param1);
            direction = BoxDirection.VERTICAL;
            label = resourceManager.getString(BUNDLE, "MARKET_OFFERS_VIEW_LABEL");
            this.m_BuyOffersView = new ArrayCollection();
            this.m_BuyOffersView.filterFunction = Utility.createFilter({kind:Offer.BUY_OFFER});
            this.m_BuyOffersView.refresh();
            this.m_SellOffersView = new ArrayCollection();
            this.m_SellOffersView.filterFunction = Utility.createFilter({kind:Offer.SELL_OFFER});
            this.m_SellOffersView.refresh();
            market.addEventListener(MarketWidget.BROWSE_OFFERS_CHANGE, this.onOffersChange);
            return;
        }// end function

        private function onAcceptClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            var _loc_4:* = event.currentTarget == this.m_UIBuyAccept ? (this.m_UIBuyOffers.selectedItem as Offer) : (this.m_UISellOffers.selectedItem as Offer);
            _loc_2 = event.currentTarget == this.m_UIBuyAccept ? (this.m_UIBuyOffers.selectedItem as Offer) : (this.m_UISellOffers.selectedItem as Offer);
            if (event != null && _loc_4 != null && this.checkAccept(_loc_2))
            {
                _loc_3 = new AcceptOfferDialog();
                _loc_3.market = market;
                _loc_3.offer = _loc_2;
                _loc_3.addEventListener(CloseEvent.CLOSE, this.onAcceptClose, false, EventPriority.DEFAULT, true);
                market.embeddedDialog = _loc_3;
            }
            return;
        }// end function

        private function createOfferToolTip(param1:Offer) : String
        {
            if (param1.isDubious)
            {
                if (param1.kind == Offer.BUY_OFFER)
                {
                    return resourceManager.getString(BUNDLE, "OFFERS_VIEW_OFFER_BELOW");
                }
                return resourceManager.getString(BUNDLE, "OFFERS_VIEW_OFFER_ABOVE");
            }
            else
            {
                return null;
            }
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedSelectedType)
            {
                this.updateOfferList(null);
                this.m_UncommittedSelectedType = false;
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

        private function updateOfferList(param1:Array) : void
        {
            var _loc_2:* = new Sort();
            _loc_2.fields = [new SortField("piecePrice", false, true, true), new SortField("amount", false, true, true), new SortField("terminationTimestamp", false, false, true)];
            this.m_BuyOffersView.sort = _loc_2;
            this.m_BuyOffersView.source = param1;
            this.m_BuyOffersView.refresh();
            var _loc_3:* = new Sort();
            _loc_3.fields = [new SortField("piecePrice", false, false, true), new SortField("amount", false, true, true), new SortField("terminationTimestamp", false, false, true)];
            this.m_SellOffersView.sort = _loc_3;
            this.m_SellOffersView.source = param1;
            this.m_SellOffersView.refresh();
            this.updateOfferSelection(null);
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
                _loc_2.text = resourceManager.getString(BUNDLE, "MARKET_OFFERS_VIEW_SELLOFFERS");
                _loc_2.setStyle("fontWeight", "bold");
                _loc_1.addChild(_loc_2);
                this.m_UISellAccept = new CustomButton();
                this.m_UISellAccept.enabled = false;
                this.m_UISellAccept.label = resourceManager.getString(BUNDLE, "MARKET_OFFERS_VIEW_SELLACCEPT");
                this.m_UISellAccept.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
                _loc_1.addChild(this.m_UISellAccept);
                addChild(_loc_1);
                this.m_UISellOffers = new CustomDataGrid();
                this.m_UISellOffers.columns = this.createOffersListColumns();
                this.m_UISellOffers.dataProvider = this.m_SellOffersView;
                this.m_UISellOffers.dataTipFunction = this.createOfferToolTip;
                this.m_UISellOffers.draggableColumns = false;
                this.m_UISellOffers.itemRenderer = new ClassFactory(CustomItemRenderer);
                this.m_UISellOffers.percentHeight = 100;
                this.m_UISellOffers.percentWidth = 100;
                this.m_UISellOffers.resizableColumns = false;
                this.m_UISellOffers.showDataTips = true;
                this.m_UISellOffers.styleName = "marketWidgetOffers";
                this.m_UISellOffers.verticalScrollPolicy = ScrollPolicy.ON;
                this.m_UISellOffers.addEventListener(ListEvent.CHANGE, this.onOfferClick);
                addChild(this.m_UISellOffers);
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_2 = new Label();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.text = resourceManager.getString(BUNDLE, "MARKET_OFFERS_VIEW_BUYOFFERS");
                _loc_2.setStyle("fontWeight", "bold");
                _loc_1.addChild(_loc_2);
                this.m_UIBuyAccept = new CustomButton();
                this.m_UIBuyAccept.enabled = false;
                this.m_UIBuyAccept.label = resourceManager.getString(BUNDLE, "MARKET_OFFERS_VIEW_BUYACCEPT");
                this.m_UIBuyAccept.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
                _loc_1.addChild(this.m_UIBuyAccept);
                addChild(_loc_1);
                this.m_UIBuyOffers = new CustomDataGrid();
                this.m_UIBuyOffers.columns = this.createOffersListColumns();
                this.m_UIBuyOffers.dataProvider = this.m_BuyOffersView;
                this.m_UIBuyOffers.dataTipFunction = this.createOfferToolTip;
                this.m_UIBuyOffers.draggableColumns = false;
                this.m_UIBuyOffers.itemRenderer = new ClassFactory(CustomItemRenderer);
                this.m_UIBuyOffers.percentHeight = 100;
                this.m_UIBuyOffers.percentWidth = 100;
                this.m_UIBuyOffers.resizableColumns = false;
                this.m_UIBuyOffers.showDataTips = true;
                this.m_UIBuyOffers.styleName = "marketWidgetOffers";
                this.m_UIBuyOffers.verticalScrollPolicy = ScrollPolicy.ON;
                this.m_UIBuyOffers.addEventListener(ListEvent.CHANGE, this.onOfferClick);
                addChild(this.m_UIBuyOffers);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override public function set selectedType(param1) : void
        {
            if (selectedType != param1)
            {
                super.selectedType = param1;
                this.m_UncommittedSelectedType = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function createOffersListColumns() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = new DataGridColumn();
            _loc_2.headerText = resourceManager.getString(BUNDLE, "OFFERS_VIEW_COLUMN_NAME");
            _loc_2.dataField = "character";
            _loc_2.editable = false;
            _loc_2.resizable = false;
            _loc_2.width = 120;
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
            if (event != null && market.browseTypeID != MarketWidget.REQUEST_OWN_OFFERS && market.browseTypeID != MarketWidget.REQUEST_OWN_HISTORY)
            {
                this.updateOfferList(market.browseOffers);
            }
            return;
        }// end function

        private function checkAccept(param1:Offer) : Boolean
        {
            return !market.serverResponsePending && param1 != null && (param1.kind != Offer.BUY_OFFER || market.getDepotAmount(param1.typeID) > 0) && (param1.kind != Offer.SELL_OFFER || market.accountBalance >= param1.piecePrice);
        }// end function

        private function onAcceptClose(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as AcceptOfferDialog;
            _loc_2 = event.currentTarget as AcceptOfferDialog;
            if (event != null && event.detail == EmbeddedDialog.OKAY && _loc_3 != null)
            {
                market.acceptOffer(_loc_2.offer, _loc_2.amount);
                this.updateOfferSelection(null);
            }
            return;
        }// end function

        private function updateOfferSelection(param1:Offer) : void
        {
            if (param1 != null && param1.kind == Offer.BUY_OFFER)
            {
                this.m_UIBuyAccept.enabled = this.checkAccept(param1);
                this.m_UISellAccept.enabled = false;
                this.m_UISellOffers.selectedItem = null;
            }
            else if (param1 != null)
            {
                this.m_UIBuyAccept.enabled = false;
                this.m_UIBuyOffers.selectedItem = null;
                this.m_UISellAccept.enabled = this.checkAccept(param1);
            }
            else
            {
                this.m_UIBuyAccept.enabled = false;
                this.m_UIBuyOffers.selectedItem = null;
                this.m_UISellAccept.enabled = false;
                this.m_UISellOffers.selectedItem = null;
            }
            return;
        }// end function

    }
}
