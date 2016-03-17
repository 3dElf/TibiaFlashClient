package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _FormStyle
   {
       
      public function _FormStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Form");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Form",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _FormStyle.paddingTop = 16;
               _FormStyle.verticalGap = 6;
               _FormStyle.paddingLeft = 16;
               _FormStyle.paddingBottom = 16;
               _FormStyle.paddingRight = 16;
            };
         }
      }
   }
}
