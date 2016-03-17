package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ButtonSkin;
   
   public class _ButtonStyle
   {
       
      public function _ButtonStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Button");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Button",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ButtonStyle.fontWeight = "bold";
               _ButtonStyle.paddingTop = 2;
               _ButtonStyle.cornerRadius = 4;
               _ButtonStyle.textAlign = "center";
               _ButtonStyle.verticalGap = 2;
               _ButtonStyle.horizontalGap = 2;
               _ButtonStyle.skin = ButtonSkin;
               _ButtonStyle.paddingLeft = 10;
               _ButtonStyle.paddingBottom = 2;
               _ButtonStyle.paddingRight = 10;
            };
         }
      }
   }
}
