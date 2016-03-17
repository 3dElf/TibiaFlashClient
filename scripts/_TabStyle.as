package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.TabSkin;
   
   public class _TabStyle
   {
       
      public function _TabStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Tab");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Tab",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TabStyle.upSkin = null;
               _TabStyle.selectedDownSkin = null;
               _TabStyle.overSkin = null;
               _TabStyle.downSkin = null;
               _TabStyle.selectedDisabledSkin = null;
               _TabStyle.paddingTop = 1;
               _TabStyle.selectedUpSkin = null;
               _TabStyle.disabledSkin = null;
               _TabStyle.skin = TabSkin;
               _TabStyle.paddingBottom = 1;
               _TabStyle.selectedOverSkin = null;
            };
         }
      }
   }
}
