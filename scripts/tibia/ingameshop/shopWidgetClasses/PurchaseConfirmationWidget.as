package tibia.ingameshop.shopWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.ingameshop.*;

    public class PurchaseConfirmationWidget extends EmbeddedDialog
    {
        private var m_Offer:IngameShopOffer;
        private var m_UIShowDialogCheckbox:CheckBox;
        private static const BUNDLE:String = "IngameShopWidget";

        public function PurchaseConfirmationWidget(param1:IngameShopOffer)
        {
            this.m_Offer = param1;
            title = resourceManager.getString(BUNDLE, "TITLE_PURCHASE_CONFIRMATION");
            buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            width = IngameShopWidget.EMBEDDED_DIALOG_WIDTH;
            minHeight = 170;
            return;
        }// end function

        public function hasCheckedDoNotShowDialogAgain() : Boolean
        {
            return this.m_UIShowDialogCheckbox.selected;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_2:* = null;
            super.createChildren();
            var _loc_1:* = new OfferDisplayBlock();
            _loc_1.percentWidth = 100;
            _loc_1.offer = this.m_Offer;
            text = resourceManager.getString(BUNDLE, "LBL_PURCHASE_CONFIRMATION", [this.m_Offer.name]);
            _loc_2 = new HBox();
            _loc_2.percentWidth = 100;
            _loc_2.setStyle("verticalAlign", "middle");
            this.m_UIShowDialogCheckbox = new CheckBox();
            this.m_UIShowDialogCheckbox.setStyle("paddingLeft", 2);
            _loc_2.addChild(this.m_UIShowDialogCheckbox);
            var _loc_3:* = new Text();
            _loc_3.percentWidth = 100;
            _loc_3.setStyle("paddingRight", 2);
            _loc_3.text = resourceManager.getString(BUNDLE, "LBL_SHOW_CONFIRMATION_DIALOG");
            _loc_2.addChild(_loc_3);
            content.addChild(_loc_1);
            content.addChild(_loc_2);
            content.setStyle("verticalGap", 6);
            return;
        }// end function

    }
}
