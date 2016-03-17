package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TileListStyle
   {
       
      public function _TileListStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TileList");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TileList",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TileListStyle.textAlign = "center";
               _TileListStyle.verticalAlign = "middle";
               _TileListStyle.paddingLeft = 2;
               _TileListStyle.paddingRight = 2;
            };
         }
      }
   }
}
