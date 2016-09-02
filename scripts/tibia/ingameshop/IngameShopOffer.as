package tibia.ingameshop
{
    import __AS3__.vec.*;

    public class IngameShopOffer extends Object
    {
        private var m_DisabledState:int;
        private var m_OfferID:int;
        private var m_BasePrice:Number;
        private var m_Description:String;
        private var m_Products:Vector.<IngameShopProduct>;
        private var m_DisabledReason:String;
        private var m_ActualPrice:Number;
        private var m_SalidValidUntilTimestamp:Number;
        private var m_HighlightState:int;
        private var m_Name:String;
        private var m_IconIdentifiers:Vector.<String>;
        public static const HIGHLIGHT_STATE_SALE:int = 2;
        public static const HIGHLIGHT_STATE_NEW:int = 1;
        public static const DISABLED_STATE_DISABLED:int = 1;
        public static const HIGHLIGHT_STATE_NONE:int = 0;
        public static const DISABLED_STATE_ACTIVE:int = 0;
        public static const DISABLED_STATE_HIDDEN:int = 2;
        public static const HIGHLIGHT_STATE_TIMED:int = 3;

        public function IngameShopOffer(param1:int, param2:String, param3:String)
        {
            this.m_OfferID = param1;
            this.m_Name = param2;
            this.m_Description = param3;
            this.m_Products = new Vector.<IngameShopProduct>;
            this.m_IconIdentifiers = new Vector.<String>;
            this.m_ActualPrice = 0;
            this.m_BasePrice = NaN;
            this.m_HighlightState = HIGHLIGHT_STATE_NONE;
            this.m_DisabledState = DISABLED_STATE_ACTIVE;
            this.m_DisabledReason = "";
            this.m_SalidValidUntilTimestamp = 0;
            return;
        }// end function

        public function set disabledReason(param1:String) : void
        {
            this.m_DisabledReason = param1;
            return;
        }// end function

        public function set highlightState(param1:int) : void
        {
            this.m_HighlightState = param1;
            return;
        }// end function

        public function get highlightState() : int
        {
            return this.m_HighlightState;
        }// end function

        public function set products(param1:Vector.<IngameShopProduct>) : void
        {
            this.m_Products = param1;
            return;
        }// end function

        public function get price() : Number
        {
            return this.m_ActualPrice;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function isTimed() : Boolean
        {
            return this.m_HighlightState == HIGHLIGHT_STATE_TIMED;
        }// end function

        public function isBundle() : Boolean
        {
            return this.m_Products.length > 1;
        }// end function

        public function get disabledState() : int
        {
            return this.m_DisabledState;
        }// end function

        public function isSale() : Boolean
        {
            return this.m_HighlightState == HIGHLIGHT_STATE_SALE;
        }// end function

        public function isNew() : Boolean
        {
            return this.m_HighlightState == HIGHLIGHT_STATE_NEW;
        }// end function

        public function get disabledReason() : String
        {
            return this.m_DisabledReason;
        }// end function

        public function set price(param1:Number) : void
        {
            this.m_ActualPrice = param1;
            return;
        }// end function

        public function set iconIdentifiers(param1:Vector.<String>) : void
        {
            this.m_IconIdentifiers = param1;
            return;
        }// end function

        public function clone() : IngameShopOffer
        {
            var Clone:* = new IngameShopOffer(this.m_OfferID, this.m_Name, this.m_Description);
            Clone.m_ActualPrice = this.m_ActualPrice;
            Clone.m_BasePrice = this.m_BasePrice;
            Clone.m_HighlightState = this.m_HighlightState;
            Clone.m_Products = this.m_Products.map(function (param1:IngameShopProduct) : IngameShopProduct
            {
                return param1.clone();
            }// end function
            );
            Clone.m_IconIdentifiers = this.m_IconIdentifiers;
            Clone.m_DisabledReason = this.m_DisabledReason;
            Clone.m_DisabledState = this.m_DisabledState;
            Clone.m_SalidValidUntilTimestamp = this.m_SalidValidUntilTimestamp;
            return Clone;
        }// end function

        public function set disabledState(param1:int) : void
        {
            if (param1 != DISABLED_STATE_ACTIVE && param1 != DISABLED_STATE_DISABLED && param1 != DISABLED_STATE_HIDDEN)
            {
                throw ArgumentError("IngameShopOffer.disabled (set): Invalid disabled state " + param1);
            }
            this.m_DisabledState = param1;
            return;
        }// end function

        public function get products() : Vector.<IngameShopProduct>
        {
            return this.m_Products;
        }// end function

        public function set basePrice(param1:Number) : void
        {
            this.m_BasePrice = param1;
            return;
        }// end function

        public function get iconIdentifiers() : Vector.<String>
        {
            return this.m_IconIdentifiers;
        }// end function

        public function set saleValidUntilTimestamp(param1:Number) : void
        {
            this.m_SalidValidUntilTimestamp = param1;
            return;
        }// end function

        public function get saleValidUntilTimestamp() : Number
        {
            return this.m_SalidValidUntilTimestamp;
        }// end function

        public function get disabled() : Boolean
        {
            return this.m_DisabledState != DISABLED_STATE_ACTIVE;
        }// end function

        public function get offerID() : int
        {
            return this.m_OfferID;
        }// end function

        public function get basePrice() : Number
        {
            return this.m_BasePrice;
        }// end function

        public function priceReductionPercent() : Number
        {
            var _loc_1:* = NaN;
            if (!isNaN(this.m_BasePrice) && this.m_BasePrice > 0 && this.m_BasePrice > this.m_ActualPrice)
            {
                _loc_1 = this.m_ActualPrice / this.m_BasePrice;
                return 1 - _loc_1;
            }
            return 0;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}
