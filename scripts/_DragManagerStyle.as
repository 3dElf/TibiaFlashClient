package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _DragManagerStyle extends Object
    {
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_2126518529:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_2126518529;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_2128395685:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_2128395685;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_1855271461:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_1855271461;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_2128353680:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_2128353680;

        public function _DragManagerStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("DragManager");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("DragManager", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_2126518529;
                this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_2128395685;
                this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_1855271461;
                this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_2128353680;
                this.defaultDragImageSkin = DefaultDragImage;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
