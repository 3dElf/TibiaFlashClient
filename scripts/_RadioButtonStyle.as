package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _RadioButtonStyle extends Object
    {

        public function _RadioButtonStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("RadioButton");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("RadioButton", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = null;
                this.paddingRight = 0;
                this.upIcon = null;
                this.icon = RadioButtonIcon;
                this.skin = null;
                this.cornerRadius = 7;
                this.fontWeight = "normal";
                this.textAlign = "left";
                this.selectedUpIcon = null;
                this.overIcon = null;
                this.selectedOverIcon = null;
                this.disabledSkin = null;
                this.selectedDisabledIcon = null;
                this.selectedOverSkin = null;
                this.selectedDisabledSkin = null;
                this.downSkin = null;
                this.downIcon = null;
                this.horizontalGap = 5;
                this.selectedDownSkin = null;
                this.iconColor = 2831164;
                this.overSkin = null;
                this.selectedUpSkin = null;
                this.disabledIcon = null;
                this.paddingLeft = 0;
                this.selectedDownIcon = null;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
