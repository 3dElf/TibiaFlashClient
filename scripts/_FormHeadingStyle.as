package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _FormHeadingStyle
   {
       
      public function _FormHeadingStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("FormHeading");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("FormHeading",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _FormHeadingStyle.fontWeight = "bold";
               _FormHeadingStyle.borderStyle = "none";
               _FormHeadingStyle.fontSize = 12;
               _FormHeadingStyle.verticalGap = 16;
            };
         }
      }
   }
}
