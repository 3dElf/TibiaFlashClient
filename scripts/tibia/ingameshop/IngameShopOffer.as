package tibia.ingameshop
{
    import __AS3__.vec.*;

    public class IngameShopOffer extends Object
    {
        private var m_OfferID:int;
        private var m_Description:String;
        private var m_Products:Vector.<IngameShopProduct>;
        private var m_State:int;
        private var m_ActualPrice:Number;
        private var m_Disabled:Boolean;
        private var m_Name:String;
        private var m_IconIdentifiers:Vector.<String>;
        static const STATE_TIMED:int = 3;
        static const STATE_NEW:int = 1;
        static const STATE_SALE:int = 2;
        static const STATE_NONE:int = 0;

        public function IngameShopOffer(param1:int, param2:String, param3:String)
        {
            this.m_OfferID = param1;
            this.m_Name = param2;
            this.m_Description = param3;
            this.m_Products = new Vector.<IngameShopProduct>;
            this.m_IconIdentifiers = new Vector.<String>;
            this.m_ActualPrice = 0;
            this.m_State = STATE_NONE;
            this.m_Disabled = false;
            return;
        }// end function

        public function get disabled() : Boolean
        {
            return this.m_Disabled;
        }// end function

        public function set iconIdentifiers(param1:Vector.<String>) : void
        {
            this.m_IconIdentifiers = param1;
            return;
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

        public function isBundle() : Boolean
        {
            return this.m_Products.length > 1;
        }// end function

        public function get state() : int
        {
            return this.m_State;
        }// end function

        public function set price(param1:Number) : void
        {
            this.m_ActualPrice = param1;
            return;
        }// end function

        public function isNew() : Boolean
        {
            return this.m_State == STATE_NEW;
        }// end function

        public function isSale() : Boolean
        {
            return this.m_State == STATE_SALE;
        }// end function

        public function set state(param1:int) : void
        {
            this.m_State = param1;
            return;
        }// end function

        public function get products() : Vector.<IngameShopProduct>
        {
            return this.m_Products;
        }// end function

        public function isTimed() : Boolean
        {
            return this.m_State == STATE_TIMED;
        }// end function

        public function get iconIdentifiers() : Vector.<String>
        {
            return this.m_IconIdentifiers;
        }// end function

        public function clone() : IngameShopOffer
        {
            var Clone:* = new IngameShopOffer(this.m_OfferID, this.m_Name, this.m_Description);
            Clone.m_ActualPrice = this.m_ActualPrice;
            Clone.m_Disabled = this.m_Disabled;
            Clone.m_State = this.m_State;
            Clone.m_Products = this.m_Products.map(function (param1:IngameShopProduct) : IngameShopProduct
            {
                return param1.clone();
            }// end function
            );
            Clone.m_IconIdentifiers = this.m_IconIdentifiers;
            return Clone;
        }// end function

        public function get offerID() : int
        {
            return this.m_OfferID;
        }// end function

        public function set disabled(param1:Boolean) : void
        {
            this.m_Disabled = param1;
            return;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}
