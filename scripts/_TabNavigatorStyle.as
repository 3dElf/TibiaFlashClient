package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TabNavigatorStyle
   {
       
      public function _TabNavigatorStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TabNavigator");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TabNavigator",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TabNavigatorStyle.borderStyle = "solid";
               _TabNavigatorStyle.paddingTop = 10;
               _TabNavigatorStyle.borderColor = 11187123;
               _TabNavigatorStyle.backgroundColor = 16777215;
               _TabNavigatorStyle.horizontalAlign = "left";
               _TabNavigatorStyle.horizontalGap = -1;
               _TabNavigatorStyle.tabOffset = 0;
            };
         }
      }
   }
}
