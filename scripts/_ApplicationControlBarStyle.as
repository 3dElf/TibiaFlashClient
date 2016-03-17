package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _ApplicationControlBarStyle
   {
       
      public function _ApplicationControlBarStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ApplicationControlBar");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ApplicationControlBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ApplicationControlBarStyle.borderStyle = "applicationControlBar";
               _ApplicationControlBarStyle.paddingTop = 5;
               _ApplicationControlBarStyle.docked = false;
               _ApplicationControlBarStyle.dropShadowEnabled = true;
               _ApplicationControlBarStyle.shadowDistance = 5;
               _ApplicationControlBarStyle.cornerRadius = 5;
               _ApplicationControlBarStyle.fillColors = [16777215,16777215];
               _ApplicationControlBarStyle.fillAlphas = [0,0];
               _ApplicationControlBarStyle.paddingLeft = 8;
               _ApplicationControlBarStyle.paddingBottom = 4;
               _ApplicationControlBarStyle.paddingRight = 8;
            };
         }
      }
   }
}
