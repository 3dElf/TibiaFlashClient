package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _FormHeadingStyle extends Object
    {

        public function _FormHeadingStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("FormHeading");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("FormHeading", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.fontSize = 12;
                this.borderStyle = "none";
                this.verticalGap = 16;
                this.fontWeight = "bold";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
