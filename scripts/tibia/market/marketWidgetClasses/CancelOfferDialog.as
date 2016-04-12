package tibia.market.marketWidgetClasses
{
    import shared.controls.*;
    import tibia.market.*;

    public class CancelOfferDialog extends EmbeddedDialog
    {
        private var m_Offer:Offer = null;
        private var m_UncommittedOffer:Boolean = false;
        private static const BUNDLE:String = "MarketWidget";

        public function CancelOfferDialog()
        {
            buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
            title = resourceManager.getString(BUNDLE, "MARKET_DIALOG_GENERIC_TITLE");
            text = resourceManager.getString(BUNDLE, "MARKET_DIALOG_CANCEL_TEXT");
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOffer)
            {
                this.m_UncommittedOffer = false;
            }
            return;
        }// end function

        public function set offer(param1:Offer) : void
        {
            if (this.m_Offer != param1)
            {
                this.m_Offer = param1;
                this.m_UncommittedOffer = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get offer() : Offer
        {
            return this.m_Offer;
        }// end function

    }
}
