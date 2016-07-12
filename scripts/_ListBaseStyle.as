package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _ListBaseStyle extends Object
    {

        public function _ListBaseStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("ListBase");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ListBase", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.backgroundColor = 16777215;
                this.paddingBottom = 2;
                this.backgroundDisabledColor = 14540253;
                this.paddingRight = 0;
                this.dropIndicatorSkin = ListDropIndicator;
                this.paddingTop = 2;
                this.borderStyle = "solid";
                this.paddingLeft = 2;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
