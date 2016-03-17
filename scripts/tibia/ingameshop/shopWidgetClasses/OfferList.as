package tibia.ingameshop.shopWidgetClasses
{
   import shared.controls.CustomTileList;
   import mx.core.IDataRenderer;
   import tibia.ingameshop.IngameShopOffer;
   import mx.events.ListEvent;
   import tibia.ingameshop.IngameShopCategory;
   import mx.collections.ArrayCollection;
   import tibia.ingameshop.IngameShopWidget;
   import flash.errors.IllegalOperationError;
   import tibia.ingameshop.IngameShopEvent;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import mx.core.ClassFactory;
   
   public class OfferList extends CustomTileList implements IIngameShopWidgetComponent, IDataRenderer
   {
      
      private static const LIST_ITEM_HEIGHT:int = 140;
      
      private static const BUNDLE:String = "IngameShopWidget";
      
      private static const LIST_ITEM_WIDTH:int = 120;
       
      private var m_UncommittedCategory:Boolean;
      
      private var m_ShopWindow:IngameShopWidget;
      
      public function OfferList()
      {
         super();
         styleName = "ingameShopOfferList";
         itemRenderer = new ClassFactory(OfferRenderer);
         columnWidth = LIST_ITEM_WIDTH;
         rowHeight = LIST_ITEM_HEIGHT;
         doubleClickEnabled = true;
         addEventListener(ListEvent.CHANGE,this.onOfferSelected);
         this.m_UncommittedCategory = true;
      }
      
      private function updateUIOnOfferSelection(param1:IngameShopOffer) : void
      {
         if(this.m_ShopWindow != null)
         {
            this.m_ShopWindow.mainView.setShowButtonBar(param1 != null && !param1.disabled);
            this.m_ShopWindow.mainView.detailsList.offer = param1;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener(ListEvent.CHANGE,this.onOfferSelected);
         this.data = null;
         this.m_ShopWindow = null;
      }
      
      protected function onOfferSelected(param1:ListEvent) : void
      {
         var _loc2_:IngameShopOffer = param1.itemRenderer.data as IngameShopOffer;
         if(_loc2_ != null && Boolean(_loc2_.disabled))
         {
            selectedIndex = -1;
            param1.preventDefault();
         }
         if(selectedIndex == -1)
         {
            _loc2_ = null;
         }
         this.updateUIOnOfferSelection(_loc2_);
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:IngameShopCategory = null;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         super.commitProperties();
         if(this.m_UncommittedCategory)
         {
            selectedItem = null;
            this.updateUIOnOfferSelection(null);
            _loc1_ = data as IngameShopCategory;
            if(_loc1_ != null)
            {
               _loc2_ = new Array();
               _loc3_ = 0;
               while(_loc3_ < _loc1_.offers.length)
               {
                  _loc2_.push(_loc1_.offers[_loc3_]);
                  _loc3_++;
               }
               dataProvider = new ArrayCollection(_loc2_);
            }
            else
            {
               dataProvider = null;
            }
            this.m_UncommittedCategory = false;
         }
      }
      
      public function getSelectedOffer() : IngameShopOffer
      {
         return selectedItem as IngameShopOffer;
      }
      
      public function set shopWidget(param1:IngameShopWidget) : void
      {
         if(this.m_ShopWindow != null)
         {
            throw new IllegalOperationError("IngameShopOfferList.shopWidget: Attempted to set reference twice");
         }
         this.m_ShopWindow = param1;
      }
      
      protected function onCurrentOffersChanged(param1:IngameShopEvent) : void
      {
         this.m_UncommittedCategory = true;
         invalidateProperties();
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:IngameShopCategory = super.data as IngameShopCategory;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(IngameShopEvent.CATEGORY_OFFERS_CHANGED,this.onCurrentOffersChanged);
         }
         var _loc3_:IngameShopCategory = param1 as IngameShopCategory;
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(IngameShopEvent.CATEGORY_OFFERS_CHANGED,this.onCurrentOffersChanged);
         }
         super.data = param1;
         this.m_UncommittedCategory = true;
         invalidateProperties();
      }
      
      override protected function mouseWheelHandler(param1:MouseEvent) : void
      {
         param1.delta = Math.max(-1,Math.min(1,param1.delta));
         super.mouseWheelHandler(param1);
      }
      
      protected function onOfferDoubleClicked(param1:Event) : void
      {
         var _loc3_:IngameShopEvent = null;
         var _loc2_:IngameShopOffer = this.getSelectedOffer();
         if(_loc2_ != null && !_loc2_.disabled)
         {
            _loc3_ = new IngameShopEvent(IngameShopEvent.OFFER_ACTIVATED);
            _loc3_.data = _loc2_;
            dispatchEvent(_loc3_);
         }
      }
   }
}
