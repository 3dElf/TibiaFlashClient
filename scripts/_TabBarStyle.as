package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _TabBarStyle extends Object
    {

        public function _TabBarStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("TabBar");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("TabBar", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.verticalAlign = "top";
                this.horizontalGap = -1;
                this.textAlign = "center";
                this.horizontalAlign = "left";
                this.verticalGap = -1;
                this.selectedTabTextStyleName = "activeTabStyle";
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
