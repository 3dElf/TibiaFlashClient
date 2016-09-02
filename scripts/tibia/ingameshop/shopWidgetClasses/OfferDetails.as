package tibia.ingameshop.shopWidgetClasses
{
    import flash.errors.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.utility.i18n.*;
    import tibia.ingameshop.*;
    import tibia.ingameshop.shopWidgetClasses.*;

    public class OfferDetails extends VBox implements IIngameShopWidgetComponent
    {
        private var m_UIBundleBox:VBox;
        private var m_UIDescriptionText:Text;
        private var m_UncommittedOffer:Boolean;
        private var m_UIProductGrid:Grid;
        private var m_Offer:IngameShopOffer;
        private var m_ShopWindow:IngameShopWidget;
        private static const BUNDLE:String = "IngameShopWidget";
        private static const DISABLED_REASON_COLOR:String = 13843516.toString(16);

        public function OfferDetails()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIDescriptionText = new Text();
            this.m_UIDescriptionText.percentWidth = 100;
            addChild(this.m_UIDescriptionText);
            this.m_UIBundleBox = new VBox();
            this.m_UIBundleBox.percentWidth = 100;
            this.m_UIBundleBox.styleName = "ingameShopNoPadding";
            addChild(this.m_UIBundleBox);
            var _loc_1:* = new Label();
            _loc_1.text = resourceManager.getString(BUNDLE, "LBL_BUNDLE");
            _loc_1.styleName = "ingameShopBold";
            this.m_UIBundleBox.addChild(_loc_1);
            this.m_UIProductGrid = new Grid();
            this.m_UIProductGrid.percentWidth = 100;
            this.m_UIBundleBox.addChild(this.m_UIProductGrid);
            return;
        }// end function

        private function formatTimeLeftString(param1:Number) : String
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_2:* = param1 - Math.floor(new Date().time / 1000);
            if (_loc_2 > 0)
            {
                _loc_3 = _loc_2 / 86400;
                _loc_4 = _loc_2 % 86400 / (60 * 60);
                if (_loc_3 > 0)
                {
                    return resourceManager.getString(BUNDLE, _loc_3 == 1 ? ("TEXT_SALE_DURATION_DAY") : ("TEXT_SALE_DURATION_DAYS"), [_loc_3]);
                }
                else if (_loc_4 > 0)
                {
                    return resourceManager.getString(BUNDLE, _loc_4 == 1 ? ("TEXT_SALE_DURATION_HOUR") : ("TEXT_SALE_DURATION_HOURS"), [_loc_4]);
                }
                else
                {
                    return resourceManager.getString(BUNDLE, "TEXT_SALE_DURATION_MINUTES");
                }
            }
            else
            {
            }
            return resourceManager.getString(BUNDLE, "TEXT_SALE_DURATION_MINUTES");
        }// end function

        public function dispose() : void
        {
            this.m_ShopWindow = null;
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            if (this.m_UncommittedOffer)
            {
                if (this.m_Offer != null)
                {
                    _loc_1 = "";
                    if (this.m_Offer.disabled)
                    {
                        _loc_1 = _loc_1 + ("<p><font color=\"#" + DISABLED_REASON_COLOR + "\">");
                        _loc_1 = _loc_1 + (resourceManager.getString(BUNDLE, "LBL_CANNOT_BUY_GENERIC") + "\n" + this.m_Offer.disabledReason);
                        _loc_1 = _loc_1 + "</font></p>\n";
                    }
                    if (this.m_Offer.isSale())
                    {
                        _loc_1 = _loc_1 + "<p>";
                        _loc_1 = _loc_1 + resourceManager.getString(BUNDLE, "TEXT_SALE_DESCRIPTION", [i18nFormatDate(new Date(this.m_Offer.saleValidUntilTimestamp * 1000)), this.formatTimeLeftString(this.m_Offer.saleValidUntilTimestamp), resourceManager.getString(BUNDLE, this.m_Offer.price == 1 ? ("LBL_CREDITS_LONG_SINGULAR") : ("LBL_CREDITS_LONG_PLURAL"), [this.m_Offer.price]), (this.m_Offer.priceReductionPercent() * 100).toFixed(0), resourceManager.getString(BUNDLE, this.m_Offer.basePrice == 1 ? ("LBL_CREDITS_LONG_SINGULAR") : ("LBL_CREDITS_LONG_PLURAL"), [this.m_Offer.basePrice])]);
                        _loc_1 = _loc_1 + "</p>\n";
                    }
                    _loc_1 = _loc_1 + this.m_Offer.description;
                    this.m_UIDescriptionText.htmlText = _loc_1;
                    this.m_UIBundleBox.setVisible(this.m_Offer.isBundle());
                    this.buildBundleGrid();
                }
                this.m_UncommittedOffer = false;
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

        public function get offer() : IngameShopOffer
        {
            return this.m_Offer;
        }// end function

        private function buildBundleGrid() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this.m_UIProductGrid.removeAllChildren();
            for each (_loc_1 in this.m_Offer.products)
            {
                
                _loc_2 = new GridRow();
                _loc_3 = new GridItem();
                _loc_4 = new GridItem();
                _loc_4.setStyle("verticalAlign", "middle");
                _loc_2.addChild(_loc_3);
                _loc_2.addChild(_loc_4);
                this.m_UIProductGrid.addChild(_loc_2);
                _loc_5 = new SliderImage(64);
                _loc_5.setImageIdentifiers(_loc_1.iconIdentifiers);
                _loc_5.toolTip = _loc_1.description;
                _loc_3.addChild(_loc_5);
                _loc_6 = new Label();
                _loc_6.text = _loc_1.name;
                _loc_6.toolTip = _loc_1.description;
                _loc_4.addChild(_loc_6);
            }
            return;
        }// end function

        public function set offer(param1:IngameShopOffer) : void
        {
            this.m_Offer = param1;
            this.m_UncommittedOffer = true;
            invalidateProperties();
            return;
        }// end function

    }
}
