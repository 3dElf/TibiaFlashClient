package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _SWFLoaderStyle extends Object
    {
        private static var _embed_css_Assets_swf___brokenImage_783978175:Class = _SWFLoaderStyle__embed_css_Assets_swf___brokenImage_783978175;

        public function _SWFLoaderStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("SWFLoader");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("SWFLoader", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.brokenImageBorderSkin = BrokenImageBorderSkin;
                this.brokenImageSkin = _embed_css_Assets_swf___brokenImage_783978175;
                this.borderStyle = "none";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
