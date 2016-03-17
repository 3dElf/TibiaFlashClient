package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TabBarStyle
   {
       
      public function _TabBarStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TabBar");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TabBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TabBarStyle.selectedTabTextStyleName = "activeTabStyle";
               _TabBarStyle.textAlign = "center";
               _TabBarStyle.horizontalAlign = "left";
               _TabBarStyle.verticalAlign = "top";
               _TabBarStyle.verticalGap = -1;
               _TabBarStyle.horizontalGap = -1;
            };
         }
      }
   }
}
