package tibia.ingameshop.shopWidgetClasses
{
   import mx.containers.HBox;
   import mx.core.ScrollPolicy;
   import mx.controls.Text;
   import tibia.ingameshop.IngameShopCategory;
   
   public class CategoryRenderer extends HBox
   {
       
      private var m_UIIcon:tibia.ingameshop.shopWidgetClasses.DynamicallyLoadedImage;
      
      private var m_UITextBox:Text;
      
      private var m_UncommittedCategory:Boolean;
      
      public function CategoryRenderer()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         verticalScrollPolicy = ScrollPolicy.OFF;
         horizontalScrollPolicy = ScrollPolicy.OFF;
         this.m_UIIcon = new tibia.ingameshop.shopWidgetClasses.DynamicallyLoadedImage(32);
         this.m_UIIcon.resizeToImage = false;
         addChild(this.m_UIIcon);
         this.m_UITextBox = new Text();
         addChild(this.m_UITextBox);
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         this.m_UncommittedCategory = true;
         invalidateProperties();
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:IngameShopCategory = null;
         super.commitProperties();
         if(this.m_UncommittedCategory)
         {
            _loc1_ = data as IngameShopCategory;
            if(_loc1_ != null)
            {
               this.m_UITextBox.text = _loc1_.name;
               this.m_UIIcon.setImageIdentifier(_loc1_.iconIdentifiers != null && _loc1_.iconIdentifiers.length > 0?_loc1_.iconIdentifiers[0]:null);
               toolTip = _loc1_.description;
            }
            this.m_UncommittedCategory = false;
         }
      }
   }
}
