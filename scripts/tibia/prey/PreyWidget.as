package tibia.prey
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import mx.resources.*;
    import shared.controls.*;
    import shared.utility.i18n.*;
    import tibia.controls.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.ingameshop.*;
    import tibia.network.*;
    import tibia.prey.preyWidgetClasses.*;

    public class PreyWidget extends PopUpBase
    {
        private var m_UIConstructed:Boolean = false;
        private var m_UIPreyViews:Vector.<PreyView> = null;
        private var m_UIBonusRerollBalance:TibiaCurrencyView = null;
        private var m_UncommittedResources:Boolean = false;
        private var m_UIGoldBalance:TibiaCurrencyView = null;
        private static var s_CurrentInstance:PreyWidget = null;
        private static const BUNDLE:String = "PreyWidget";

        public function PreyWidget()
        {
            width = 689;
            height = 515;
            title = resourceManager.getString(BUNDLE, "TITLE");
            buttonFlags = PopUpBase.BUTTON_CLOSE;
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            stretchEmbeddedDialog = true;
            return;
        }// end function

        protected function onPreyManagerDataChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "*" || event.property == "bonusRerollAmount")
            {
                this.m_UncommittedResources = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            super.hide(param1);
            for each (_loc_2 in this.m_UIPreyViews)
            {
                
                _loc_2.dispose();
            }
            Tibia.s_GetPlayer().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerDataChanged);
            PreyManager.getInstance().removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyManagerDataChanged);
            s_CurrentInstance = null;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedResources)
            {
                _loc_1 = Tibia.s_GetPlayer();
                this.m_UIGoldBalance.currentCurrency = _loc_1.bankGoldBalance + _loc_1.inventoryGoldBalance;
                this.m_UIGoldBalance.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_RESOURCES_GOLD", [i18nFormatNumber(_loc_1.inventoryGoldBalance), i18nFormatNumber(_loc_1.bankGoldBalance)]);
                this.m_UIBonusRerollBalance.currentCurrency = PreyManager.getInstance().bonusRerollAmount;
                this.m_UncommittedResources = false;
            }
            return;
        }// end function

        protected function onPlayerDataChanged(event:PropertyChangeEvent) : void
        {
            if (event.property == "*" || event.property == "bankGoldBalance" || event.property == "inventoryGoldBalance")
            {
                this.m_UncommittedResources = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onBonusRerollPurchaseRequested(event:MouseEvent) : void
        {
            IngameShopManager.getInstance().openShopWindow(true, IngameShopProduct.SERVICE_TYPE_PREY);
            return;
        }// end function

        public function showMessageDialog(param1:String) : void
        {
            var _loc_2:* = null;
            _loc_2 = new EmbeddedDialog();
            _loc_2.title = resourceManager.getString(BUNDLE, "PREY_TITLE");
            _loc_2.text = param1;
            _loc_2.buttonFlags = EmbeddedDialog.OKAY;
            embeddedDialog = _loc_2;
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.percentWidth = 100;
                addChild(_loc_1);
                this.m_UIPreyViews = new Vector.<PreyView>;
                for each (_loc_2 in PreyManager.getInstance().preys)
                {
                    
                    _loc_5 = new PreyView(this);
                    _loc_5.data = _loc_2;
                    this.m_UIPreyViews.push(_loc_5);
                    _loc_1.addChild(_loc_5);
                }
                _loc_3 = new HBox();
                _loc_3.percentWidth = 100;
                addChild(_loc_3);
                this.m_UIGoldBalance = new TibiaCurrencyView();
                this.m_UIGoldBalance.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_GOLD_COIN;
                this.m_UIGoldBalance.width = 125;
                _loc_3.addChild(this.m_UIGoldBalance);
                this.m_UIBonusRerollBalance = new TibiaCurrencyView();
                this.m_UIBonusRerollBalance.currencyIcon = TibiaCurrencyView.CURRENCY_ICON_BONUS_REROLL;
                this.m_UIBonusRerollBalance.width = 50;
                _loc_3.addChild(this.m_UIBonusRerollBalance);
                _loc_4 = new CustomButton();
                _loc_4.styleName = "purchaseBonusRerollsButton";
                _loc_4.toolTip = resourceManager.getString(BUNDLE, "TOOLTIP_PURCHASE_BONUSREROLLS");
                _loc_4.width = 30;
                _loc_4.addEventListener(MouseEvent.CLICK, this.onBonusRerollPurchaseRequested);
                _loc_3.addChild(_loc_4);
                Tibia.s_GetPlayer().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPlayerDataChanged);
                PreyManager.getInstance().addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onPreyManagerDataChanged);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override public function show() : void
        {
            super.show();
            s_CurrentInstance = this;
            var _loc_1:* = Tibia.s_GetCommunication();
            if (_loc_1 != null)
            {
                _loc_1.sendCREQUESTRESOURCEBALANCE(Communication.RESOURCETYPE_BANK_GOLD);
                _loc_1.sendCREQUESTRESOURCEBALANCE(Communication.RESOURCETYPE_INVENTORY_GOLD);
                _loc_1.sendCREQUESTRESOURCEBALANCE(Communication.RESOURCETYPE_PREY_BONUS_REROLLS);
            }
            this.m_UncommittedResources = true;
            invalidateProperties();
            return;
        }// end function

        public static function s_GetCurrentInstance() : PreyWidget
        {
            return s_CurrentInstance;
        }// end function

        public static function s_ShowIfAppropriate() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (Tibia.s_GetPlayer().hasReachedMain)
            {
                new PreyWidget.show();
            }
            else
            {
                _loc_1 = ResourceManager.getInstance();
                if (_loc_1 == null)
                {
                    return;
                }
                _loc_2 = new MessageWidget();
                _loc_2.title = _loc_1.getString(BUNDLE, "NOT_AVAILABLE_TITLE");
                _loc_2.message = _loc_1.getString(BUNDLE, "NOT_AVAILABLE_TEXT");
                _loc_2.buttonFlags = PopUpBase.BUTTON_OKAY;
                _loc_2.keyboardFlags = PopUpBase.KEY_ESCAPE | PopUpBase.KEY_ENTER;
                _loc_2.show();
            }
            return;
        }// end function

    }
}
