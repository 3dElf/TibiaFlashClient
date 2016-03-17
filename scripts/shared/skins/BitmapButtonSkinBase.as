package shared.skins
{
   import mx.skins.ProgrammaticSkin;
   
   class BitmapButtonSkinBase extends ProgrammaticSkin
   {
       
      private var m_InvalidStyle:Boolean = false;
      
      private var m_CurrentGrid:shared.skins.BitmapGrid;
      
      function BitmapButtonSkinBase()
      {
         this.m_CurrentGrid = new shared.skins.BitmapGrid();
         super();
      }
      
      override public function get measuredWidth() : Number
      {
         this.validateStyle();
         return this.m_CurrentGrid.measuredWidth;
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         this.m_CurrentGrid.styleChanged(param1);
         this.invalidateStyle();
      }
      
      public function invalidateStyle() : void
      {
         this.m_InvalidStyle = true;
      }
      
      protected function set stylePrefix(param1:String) : void
      {
         this.m_CurrentGrid.stylePrefix = param1;
      }
      
      protected function updateStyle() : void
      {
         this.m_CurrentGrid.styleName = styleName;
      }
      
      override public function validateNow() : void
      {
         super.validateNow();
         this.validateStyle();
      }
      
      override public function set styleName(param1:Object) : void
      {
         super.styleName = param1;
         this.invalidateStyle();
      }
      
      protected function get stylePrefix() : String
      {
         return this.m_CurrentGrid.stylePrefix;
      }
      
      override public function get measuredHeight() : Number
      {
         this.validateStyle();
         return this.m_CurrentGrid.measuredHeight;
      }
      
      override public function set name(param1:String) : void
      {
         super.name = param1;
         this.invalidateStyle();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         this.validateStyle();
         graphics.clear();
         this.m_CurrentGrid.drawGrid(graphics,0,0,param1,param2);
         graphics.endFill();
      }
      
      public function validateStyle() : void
      {
         if(this.m_InvalidStyle)
         {
            this.updateStyle();
            this.m_InvalidStyle = false;
         }
      }
   }
}
