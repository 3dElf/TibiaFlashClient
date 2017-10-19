package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _ComboBoxStyle extends Object
    {

        public function _ComboBoxStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("ComboBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("ComboBox", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.leading = 0;
                this.paddingRight = 5;
                this.skin = ComboBoxArrowSkin;
                this.arrowButtonWidth = 22;
                this.disabledIconColor = 9542041;
                this.dropdownStyleName = "comboDropdown";
                this.paddingLeft = 5;
                this.fontWeight = "bold";
                this.cornerRadius = 5;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
