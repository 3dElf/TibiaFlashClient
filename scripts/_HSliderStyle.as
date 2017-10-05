package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _HSliderStyle extends Object
    {

        public function _HSliderStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("HSlider");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("HSlider", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.borderColor = 9542041;
                this.tickColor = 7305079;
                this.trackHighlightSkin = SliderHighlightSkin;
                this.tickThickness = 1;
                this.showTrackHighlight = false;
                this.thumbSkin = SliderThumbSkin;
                this.tickLength = 4;
                this.thumbOffset = 0;
                this.slideDuration = 300;
                this.trackColors = [15198183, 15198183];
                this.labelOffset = -10;
                this.dataTipOffset = 16;
                this.trackSkin = SliderTrackSkin;
                this.dataTipPrecision = 2;
                this.dataTipPlacement = "top";
                this.tickOffset = -6;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
