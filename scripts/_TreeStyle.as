package 
{
    import mx.core.*;
    import mx.styles.*;

    public class _TreeStyle extends Object
    {
        private static var _embed_css_Assets_swf_TreeFolderOpen_179342287:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderOpen_179342287;
        private static var _embed_css_Assets_swf_TreeDisclosureClosed_187413420:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureClosed_187413420;
        private static var _embed_css_Assets_swf_TreeNodeIcon_376449406:Class = _TreeStyle__embed_css_Assets_swf_TreeNodeIcon_376449406;
        private static var _embed_css_Assets_swf_TreeFolderClosed_324461571:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderClosed_324461571;
        private static var _embed_css_Assets_swf_TreeDisclosureOpen_820338894:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureOpen_820338894;

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
                this.disclosureOpenIcon = _embed_css_Assets_swf_TreeDisclosureOpen_820338894;
                this.folderClosedIcon = _embed_css_Assets_swf_TreeFolderClosed_324461571;
                this.folderOpenIcon = _embed_css_Assets_swf_TreeFolderOpen_179342287;
                this.disclosureClosedIcon = _embed_css_Assets_swf_TreeDisclosureClosed_187413420;
                this.verticalAlign = "middle";
                this.defaultLeafIcon = _embed_css_Assets_swf_TreeNodeIcon_376449406;
                this.paddingLeft = 2;
                this.paddingRight = 0;
                return;
            }// end function
            ;
            }
            return;
        }// end function

    }
}
