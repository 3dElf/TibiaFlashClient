package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _swatchPanelTextFieldStyle extends Object
    {

        public function _swatchPanelTextFieldStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration(".swatchPanelTextField");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".swatchPanelTextField", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.highlightColor = 12897484;
                this.backgroundColor = 16777215;
                this.borderColor = 14015965;
                this.borderCapColor = 9542041;
                this.buttonColor = 7305079;
                this.shadowCapColor = 14015965;
                this.paddingRight = 5;
                this.borderStyle = "inset";
                this.paddingLeft = 5;
                this.shadowColor = 14015965;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
