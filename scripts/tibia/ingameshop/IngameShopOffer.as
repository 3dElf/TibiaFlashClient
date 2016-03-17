package tibia.ingameshop
{
   public class IngameShopOffer
   {
      
      protected static const STATE_TIMED:int = 3;
      
      protected static const STATE_NEW:int = 1;
      
      protected static const STATE_SALE:int = 2;
      
      protected static const STATE_NONE:int = 0;
       
      private var m_OfferID:int;
      
      private var m_Description:String;
      
      private var m_Products:Vector.<tibia.ingameshop.IngameShopProduct>;
      
      private var m_State:int;
      
      private var m_ActualPrice:Number;
      
      private var m_Disabled:Boolean;
      
      private var m_Name:String;
      
      private var m_IconIdentifiers:Vector.<String>;
      
      public function IngameShopOffer(param1:int, param2:String, param3:String)
      {
         super();
         this.m_OfferID = param1;
         this.m_Name = param2;
         this.m_Description = param3;
         this.m_Products = new Vector.<tibia.ingameshop.IngameShopProduct>();
         this.m_IconIdentifiers = new Vector.<String>();
         this.m_ActualPrice = 0;
         this.m_State = STATE_NONE;
         this.m_Disabled = false;
      }
      
      public function get disabled() : Boolean
      {
         return this.m_Disabled;
      }
      
      public function set iconIdentifiers(param1:Vector.<String>) : void
      {
         this.m_IconIdentifiers = param1;
      }
      
      public function set products(param1:Vector.<tibia.ingameshop.IngameShopProduct>) : void
      {
         this.m_Products = param1;
      }
      
      public function get price() : Number
      {
         return this.m_ActualPrice;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function isBundle() : Boolean
      {
         return this.m_Products.length > 1;
      }
      
      public function get state() : int
      {
         return this.m_State;
      }
      
      public function set price(param1:Number) : void
      {
         this.m_ActualPrice = param1;
      }
      
      public function isNew() : Boolean
      {
         return this.m_State == STATE_NEW;
      }
      
      public function isSale() : Boolean
      {
         return this.m_State == STATE_SALE;
      }
      
      public function set state(param1:int) : void
      {
         this.m_State = param1;
      }
      
      public function get products() : Vector.<tibia.ingameshop.IngameShopProduct>
      {
         return this.m_Products;
      }
      
      public function isTimed() : Boolean
      {
         return this.m_State == STATE_TIMED;
      }
      
      public function get iconIdentifiers() : Vector.<String>
      {
         return this.m_IconIdentifiers;
      }
      
      public function clone() : IngameShopOffer
      {
         var Clone:IngameShopOffer = new IngameShopOffer(this.m_OfferID,this.m_Name,this.m_Description);
         Clone.m_ActualPrice = this.m_ActualPrice;
         Clone.m_Disabled = this.m_Disabled;
         Clone.m_State = this.m_State;
         Clone.m_Products = this.m_Products.map(function(param1:IngameShopProduct):IngameShopProduct
         {
            return param1.clone();
         });
         Clone.m_IconIdentifiers = this.m_IconIdentifiers;
         return Clone;
      }
      
      public function get offerID() : int
      {
         return this.m_OfferID;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         this.m_Disabled = param1;
      }
      
      public function get description() : String
      {
         return this.m_Description;
      }
   }
}
