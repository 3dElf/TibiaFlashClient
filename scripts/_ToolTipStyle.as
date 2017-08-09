package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _ToolTipStyle extends Object
    {

        public function _ToolTipStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("ToolTip");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ToolTip", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.backgroundColor = 16777164;
                this.borderColor = 9542041;
                this.paddingBottom = 2;
                this.paddingRight = 4;
                this.backgroundAlpha = 0.95;
                this.fontSize = 9;
                this.paddingTop = 2;
                this.borderSkin = ToolTipBorder;
                this.borderStyle = "toolTip";
                this.paddingLeft = 4;
                this.shadowColor = 0;
                this.cornerRadius = 2;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
