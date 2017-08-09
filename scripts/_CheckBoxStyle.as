package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _CheckBoxStyle extends Object
    {

        public function _CheckBoxStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("CheckBox");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("CheckBox", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.upSkin = null;
                this.textAlign = "left";
                this.paddingRight = 0;
                this.upIcon = null;
                this.icon = CheckBoxIcon;
                this.selectedUpIcon = null;
                this.skin = null;
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
                this.fontWeight = "normal";
                this.selectedDownIcon = null;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
