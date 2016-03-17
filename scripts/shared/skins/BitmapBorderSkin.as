package shared.skins
{
   import mx.skins.ProgrammaticSkin;
   import mx.core.IBorder;
   import mx.core.EdgeMetrics;
   
   public class BitmapBorderSkin extends ProgrammaticSkin implements IBorder
   {
       
      private var m_Grid:shared.skins.BitmapGrid;
      
      public function BitmapBorderSkin()
      {
         this.m_Grid = new shared.skins.BitmapGrid(null,"border");
         super();
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         this.m_Grid.styleChanged(param1);
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         graphics.clear();
         this.m_Grid.drawGrid(graphics,0,0,param1,param2);
         graphics.endFill();
      }
      
      override public function get measuredWidth() : Number
      {
         return this.m_Grid.measuredWidth;
      }
      
      override public function validateNow() : void
      {
         super.validateNow();
         this.m_Grid.validateStyle();
      }
      
      override public function get measuredHeight() : Number
      {
         return this.m_Grid.measuredHeight;
      }
      
      override public function set styleName(param1:Object) : void
      {
         super.styleName = param1;
         this.m_Grid.styleName = param1;
      }
      
      public function get borderMetrics() : EdgeMetrics
      {
         return this.m_Grid.borderMetrics;
      }
   }
}
