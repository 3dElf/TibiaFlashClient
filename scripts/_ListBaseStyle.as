package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ListDropIndicator;
   
   public class _ListBaseStyle
   {
       
      public function _ListBaseStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ListBase");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ListBase",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ListBaseStyle.borderStyle = "solid";
               _ListBaseStyle.paddingTop = 2;
               _ListBaseStyle.backgroundColor = 16777215;
               _ListBaseStyle.backgroundDisabledColor = 14540253;
               _ListBaseStyle.dropIndicatorSkin = ListDropIndicator;
               _ListBaseStyle.paddingLeft = 2;
               _ListBaseStyle.paddingBottom = 2;
               _ListBaseStyle.paddingRight = 0;
            };
         }
      }
   }
}
