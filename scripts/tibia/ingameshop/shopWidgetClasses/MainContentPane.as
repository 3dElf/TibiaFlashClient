package tibia.ingameshop.shopWidgetClasses
{
    import flash.errors.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;

    public class MainContentPane extends VBox implements IIngameShopWidgetComponent
    {
        private var m_UIStack:ViewStack;
        private var m_UIOfferDetails:OfferDetails;
        private var m_UIDetailsButton:Button;
        private var m_UINextTransactionPage:Button;
        private var m_UIBetweenButtonsLabel:Label;
        private var m_UIOfferList:OfferList;
        private var m_UIPreviousTransactionPage:Button;
        private var m_UITransactions:TransactionHistory;
        private var m_UIBackButton:Button;
        private var m_ShopWindow:IngameShopWidget;
        private var m_UIBottomButtonBox:HBox;
        private var m_UITitle:Label;
        private var m_UIBuyButton:Button;
        private var m_UIGetCoinsButton:Button;
        private static const VIEW_OFFERS:int = 0;
        private static const VIEW_DETAILS:int = 1;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const VIEW_TRANSACTIONS:int = 2;

        public function MainContentPane()
        {
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.PURCHASE_COMPLETED, this.onPurchaseCompleted);
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.ERROR_RECEIVED, this.onErrorReceived);
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.NAME_CHANGE_REQUESTED, this.onNameChangeRequest);
            IngameShopManager.getInstance().addEventListener(IngameShopEvent.CREDIT_BALANCE_CHANGED, this.onCreditBalanceChanged);
            return;
        }// end function

        public function get detailsList() : OfferDetails
        {
            return this.m_UIOfferDetails;
        }// end function

        protected function onBuyClicked(event:Event) : void
        {
            var _loc_2:* = null;
            if (this.m_UIOfferList.getSelectedOffer() != null)
            {
                if (Tibia.s_GetOptions().generalShopShowBuyConfirmation)
                {
                    _loc_2 = new PurchaseConfirmationWidget(this.m_UIOfferList.getSelectedOffer());
                    _loc_2.addEventListener(CloseEvent.CLOSE, this.onBuyConfirmationClosed);
                    this.m_ShopWindow.embeddedDialog = _loc_2;
                }
                else
                {
                    IngameShopManager.getInstance().purchaseRegularOffer(this.m_UIOfferList.getSelectedOffer().offerID);
                    this.switchView(VIEW_OFFERS);
                }
            }
            return;
        }// end function

        protected function onBuyConfirmationClosed(event:CloseEvent) : void
        {
            this.m_ShopWindow.embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onBuyConfirmationClosed);
            var _loc_2:* = this.m_ShopWindow.embeddedDialog as PurchaseConfirmationWidget;
            if (_loc_2 != null && event.detail == EmbeddedDialog.YES)
            {
                IngameShopManager.getInstance().purchaseRegularOffer(this.m_UIOfferList.getSelectedOffer().offerID);
                this.switchView(VIEW_OFFERS);
                Tibia.s_GetOptions().generalShopShowBuyConfirmation = !_loc_2.hasCheckedDoNotShowDialogAgain();
            }
            return;
        }// end function

        protected function onCreditBalanceChanged(event:IngameShopEvent) : void
        {
            this.switchBetweenBuyAndGetCoinsButton();
            return;
        }// end function

        public function get offerList() : OfferList
        {
            return this.m_UIOfferList;
        }// end function

        public function dispose() : void
        {
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.PURCHASE_COMPLETED, this.onPurchaseCompleted);
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.ERROR_RECEIVED, this.onErrorReceived);
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.NAME_CHANGE_REQUESTED, this.onNameChangeRequest);
            IngameShopManager.getInstance().removeEventListener(IngameShopEvent.CREDIT_BALANCE_CHANGED, this.onCreditBalanceChanged);
            if (this.m_ShopWindow != null)
            {
                this.m_ShopWindow.sideBar.removeEventListener(IngameShopEvent.CATEGORY_SELECTED, this.onCategorySelected);
                this.m_ShopWindow.sideBar.removeEventListener(IngameShopEvent.HISTORY_CLICKED, this.onHistoryClicked);
            }
            this.m_UIOfferList.removeEventListener(IngameShopEvent.OFFER_ACTIVATED, this.onOfferDoubleClicked);
            this.m_UIOfferList.dispose();
            this.m_UIOfferDetails.dispose();
            this.m_UITransactions.dispose();
            this.m_UIBackButton.removeEventListener(MouseEvent.CLICK, this.onBackClicked);
            this.m_UIDetailsButton.removeEventListener(MouseEvent.CLICK, this.onDetailsClicked);
            this.m_UIBuyButton.removeEventListener(MouseEvent.CLICK, this.onBuyClicked);
            this.m_UIGetCoinsButton.removeEventListener(MouseEvent.CLICK, this.onGetCoinsClick);
            this.m_ShopWindow = null;
            return;
        }// end function

        protected function onPurchaseCompleted(event:IngameShopEvent) : void
        {
            var _loc_2:* = new ShopReponseWidget(event.message, event.errorType);
            this.m_ShopWindow.embeddedDialog = _loc_2;
            this.m_ShopWindow.sideBar.requestOffersForCategory(this.m_ShopWindow.sideBar.getSelectedCategory());
            return;
        }// end function

        protected function onHistoryClicked(event:Event) : void
        {
            this.m_UITransactions.refreshTransactionHistory();
            this.switchView(VIEW_TRANSACTIONS);
            return;
        }// end function

        public function set shopWidget(param1:IngameShopWidget) : void
        {
            if (this.m_ShopWindow != null)
            {
                throw new IllegalOperationError("IngameShopMainContentPane.shopWidget: Attempted to set reference twice");
            }
            this.m_ShopWindow = param1;
            this.m_ShopWindow.sideBar.addEventListener(IngameShopEvent.CATEGORY_SELECTED, this.onCategorySelected);
            this.m_ShopWindow.sideBar.addEventListener(IngameShopEvent.HISTORY_CLICKED, this.onHistoryClicked);
            this.m_UIOfferList.shopWidget = param1;
            this.m_UIOfferDetails.shopWidget = param1;
            this.m_UITransactions.shopWidget = param1;
            return;
        }// end function

        protected function onCategorySelected(event:IngameShopEvent) : void
        {
            this.m_UIOfferList.selectedItem = null;
            this.switchView(VIEW_OFFERS);
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UITitle = new Label();
            this.m_UITitle.text = resourceManager.getString(BUNDLE, "LBL_OFFERS");
            addChild(this.m_UITitle);
            this.m_UIStack = new ViewStack();
            this.m_UIStack.styleName = "ingameShopOfferBox";
            this.m_UIStack.percentWidth = 100;
            this.m_UIStack.height = 323;
            addChild(this.m_UIStack);
            var _loc_1:* = new VBox();
            var _loc_3:* = 100;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = _loc_3;
            _loc_1.styleName = "ingameShopNoPadding";
            this.m_UIStack.addChild(_loc_1);
            this.m_UIOfferList = new OfferList();
            var _loc_3:* = 100;
            this.m_UIOfferList.percentWidth = 100;
            this.m_UIOfferList.percentHeight = _loc_3;
            this.m_UIOfferList.addEventListener(IngameShopEvent.OFFER_ACTIVATED, this.onOfferDoubleClicked);
            _loc_1.addChild(this.m_UIOfferList);
            this.m_UIOfferDetails = new OfferDetails();
            var _loc_3:* = 100;
            this.m_UIOfferDetails.percentWidth = 100;
            this.m_UIOfferDetails.percentHeight = _loc_3;
            this.m_UIStack.addChild(this.m_UIOfferDetails);
            _loc_1 = new VBox();
            var _loc_3:* = 100;
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = _loc_3;
            _loc_1.styleName = "ingameShopNoPadding";
            this.m_UIStack.addChild(_loc_1);
            this.m_UITransactions = new TransactionHistory();
            var _loc_3:* = 100;
            this.m_UITransactions.percentWidth = 100;
            this.m_UITransactions.percentHeight = _loc_3;
            _loc_1.addChild(this.m_UITransactions);
            this.m_UIBottomButtonBox = new HBox();
            this.m_UIBottomButtonBox.setStyle("horizontalAlign", "right");
            this.m_UIBottomButtonBox.percentWidth = 100;
            this.m_UIBottomButtonBox.setVisible(false);
            addChild(this.m_UIBottomButtonBox);
            this.m_UIPreviousTransactionPage = new Button();
            this.m_UIPreviousTransactionPage.label = resourceManager.getString(BUNDLE, "BTN_HISTORY_PREVIOUS");
            this.m_UIPreviousTransactionPage.width = 75;
            this.m_UIBottomButtonBox.addChild(this.m_UIPreviousTransactionPage);
            var _loc_2:* = new UIComponent();
            _loc_2.percentWidth = 50;
            _loc_2.visible = false;
            this.m_UIBottomButtonBox.addChild(_loc_2);
            this.m_UIBetweenButtonsLabel = new Label();
            this.m_UIBetweenButtonsLabel.visible = false;
            this.m_UIBottomButtonBox.addChild(this.m_UIBetweenButtonsLabel);
            _loc_2 = new UIComponent();
            _loc_2.percentWidth = 50;
            _loc_2.visible = false;
            this.m_UIBottomButtonBox.addChild(_loc_2);
            this.m_UINextTransactionPage = new Button();
            this.m_UINextTransactionPage.label = resourceManager.getString(BUNDLE, "BTN_HISTORY_NEXT");
            this.m_UINextTransactionPage.width = 75;
            this.m_UIBottomButtonBox.addChild(this.m_UINextTransactionPage);
            this.m_UITransactions.setControlledButtonsAndLabel(this.m_UIPreviousTransactionPage, this.m_UINextTransactionPage, this.m_UIBetweenButtonsLabel);
            this.m_UIBackButton = new Button();
            this.m_UIBackButton.width = 75;
            this.m_UIBackButton.label = resourceManager.getString(BUNDLE, "BTN_BACK");
            this.m_UIBackButton.addEventListener(MouseEvent.CLICK, this.onBackClicked);
            this.m_UIBackButton.setVisible(false);
            this.m_UIBottomButtonBox.addChild(this.m_UIBackButton);
            this.m_UIDetailsButton = new Button();
            this.m_UIDetailsButton.label = resourceManager.getString(BUNDLE, "BTN_DETAILS");
            this.m_UIDetailsButton.width = this.m_UIBackButton.width;
            this.m_UIDetailsButton.addEventListener(MouseEvent.CLICK, this.onDetailsClicked);
            this.m_UIBottomButtonBox.addChild(this.m_UIDetailsButton);
            this.m_UIBuyButton = new CustomButton();
            this.m_UIBuyButton.label = resourceManager.getString(BUNDLE, "BTN_BUY");
            this.m_UIBuyButton.styleName = "buyStyle";
            this.m_UIBuyButton.width = this.m_UIBackButton.width;
            this.m_UIBuyButton.addEventListener(MouseEvent.CLICK, this.onBuyClicked);
            this.m_UIBottomButtonBox.addChild(this.m_UIBuyButton);
            this.m_UIGetCoinsButton = new CustomButton();
            this.m_UIGetCoinsButton.label = resourceManager.getString(BUNDLE, "BTN_GET_COINS");
            this.m_UIGetCoinsButton.styleName = "getCoinsGoldStyle";
            this.m_UIGetCoinsButton.labelPlacement = "left";
            this.m_UIGetCoinsButton.width = this.m_UIBackButton.width;
            this.m_UIGetCoinsButton.addEventListener(MouseEvent.CLICK, this.onGetCoinsClick);
            this.m_UIBottomButtonBox.addChild(this.m_UIGetCoinsButton);
            return;
        }// end function

        public function switchToOfferSelection() : void
        {
            this.switchView(VIEW_OFFERS);
            return;
        }// end function

        public function setShowButtonBar(param1:Boolean) : void
        {
            this.m_UIBottomButtonBox.setVisible(param1);
            if (param1)
            {
                this.switchBetweenBuyAndGetCoinsButton();
            }
            return;
        }// end function

        private function switchBetweenBuyAndGetCoinsButton() : void
        {
            var _loc_1:* = null;
            if (this.m_UIStack.selectedIndex != VIEW_TRANSACTIONS)
            {
                _loc_1 = this.m_UIOfferList.getSelectedOffer();
                this.m_UIBuyButton.setVisible(_loc_1 != null && IngameShopManager.getInstance().getCreditBalance() >= _loc_1.price);
                this.m_UIBuyButton.includeInLayout = this.m_UIBuyButton.visible;
                this.m_UIBuyButton.enabled = _loc_1 != null && _loc_1.disabled == false;
                this.m_UIGetCoinsButton.setVisible(!this.m_UIBuyButton.visible);
                this.m_UIGetCoinsButton.includeInLayout = this.m_UIGetCoinsButton.visible;
            }
            return;
        }// end function

        protected function onDetailsClicked(event:Event) : void
        {
            this.switchView(VIEW_DETAILS);
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.OFFER_ACTIVATED);
            _loc_2.data = this.m_UIOfferList.getSelectedOffer();
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function onNameChangeDialogClosed(event:CloseEvent) : void
        {
            this.m_ShopWindow.embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onNameChangeDialogClosed);
            var _loc_2:* = this.m_ShopWindow.embeddedDialog as CharacterNameChangeWidget;
            if (event.detail == EmbeddedDialog.OKAY && _loc_2 != null && _loc_2.desiredName.length > 0)
            {
                IngameShopManager.getInstance().purchaseCharacterNameChange(_loc_2.offerID, _loc_2.desiredName);
                this.switchView(VIEW_OFFERS);
            }
            return;
        }// end function

        protected function onNameChangeRequest(event:IngameShopEvent) : void
        {
            var _loc_2:* = new CharacterNameChangeWidget(int(event.data));
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onNameChangeDialogClosed);
            this.m_ShopWindow.embeddedDialog = _loc_2;
            return;
        }// end function

        protected function onOfferDoubleClicked(event:IngameShopEvent) : void
        {
            this.switchView(VIEW_DETAILS);
            dispatchEvent(event);
            return;
        }// end function

        protected function onBackClicked(event:Event) : void
        {
            this.switchView(VIEW_OFFERS);
            dispatchEvent(new IngameShopEvent(IngameShopEvent.OFFER_DEACTIVATED));
            return;
        }// end function

        protected function onErrorReceived(event:IngameShopEvent) : void
        {
            var _loc_2:* = null;
            if (event.errorType == IngameShopEvent.ERROR_TRANSACTION_HISTORY)
            {
                this.m_UITransactions.displayTransactionHistoryError(event.message);
            }
            else
            {
                _loc_2 = new ShopReponseWidget(event.message, event.errorType);
                this.m_ShopWindow.embeddedDialog = _loc_2;
                this.m_ShopWindow.sideBar.requestOffersForCategory(this.m_ShopWindow.sideBar.getSelectedCategory());
            }
            return;
        }// end function

        private function switchView(param1:int) : void
        {
            var _loc_2:* = this.m_UIOfferList.getSelectedOffer();
            if (param1 == VIEW_OFFERS)
            {
                this.m_UITitle.text = resourceManager.getString(BUNDLE, "LBL_OFFERS");
                this.m_UIStack.selectedIndex = VIEW_OFFERS;
                this.m_UIBackButton.setVisible(false);
                this.m_UIBackButton.includeInLayout = false;
                this.m_UIDetailsButton.setVisible(true);
                this.m_UIDetailsButton.includeInLayout = true;
                this.switchBetweenBuyAndGetCoinsButton();
                this.m_UIPreviousTransactionPage.setVisible(false);
                this.m_UIPreviousTransactionPage.includeInLayout = false;
                this.m_UIBetweenButtonsLabel.setVisible(false);
                this.m_UIBetweenButtonsLabel.includeInLayout = false;
                this.m_UINextTransactionPage.setVisible(false);
                this.m_UINextTransactionPage.includeInLayout = false;
                this.m_UIBottomButtonBox.setVisible(this.m_UIOfferList.getSelectedOffer() != null);
            }
            else if (param1 == VIEW_DETAILS)
            {
                this.m_UITitle.text = resourceManager.getString(BUNDLE, "LBL_DETAILS");
                this.m_UIStack.selectedIndex = VIEW_DETAILS;
                this.m_UIBackButton.setVisible(true);
                this.m_UIBackButton.includeInLayout = true;
                this.m_UIDetailsButton.setVisible(false);
                this.m_UIDetailsButton.includeInLayout = false;
                this.switchBetweenBuyAndGetCoinsButton();
                this.m_UIPreviousTransactionPage.setVisible(false);
                this.m_UIPreviousTransactionPage.includeInLayout = false;
                this.m_UIBetweenButtonsLabel.setVisible(false);
                this.m_UIBetweenButtonsLabel.includeInLayout = false;
                this.m_UINextTransactionPage.setVisible(false);
                this.m_UINextTransactionPage.includeInLayout = false;
                this.m_UIBottomButtonBox.setVisible(this.m_UIOfferList.getSelectedOffer() != null);
            }
            else if (param1 == VIEW_TRANSACTIONS)
            {
                this.m_UITitle.text = resourceManager.getString(BUNDLE, "LBL_HISTORY");
                this.m_UIStack.selectedIndex = VIEW_TRANSACTIONS;
                this.m_UIBackButton.setVisible(false);
                this.m_UIBackButton.includeInLayout = false;
                this.m_UIDetailsButton.setVisible(false);
                this.m_UIDetailsButton.includeInLayout = false;
                this.m_UIBuyButton.setVisible(false);
                this.m_UIBuyButton.includeInLayout = false;
                this.m_UIGetCoinsButton.setVisible(false);
                this.m_UIGetCoinsButton.includeInLayout = false;
                this.m_UIPreviousTransactionPage.setVisible(true);
                this.m_UIPreviousTransactionPage.includeInLayout = true;
                this.m_UIBetweenButtonsLabel.setVisible(false);
                this.m_UIBetweenButtonsLabel.includeInLayout = true;
                this.m_UINextTransactionPage.setVisible(true);
                this.m_UINextTransactionPage.includeInLayout = true;
                this.m_UIBottomButtonBox.setVisible(true);
            }
            return;
        }// end function

        protected function onGetCoinsClick(event:MouseEvent) : void
        {
            this.m_ShopWindow.showGetCoinsConfirmationDialog();
            return;
        }// end function

    }
}
