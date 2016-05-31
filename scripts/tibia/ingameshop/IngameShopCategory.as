package tibia.ingameshop
{
    import __AS3__.vec.*;
    import flash.events.*;

    public class IngameShopCategory extends EventDispatcher
    {
        private var m_Offers:Vector.<IngameShopOffer> = null;
        private var m_Subcategories:Vector.<IngameShopCategory> = null;
        private var m_CategoryHighlightState:int;
        private var m_Description:String = null;
        private var m_Name:String = null;
        private var m_IconIdentifiers:Vector.<String>;

        public function IngameShopCategory(param1:String, param2:String, param3:int)
        {
            this.m_CategoryHighlightState = IngameShopOffer.HIGHLIGHT_STATE_NONE;
            if (param1 == null)
            {
                throw new ArgumentError("IngameShopCategory: Name is null");
            }
            this.m_Name = param1;
            this.m_Description = param2;
            this.m_CategoryHighlightState = param3;
            this.m_Subcategories = new Vector.<>;
            this.m_Offers = new Vector.<IngameShopOffer>;
            this.m_IconIdentifiers = new Vector.<String>;
            return;
        }// end function

        public function set iconIdentifiers(param1:Vector.<String>) : void
        {
            this.m_IconIdentifiers = param1;
            return;
        }// end function

        public function get subCategories() : Vector.<IngameShopCategory>
        {
            return this.m_Subcategories;
        }// end function

        public function hasTimedOffer() : Boolean
        {
            return this.m_CategoryHighlightState == IngameShopOffer.HIGHLIGHT_STATE_TIMED;
        }// end function

        public function hasSaleOffer() : Boolean
        {
            return this.m_CategoryHighlightState == IngameShopOffer.HIGHLIGHT_STATE_SALE;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function set offers(param1:Vector.<IngameShopOffer>) : void
        {
            this.m_Offers = param1;
            var _loc_2:* = new IngameShopEvent(IngameShopEvent.CATEGORY_OFFERS_CHANGED);
            _loc_2.data = this;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function hasNewOffer() : Boolean
        {
            return this.m_CategoryHighlightState == IngameShopOffer.HIGHLIGHT_STATE_NEW;
        }// end function

        public function get offers() : Vector.<IngameShopOffer>
        {
            return this.m_Offers;
        }// end function

        public function get iconIdentifiers() : Vector.<String>
        {
            return this.m_IconIdentifiers;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}
