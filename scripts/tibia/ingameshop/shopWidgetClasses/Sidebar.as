package tibia.ingameshop.shopWidgetClasses
{
    import __AS3__.vec.*;
    import flash.errors.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;
    import tibia.network.*;

    public class Sidebar extends VBox implements IIngameShopWidgetComponent
    {
        private var m_UICreditText:CoinWidget;
        private var m_UIHistory:Button;
        private var m_UIGetCoins:Button;
        private var m_UISubCategories:List;
        private var m_UncommitedSubCategories:Boolean = false;
        private var m_UITransferCoinsButton:Button;
        private var m_ShopManager:IngameShopManager;
        private var m_UISubCategoriesBox:VBox;
        private var m_ShopWindow:IngameShopWidget;
        private var m_UncommitedCredits:Boolean = false;
        private var m_UIMainCategories:List;
        private var m_UncommitedMainCategories:Boolean = false;
        private static const CATEGORY_LINE_HEIGHT:int = 36;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const MAIN_CATEGORIES_HALF_HEIGHT:int = 189;
        private static const MAIN_CATEGORIES_FULL_HEIGHT:int = 321;

        public function Sidebar()
        {
            this.m_ShopManager = IngameShopManager.getInstance();
            this.m_ShopManager.addEventListener(IngameShopEvent.CREDIT_BALANCE_CHANGED, this.onCreditBalanceChanged);
            return;
        }// end function

        private function updateSubCategoriesList() : void
        {
            var Data:Array;
            var SelectedCategory:* = this.m_UIMainCategories.selectedItem as IngameShopCategory;
            if (SelectedCategory != null && SelectedCategory.subCategories.length > 0)
            {
                Data = new Array();
                SelectedCategory.subCategories.forEach(function (param1:IngameShopCategory, param2:int, param3:Vector.<IngameShopCategory>) : void
            {
                Data.push(param1);
                return;
            }// end function
            );
                this.m_UISubCategories.dataProvider = new ArrayCollection(Data);
                this.m_UIMainCategories.height = MAIN_CATEGORIES_HALF_HEIGHT;
                this.m_UISubCategoriesBox.setVisible(true);
                this.m_UISubCategoriesBox.includeInLayout = true;
            }
            else
            {
                this.m_UISubCategories.dataProvider = null;
                this.m_UIMainCategories.height = MAIN_CATEGORIES_FULL_HEIGHT;
                this.m_UISubCategoriesBox.setVisible(false);
                this.m_UISubCategoriesBox.includeInLayout = false;
            }
            return;
        }// end function

        public function selectFirstCategory() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.m_UIMainCategories.dataProvider != null && (this.m_UIMainCategories.dataProvider as ListCollectionView).length > 0)
            {
                _loc_1 = (this.m_UIMainCategories.dataProvider as ListCollectionView).getItemAt(0) as IngameShopCategory;
                this.m_UIMainCategories.selectedItem = _loc_1;
                this.m_UncommitedSubCategories = true;
                invalidateProperties();
                _loc_2 = new IngameShopEvent(IngameShopEvent.CATEGORY_SELECTED);
                _loc_2.data = _loc_1;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        protected function onGetCoinsClick(event:MouseEvent) : void
        {
            this.m_ShopWindow.showGetCoinsConfirmationDialog();
            return;
        }// end function

        public function requestOffersForCategory(param1:IngameShopCategory) : void
        {
            var _loc_2:* = Tibia.s_GetCommunication();
            if (param1 != null && _loc_2 != null && _loc_2.isGameRunning)
            {
                _loc_2.sendCREQUESTSHOPOFFERS(param1.name);
            }
            return;
        }// end function

        protected function onCategoryChange(event:ListEvent) : void
        {
            var _loc_2:* = null;
            if (this.m_UIMainCategories.selectedIndex == -1)
            {
                this.m_UIMainCategories.selectedIndex = event.rowIndex;
                event.preventDefault();
                event.stopPropagation();
            }
            else
            {
                this.m_UncommitedSubCategories = true;
                invalidateProperties();
                _loc_2 = new IngameShopEvent(IngameShopEvent.CATEGORY_SELECTED);
                _loc_2.data = event.itemRenderer.data;
                dispatchEvent(_loc_2);
                this.requestOffersForCategory(_loc_2.data as IngameShopCategory);
            }
            return;
        }// end function

        protected function onTransferCoinsClicked(event:Event) : void
        {
            var _loc_2:* = new TransferCoinsWidget();
            _loc_2.addEventListener(CloseEvent.CLOSE, this.onTransferCoinsDialogClosed);
            this.m_ShopWindow.embeddedDialog = _loc_2;
            return;
        }// end function

        protected function onCreditBalanceChanged(event:IngameShopEvent) : void
        {
            this.m_UncommitedCredits = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommitedCredits)
            {
                this.updateCreditBalance();
                this.m_UncommitedCredits = false;
            }
            if (this.m_UncommitedMainCategories)
            {
                this.updateMainCategoriesList();
                this.m_UncommitedMainCategories = false;
            }
            if (this.m_UncommitedSubCategories)
            {
                this.updateSubCategoriesList();
                this.m_UncommitedSubCategories = false;
            }
            return;
        }// end function

        protected function onHistoryClick(event:MouseEvent) : void
        {
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.HISTORY_CLICKED);
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function onSubCategoryChange(event:ListEvent) : void
        {
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.CATEGORY_SELECTED);
            _loc_2.data = this.m_UISubCategories.selectedItem != null ? (this.m_UISubCategories.selectedItem) : (this.m_UIMainCategories.selectedItem);
            dispatchEvent(_loc_2);
            this.requestOffersForCategory(_loc_2.data as IngameShopCategory);
            return;
        }// end function

        protected function onTransferCoinsDialogClosed(event:CloseEvent) : void
        {
            this.m_ShopWindow.embeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onTransferCoinsDialogClosed);
            var _loc_2:* = this.m_ShopWindow.embeddedDialog as TransferCoinsWidget;
            if (event.detail == EmbeddedDialog.OKAY && _loc_2 != null && _loc_2.transferAmount > 0 && _loc_2.transferTargetName.length > 0)
            {
                IngameShopManager.getInstance().transferCredits(_loc_2.transferTargetName, _loc_2.transferAmount);
            }
            return;
        }// end function

        public function selectCategory(param1:IngameShopCategory) : void
        {
            var _loc_2:* = null;
            if (param1 != null && this.m_UIMainCategories.dataProvider != null && (this.m_UIMainCategories.dataProvider as ListCollectionView).length > 0 && this.m_UIMainCategories.selectedItem != param1)
            {
                this.m_UIMainCategories.selectedItem = param1;
                this.m_UncommitedSubCategories = true;
                invalidateProperties();
                _loc_2 = new IngameShopEvent(IngameShopEvent.CATEGORY_SELECTED);
                _loc_2.data = param1;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function updateCreditBalance() : void
        {
            var _loc_1:* = this.m_ShopManager.getCreditBalance();
            this.m_UICreditText.coins = _loc_1;
            this.m_UICreditText.coinsAreFinal = this.m_ShopManager.creditsAreFinal();
            var _loc_2:* = this.m_ShopManager.getConfirmedCreditBalance();
            this.m_UICreditText.toolTip = resourceManager.getString(BUNDLE, _loc_2 == 1 ? ("LBL_CREDITS_TOOLTIP_SINGULAR") : ("LBL_CREDITS_TOOLTIP_PLURAL"), [_loc_2.toFixed()]);
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            var _loc_1:* = new VBox();
            _loc_1.percentWidth = 100;
            _loc_1.height = 48;
            _loc_1.styleName = "ingameShopCreditBox";
            var _loc_2:* = new Label();
            _loc_2.text = resourceManager.getString(BUNDLE, "LBL_CREDITS");
            _loc_1.addChild(_loc_2);
            this.m_UICreditText = new CoinWidget();
            this.m_UncommitedCredits = true;
            _loc_1.addChild(this.m_UICreditText);
            addChild(_loc_1);
            var _loc_3:* = new HBox();
            _loc_3.percentWidth = 100;
            addChild(_loc_3);
            this.m_UIHistory = new Button();
            this.m_UIHistory.label = resourceManager.getString(BUNDLE, "BTN_HISTORY");
            this.m_UIHistory.percentWidth = 50;
            this.m_UIHistory.addEventListener(MouseEvent.CLICK, this.onHistoryClick);
            _loc_3.addChild(this.m_UIHistory);
            this.m_UIGetCoins = new Button();
            this.m_UIGetCoins.label = resourceManager.getString(BUNDLE, "BTN_GET_COINS");
            this.m_UIGetCoins.styleName = "getCoinsStyle";
            this.m_UIGetCoins.labelPlacement = "left";
            this.m_UIGetCoins.percentWidth = 50;
            this.m_UIGetCoins.addEventListener(MouseEvent.CLICK, this.onGetCoinsClick);
            _loc_3.addChild(this.m_UIGetCoins);
            var _loc_4:* = new Label();
            _loc_2.percentWidth = 100;
            _loc_4.text = resourceManager.getString(BUNDLE, "LBL_CATEGORIES");
            addChild(_loc_4);
            this.m_UIMainCategories = new List();
            this.m_UIMainCategories.percentWidth = 100;
            this.m_UIMainCategories.height = MAIN_CATEGORIES_HALF_HEIGHT;
            this.m_UIMainCategories.rowHeight = CATEGORY_LINE_HEIGHT;
            this.m_UIMainCategories.styleName = "ingameShopCategories";
            this.m_UIMainCategories.variableRowHeight = false;
            this.m_UIMainCategories.itemRenderer = new ClassFactory(CategoryRenderer);
            this.m_UIMainCategories.addEventListener(ListEvent.CHANGE, this.onCategoryChange);
            this.m_UIMainCategories.addEventListener(ListEvent.ITEM_CLICK, this.onCategoryClicked);
            this.m_UncommitedMainCategories = true;
            var _loc_5:* = new VBox();
            _loc_1.percentWidth = 100;
            _loc_5.styleName = "ingameShopCategoryBox";
            _loc_5.addChild(this.m_UIMainCategories);
            addChild(_loc_5);
            this.m_UISubCategoriesBox = new VBox();
            this.m_UISubCategoriesBox.percentWidth = 100;
            this.m_UISubCategoriesBox.setStyle("verticalGap", 2);
            this.m_UncommitedSubCategories = true;
            var _loc_6:* = new Label();
            _loc_2.percentWidth = 100;
            _loc_6.text = resourceManager.getString(BUNDLE, "LBL_SUBCATEGORIES");
            this.m_UISubCategoriesBox.addChild(_loc_6);
            this.m_UISubCategories = new List();
            this.m_UISubCategories.percentWidth = 100;
            this.m_UISubCategories.rowHeight = CATEGORY_LINE_HEIGHT;
            this.m_UISubCategories.rowCount = 3;
            this.m_UISubCategories.styleName = "ingameShopCategories";
            this.m_UISubCategories.itemRenderer = new ClassFactory(CategoryRenderer);
            this.m_UISubCategories.addEventListener(ListEvent.CHANGE, this.onSubCategoryChange);
            this.m_UISubCategories.addEventListener(ListEvent.ITEM_CLICK, this.onCategoryClicked);
            var _loc_7:* = new VBox();
            _loc_1.percentWidth = 100;
            _loc_7.styleName = "ingameShopCategoryBox";
            _loc_7.addChild(this.m_UISubCategories);
            this.m_UISubCategoriesBox.addChild(_loc_7);
            this.m_UISubCategoriesBox.addChild(_loc_7);
            addChild(this.m_UISubCategoriesBox);
            var _loc_8:* = new HBox();
            _loc_3.percentWidth = 100;
            this.m_UITransferCoinsButton = new Button();
            this.m_UITransferCoinsButton.percentWidth = 50;
            this.m_UITransferCoinsButton.toolTip = resourceManager.getString(BUNDLE, "LBL_TRANSFER_COINS_TOOLTIP");
            this.m_UITransferCoinsButton.styleName = "transferCoinsButton";
            this.m_UITransferCoinsButton.addEventListener(MouseEvent.CLICK, this.onTransferCoinsClicked);
            _loc_8.addChild(this.m_UITransferCoinsButton);
            addChild(_loc_8);
            return;
        }// end function

        public function dispose() : void
        {
            this.m_ShopManager.removeEventListener(IngameShopEvent.CREDIT_BALANCE_CHANGED, this.onCreditBalanceChanged);
            this.m_UIHistory.removeEventListener(MouseEvent.CLICK, this.onHistoryClick);
            this.m_UIGetCoins.removeEventListener(MouseEvent.CLICK, this.onGetCoinsClick);
            this.m_UIMainCategories.removeEventListener(ListEvent.CHANGE, this.onCategoryChange);
            this.m_UIMainCategories.removeEventListener(ListEvent.ITEM_CLICK, this.onCategoryClicked);
            this.m_UISubCategories.removeEventListener(ListEvent.ITEM_CLICK, this.onCategoryClicked);
            this.m_UISubCategories.removeEventListener(ListEvent.CHANGE, this.onSubCategoryChange);
            this.m_UITransferCoinsButton.removeEventListener(MouseEvent.CLICK, this.onTransferCoinsClicked);
            this.m_ShopWindow = null;
            return;
        }// end function

        private function updateMainCategoriesList() : void
        {
            var Data:Array;
            Data = new Array();
            this.m_ShopManager.getRootCategories().forEach(function (param1:IngameShopCategory, param2:int, param3:Vector.<IngameShopCategory>) : void
            {
                Data.push(param1);
                return;
            }// end function
            );
            this.m_UIMainCategories.dataProvider = new ArrayCollection(Data);
            return;
        }// end function

        public function getSelectedCategory() : IngameShopCategory
        {
            if (this.m_UISubCategories.selectedIndex > -1)
            {
                return this.m_UISubCategories.selectedItem as IngameShopCategory;
            }
            if (this.m_UIMainCategories.selectedIndex > -1)
            {
                return this.m_UIMainCategories.selectedItem as IngameShopCategory;
            }
            return null;
        }// end function

        protected function onCategoryClicked(event:ListEvent) : void
        {
            if (this.m_ShopWindow != null)
            {
                this.m_ShopWindow.mainView.switchToOfferSelection();
            }
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

    }
}
