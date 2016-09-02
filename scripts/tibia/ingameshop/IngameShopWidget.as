package tibia.ingameshop
{
    import mx.containers.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.game.*;
    import tibia.ingameshop.shopWidgetClasses.*;
    import tibia.premium.*;

    public class IngameShopWidget extends PopUpBase
    {
        private var m_UIMainView:MainContentPane;
        private var m_UIHeader:Header;
        private var m_UISidebar:Sidebar;
        private static var s_CurrentInstance:IngameShopWidget = null;
        private static const BUNDLE:String = "IngameShopWidget";
        public static const EMBEDDED_DIALOG_WIDTH:int = 380;

        public function IngameShopWidget()
        {
            height = 512;
            width = 700;
            title = resourceManager.getString(BUNDLE, "TITLE");
            buttonFlags = PopUpBase.BUTTON_CLOSE;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            stretchEmbeddedDialog = false;
            return;
        }// end function

        public function get offerList() : OfferList
        {
            return this.m_UIMainView.offerList;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            super.hide(param1);
            this.m_UISidebar.removeEventListener(IngameShopEvent.CATEGORY_SELECTED, this.onCategorySelected);
            this.m_UISidebar.removeEventListener(IngameShopEvent.HISTORY_CLICKED, this.onHistoryClicked);
            this.m_UIMainView.removeEventListener(IngameShopEvent.OFFER_ACTIVATED, this.onOfferDetails);
            this.m_UIMainView.removeEventListener(IngameShopEvent.OFFER_DEACTIVATED, this.onOfferDetailsClosed);
            this.m_UIHeader.dispose();
            this.m_UIMainView.dispose();
            this.m_UISidebar.dispose();
            s_CurrentInstance = null;
            return;
        }// end function

        public function get shopHeader() : Header
        {
            return this.m_UIHeader;
        }// end function

        protected function onOfferDetails(event:IngameShopEvent) : void
        {
            this.m_UIHeader.data = event.data;
            return;
        }// end function

        public function showGetCoinsConfirmationDialog() : void
        {
            var _loc_1:* = null;
            _loc_1 = new EmbeddedDialog();
            _loc_1.width = IngameShopWidget.EMBEDDED_DIALOG_WIDTH;
            _loc_1.title = resourceManager.getString(BUNDLE, "TITLE_GET_COINS");
            _loc_1.text = resourceManager.getString(BUNDLE, "LBL_GET_COINS");
            _loc_1.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            _loc_1.addEventListener(CloseEvent.CLOSE, this.onGetCoinsConfirmationClick);
            _loc_1.styleName = "getCoinConfirmation";
            embeddedDialog = _loc_1;
            return;
        }// end function

        protected function onGetCoinsConfirmationClick(event:CloseEvent) : void
        {
            embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onGetCoinsConfirmationClick);
            if (event.detail == EmbeddedDialog.YES)
            {
                Tibia.s_GetPremiumManager().goToPaymentWebsite(PremiumManager.PREMIUM_BUTTON_SHOP);
            }
            return;
        }// end function

        protected function onOfferDetailsClosed(event:IngameShopEvent) : void
        {
            this.m_UIHeader.data = this.m_UISidebar.getSelectedCategory();
            return;
        }// end function

        protected function onHistoryClicked(event:IngameShopEvent) : void
        {
            this.m_UIHeader.setStaticHeader(Header.STATIC_HEADER_TRANSACTION_HISTORY);
            return;
        }// end function

        protected function onCategorySelected(event:IngameShopEvent) : void
        {
            this.m_UIHeader.data = event.data;
            this.m_UIMainView.offerList.data = event.data;
            return;
        }// end function

        public function selectCategory(param1:IngameShopCategory) : void
        {
            this.m_UISidebar.selectCategory(param1);
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            super.createChildren();
            _loc_1 = new HBox();
            _loc_1.percentWidth = 100;
            _loc_1.percentHeight = 100;
            _loc_1.setStyle("horizontalGap", 4);
            addChild(_loc_1);
            this.m_UISidebar = new Sidebar();
            this.m_UISidebar.percentHeight = 100;
            this.m_UISidebar.width = 185;
            _loc_1.addChild(this.m_UISidebar);
            var _loc_2:* = new VBox();
            _loc_2.percentWidth = 100;
            _loc_2.percentHeight = 100;
            _loc_2.setStyle("verticalGap", 2);
            _loc_1.addChild(_loc_2);
            this.m_UIHeader = new Header();
            this.m_UIHeader.percentWidth = 100;
            this.m_UIHeader.height = 71;
            _loc_2.addChild(this.m_UIHeader);
            this.m_UIMainView = new MainContentPane();
            this.m_UIMainView.percentWidth = 100;
            _loc_2.addChild(this.m_UIMainView);
            this.m_UISidebar.shopWidget = this;
            this.m_UIHeader.shopWidget = this;
            this.m_UIMainView.shopWidget = this;
            this.m_UISidebar.addEventListener(IngameShopEvent.CATEGORY_SELECTED, this.onCategorySelected);
            this.m_UISidebar.addEventListener(IngameShopEvent.HISTORY_CLICKED, this.onHistoryClicked);
            this.m_UIMainView.addEventListener(IngameShopEvent.OFFER_ACTIVATED, this.onOfferDetails);
            this.m_UIMainView.addEventListener(IngameShopEvent.OFFER_DEACTIVATED, this.onOfferDetailsClosed);
            return;
        }// end function

        public function get sideBar() : Sidebar
        {
            return this.m_UISidebar;
        }// end function

        override public function show() : void
        {
            super.show();
            this.m_UISidebar.selectFirstCategory();
            s_CurrentInstance = this;
            return;
        }// end function

        public function get mainView() : MainContentPane
        {
            return this.m_UIMainView;
        }// end function

        public static function s_GetCurrentInstance() : IngameShopWidget
        {
            return s_CurrentInstance;
        }// end function

    }
}
