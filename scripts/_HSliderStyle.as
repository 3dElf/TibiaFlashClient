package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.SliderHighlightSkin;
   import mx.skins.halo.SliderThumbSkin;
   import mx.skins.halo.SliderTrackSkin;
   
   public class _HSliderStyle
   {
       
      public function _HSliderStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("HSlider");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("HSlider",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _HSliderStyle.borderColor = 9542041;
               _HSliderStyle.tickColor = 7305079;
               _HSliderStyle.trackHighlightSkin = SliderHighlightSkin;
               _HSliderStyle.tickThickness = 1;
               _HSliderStyle.showTrackHighlight = false;
               _HSliderStyle.thumbSkin = SliderThumbSkin;
               _HSliderStyle.tickLength = 4;
               _HSliderStyle.thumbOffset = 0;
               _HSliderStyle.slideDuration = 300;
               _HSliderStyle.trackColors = [15198183,15198183];
               _HSliderStyle.labelOffset = -10;
               _HSliderStyle.dataTipOffset = 16;
               _HSliderStyle.trackSkin = SliderTrackSkin;
               _HSliderStyle.dataTipPrecision = 2;
               _HSliderStyle.dataTipPlacement = "top";
               _HSliderStyle.tickOffset = -6;
            };
         }
      }
   }
}
