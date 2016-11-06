package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _TreeStyle extends Object
    {
        private static var _embed_css_Assets_swf_TreeDisclosureClosed_630190966:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureClosed_630190966;
        private static var _embed_css_Assets_swf_TreeNodeIcon_2027283364:Class = _TreeStyle__embed_css_Assets_swf_TreeNodeIcon_2027283364;
        private static var _embed_css_Assets_swf_TreeFolderClosed_1978897499:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderClosed_1978897499;
        private static var _embed_css_Assets_swf_TreeFolderOpen_605477783:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderOpen_605477783;
        private static var _embed_css_Assets_swf_TreeDisclosureOpen_1052815000:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureOpen_1052815000;

        public function _TreeStyle()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var style:* = StyleManager.getStyleDeclaration("Tree");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration("Tree", style, false);
            }
            if (style.defaultFactory == null)
            {
                style.defaultFactory = function () : void
            {
                this.folderClosedIcon = _embed_css_Assets_swf_TreeFolderClosed_1978897499;
                this.verticalAlign = "middle";
                this.disclosureOpenIcon = _embed_css_Assets_swf_TreeDisclosureOpen_1052815000;
                this.paddingRight = 0;
                this.folderOpenIcon = _embed_css_Assets_swf_TreeFolderOpen_605477783;
                this.defaultLeafIcon = _embed_css_Assets_swf_TreeNodeIcon_2027283364;
                this.paddingLeft = 2;
                this.disclosureClosedIcon = _embed_css_Assets_swf_TreeDisclosureClosed_630190966;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
