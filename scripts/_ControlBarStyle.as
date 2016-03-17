package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _ControlBarStyle
   {
       
      public function _ControlBarStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ControlBar");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ControlBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ControlBarStyle.disabledOverlayAlpha = 0;
               _ControlBarStyle.borderStyle = "controlBar";
               _ControlBarStyle.paddingTop = 10;
               _ControlBarStyle.verticalAlign = "middle";
               _ControlBarStyle.paddingLeft = 10;
               _ControlBarStyle.paddingBottom = 10;
               _ControlBarStyle.paddingRight = 10;
            };
         }
      }
   }
}
