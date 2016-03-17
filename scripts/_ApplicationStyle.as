package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ApplicationBackground;
   
   public class _ApplicationStyle
   {
       
      public function _ApplicationStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Application");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Application",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ApplicationStyle.backgroundSize = "100%";
               _ApplicationStyle.paddingTop = 24;
               _ApplicationStyle.backgroundColor = 8821927;
               _ApplicationStyle.backgroundImage = ApplicationBackground;
               _ApplicationStyle.horizontalAlign = "center";
               _ApplicationStyle.backgroundGradientAlphas = [1,1];
               _ApplicationStyle.paddingLeft = 24;
               _ApplicationStyle.paddingBottom = 24;
               _ApplicationStyle.paddingRight = 24;
            };
         }
      }
   }
}
