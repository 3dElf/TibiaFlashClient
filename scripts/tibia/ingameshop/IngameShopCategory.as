package tibia.ingameshop
{
   import flash.events.EventDispatcher;
   
   public class IngameShopCategory extends EventDispatcher
   {
       
      private var m_Offers:Vector.<tibia.ingameshop.IngameShopOffer> = null;
      
      private var m_Subcategories:Vector.<tibia.ingameshop.IngameShopCategory> = null;
      
      private var m_Description:String = null;
      
      private var m_Name:String = null;
      
      private var m_IconIdentifiers:Vector.<String>;
      
      public function IngameShopCategory(param1:String, param2:String)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("IngameShopCategory: Name is null");
         }
         this.m_Name = param1;
         this.m_Description = param2;
         this.m_Subcategories = new Vector.<tibia.ingameshop.IngameShopCategory>();
         this.m_Offers = new Vector.<tibia.ingameshop.IngameShopOffer>();
         this.m_IconIdentifiers = new Vector.<String>();
      }
      
      public function set iconIdentifiers(param1:Vector.<String>) : void
      {
         this.m_IconIdentifiers = param1;
      }
      
      public function get subCategories() : Vector.<tibia.ingameshop.IngameShopCategory>
      {
         return this.m_Subcategories;
      }
      
      public function get name() : String
      {
         return this.m_Name;
      }
      
      public function set offers(param1:Vector.<tibia.ingameshop.IngameShopOffer>) : void
      {
         this.m_Offers = param1;
         var _loc2_:IngameShopEvent = new IngameShopEvent(IngameShopEvent.CATEGORY_OFFERS_CHANGED);
         _loc2_.data = this;
         dispatchEvent(_loc2_);
      }
      
      public function get offers() : Vector.<tibia.ingameshop.IngameShopOffer>
      {
         return this.m_Offers;
      }
      
      public function get iconIdentifiers() : Vector.<String>
      {
         return this.m_IconIdentifiers;
      }
      
      public function get description() : String
      {
         return this.m_Description;
      }
   }
}
