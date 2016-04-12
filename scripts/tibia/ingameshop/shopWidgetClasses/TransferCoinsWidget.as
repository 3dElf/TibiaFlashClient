package tibia.ingameshop.shopWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.controls.*;
    import tibia.creatures.*;
    import tibia.ingameshop.*;

    public class TransferCoinsWidget extends EmbeddedDialog
    {
        private var m_UncommittedCoinsValue:Boolean = true;
        private var m_UITargetName:TextInput;
        private var m_UICoinText:CoinWidget;
        private var m_UIAmountSlider:CustomSlider;
        private static const BUNDLE:String = "IngameShopWidget";

        public function TransferCoinsWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE_TRANSFER_COINS");
            buttonFlags = EmbeddedDialog.OKAY | EmbeddedDialog.CANCEL;
            width = IngameShopWidget.EMBEDDED_DIALOG_WIDTH;
            return;
        }// end function

        public function get transferAmount() : Number
        {
            return this.m_UIAmountSlider.value;
        }// end function

        public function get transferTargetName() : String
        {
            return this.m_UITargetName.text;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedCoinsValue)
            {
                this.m_UICoinText.coins = this.m_UIAmountSlider.value;
                this.m_UncommittedCoinsValue = false;
            }
            return;
        }// end function

        protected function onCoinsSliderChanged(event:SliderEvent) : void
        {
            this.m_UICoinText.coins = event.value;
            return;
        }// end function

        override public function setFocus() : void
        {
            super.setFocus();
            this.m_UITargetName.setFocus();
            return;
        }// end function

        private function getMaximumTransferableCoins() : Number
        {
            var _loc_1:* = IngameShopManager.getInstance().getConfirmedCreditBalance();
            var _loc_2:* = IngameShopManager.getInstance().getCreditPackageSize();
            return _loc_1 - _loc_1 % _loc_2;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_3:* = null;
            super.createChildren();
            text = resourceManager.getString(BUNDLE, "LBL_TRANSFER_COINS");
            var _loc_1:* = new Grid();
            _loc_1.percentWidth = 100;
            content.addChild(_loc_1);
            var _loc_2:* = new GridRow();
            _loc_2.percentWidth = 100;
            _loc_1.addChild(_loc_2);
            _loc_3 = new GridRow();
            _loc_3.percentWidth = 100;
            _loc_1.addChild(_loc_3);
            var _loc_4:* = new GridRow();
            _loc_2.percentWidth = 100;
            _loc_1.addChild(_loc_4);
            var _loc_5:* = new GridItem();
            var _loc_6:* = new Label();
            _loc_6.text = resourceManager.getString(BUNDLE, "LBL_TRANSFER_TARGET");
            _loc_5.addChild(_loc_6);
            _loc_2.addChild(_loc_5);
            _loc_5 = new GridItem();
            _loc_5.percentWidth = 100;
            this.m_UITargetName = new TextInput();
            this.m_UITargetName.percentWidth = 100;
            this.m_UITargetName.maxChars = Creature.MAX_NAME_LENGHT;
            _loc_5.addChild(this.m_UITargetName);
            _loc_2.addChild(_loc_5);
            _loc_5 = new GridItem();
            var _loc_7:* = new Label();
            _loc_6.text = resourceManager.getString(BUNDLE, "LBL_TRANSFER_AMOUNT");
            _loc_5.addChild(_loc_7);
            _loc_3.addChild(_loc_5);
            _loc_5 = new GridItem();
            _loc_5.percentWidth = 100;
            var _loc_8:* = new HBox();
            _loc_8.percentWidth = 100;
            this.m_UIAmountSlider = new CustomSlider();
            this.m_UIAmountSlider.percentWidth = 100;
            var _loc_9:* = IngameShopManager.getInstance().getCreditPackageSize();
            this.m_UIAmountSlider.value = Math.min(_loc_9, this.getMaximumTransferableCoins());
            this.m_UIAmountSlider.minimum = this.m_UIAmountSlider.value;
            this.m_UIAmountSlider.maximum = this.getMaximumTransferableCoins();
            this.m_UIAmountSlider.snapInterval = _loc_9;
            this.m_UIAmountSlider.trackClickAmount = _loc_9;
            this.m_UIAmountSlider.showDataTip = false;
            this.m_UIAmountSlider.addEventListener(SliderEvent.CHANGE, this.onCoinsSliderChanged);
            this.m_UIAmountSlider.addEventListener(SliderEvent.THUMB_DRAG, this.onCoinsSliderChanged);
            _loc_8.addChild(this.m_UIAmountSlider);
            this.m_UICoinText = new CoinWidget();
            this.m_UICoinText.minWidth = 60;
            _loc_8.addChild(this.m_UICoinText);
            _loc_5.addChild(_loc_8);
            _loc_3.addChild(_loc_5);
            _loc_5 = new GridItem();
            var _loc_10:* = new Label();
            _loc_6.text = resourceManager.getString(BUNDLE, "LBL_TRANSFER_BALANCE");
            _loc_5.addChild(_loc_10);
            _loc_4.addChild(_loc_5);
            _loc_5 = new GridItem();
            _loc_5.percentWidth = 100;
            var _loc_11:* = new CoinWidget();
            _loc_11.coins = this.getMaximumTransferableCoins();
            _loc_5.addChild(_loc_11);
            _loc_4.addChild(_loc_5);
            return;
        }// end function

    }
}
