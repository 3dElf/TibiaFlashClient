package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _TabStyle extends Object
    {

        public function _TabStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Tab");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Tab", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.downSkin = null;
                this.upSkin = null;
                this.paddingBottom = 1;
                this.selectedDownSkin = null;
                this.overSkin = null;
                this.selectedUpSkin = null;
                this.skin = TabSkin;
                this.disabledSkin = null;
                this.selectedOverSkin = null;
                this.paddingTop = 1;
                this.selectedDisabledSkin = null;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
