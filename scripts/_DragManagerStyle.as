﻿package 
{
    import mx.core.*;
    import mx.skins.halo.*;
    import mx.styles.*;

    public class _DragManagerStyle extends Object
    {
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_1350139645:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_1350139645;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_1348850521:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_1348850521;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_137392381:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_137392381;
        private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_1350161110:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_1350161110;

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
                this.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_1350161110;
                this.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_137392381;
                this.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_1348850521;
                this.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_1350139645;
                this.defaultDragImageSkin = DefaultDragImage;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
