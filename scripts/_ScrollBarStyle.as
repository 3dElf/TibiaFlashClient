package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ScrollTrackSkin;
   import mx.skins.halo.ScrollArrowSkin;
   import mx.skins.halo.ScrollThumbSkin;
   
   public class _ScrollBarStyle
   {
       
      public function _ScrollBarStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ScrollBar");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ScrollBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ScrollBarStyle.thumbOffset = 0;
               _ScrollBarStyle.paddingTop = 0;
               _ScrollBarStyle.borderColor = 12040892;
               _ScrollBarStyle.trackColors = [9738651,15198183];
               _ScrollBarStyle.trackSkin = ScrollTrackSkin;
               _ScrollBarStyle.downArrowSkin = ScrollArrowSkin;
               _ScrollBarStyle.cornerRadius = 4;
               _ScrollBarStyle.upArrowSkin = ScrollArrowSkin;
               _ScrollBarStyle.paddingLeft = 0;
               _ScrollBarStyle.paddingBottom = 0;
               _ScrollBarStyle.thumbSkin = ScrollThumbSkin;
               _ScrollBarStyle.paddingRight = 0;
            };
         }
      }
   }
}
