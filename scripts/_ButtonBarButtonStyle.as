package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ButtonBarButtonSkin;
   
   public class _ButtonBarButtonStyle
   {
       
      public function _ButtonBarButtonStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ButtonBarButton");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ButtonBarButton",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ButtonBarButtonStyle.upSkin = null;
               _ButtonBarButtonStyle.selectedDownSkin = null;
               _ButtonBarButtonStyle.overSkin = null;
               _ButtonBarButtonStyle.downSkin = null;
               _ButtonBarButtonStyle.selectedDisabledSkin = null;
               _ButtonBarButtonStyle.selectedUpSkin = null;
               _ButtonBarButtonStyle.disabledSkin = null;
               _ButtonBarButtonStyle.horizontalGap = 1;
               _ButtonBarButtonStyle.skin = ButtonBarButtonSkin;
               _ButtonBarButtonStyle.selectedOverSkin = null;
            };
         }
      }
   }
}
