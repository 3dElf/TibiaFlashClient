package tibia.ingameshop.shopWidgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import tibia.ingameshop.*;

    public class OfferDisplayBlock extends HBox
    {
        private var m_UIPrice:CoinWidget;
        private var m_Offer:IngameShopOffer;
        private var m_UncommittedOffer:Boolean;
        private var m_UITitle:Text;
        private var m_UIIcon:SliderImage;
        private static const BUNDLE:String = "IngameShopWidget";

        public function OfferDisplayBlock()
        {
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedOffer)
            {
                if (this.m_Offer != null)
                {
                    this.m_UITitle.text = this.m_Offer.name;
                    this.m_UIPrice.coins = this.m_Offer.price;
                    this.m_UIIcon.setImageIdentifiers(this.m_Offer.iconIdentifiers);
                }
                else
                {
                    this.m_UIIcon.dynamicImage = null;
                }
                this.m_UncommittedOffer = false;
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

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIIcon = new SliderImage(64);
            this.m_UIIcon.setStyle("paddingTop", 2);
            this.m_UIIcon.setStyle("paddingBottom", 12);
            addChild(this.m_UIIcon);
            var _loc_1:* = new VBox();
            var _loc_2:* = 100;
            _loc_1.percentHeight = 100;
            _loc_1.percentWidth = _loc_2;
            _loc_1.setStyle("verticalGap", 2);
            _loc_1.setStyle("verticalAlign", "middle");
            addChild(_loc_1);
            this.m_UITitle = new Text();
            this.m_UITitle.styleName = "ingameShopBold";
            _loc_1.addChild(this.m_UITitle);
            this.m_UIPrice = new CoinWidget();
            this.m_UIPrice.percentWidth = 100;
            _loc_1.addChild(this.m_UIPrice);
            return;
        }// end function

        public function get offer() : IngameShopOffer
        {
            return this.m_Offer;
        }// end function

    }
}
