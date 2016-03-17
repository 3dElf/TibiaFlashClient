package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TreeStyle
   {
      
      private static var _embed_css_Assets_swf_TreeFolderOpen_179342287:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderOpen_179342287;
      
      private static var _embed_css_Assets_swf_TreeDisclosureClosed_187413420:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureClosed_187413420;
      
      private static var _embed_css_Assets_swf_TreeNodeIcon_376449406:Class = _TreeStyle__embed_css_Assets_swf_TreeNodeIcon_376449406;
      
      private static var _embed_css_Assets_swf_TreeFolderClosed_324461571:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderClosed_324461571;
      
      private static var _embed_css_Assets_swf_TreeDisclosureOpen_820338894:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureOpen_820338894;
       
      public function _TreeStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Tree");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Tree",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TreeStyle.disclosureOpenIcon = _embed_css_Assets_swf_TreeDisclosureOpen_820338894;
               _TreeStyle.folderClosedIcon = _embed_css_Assets_swf_TreeFolderClosed_324461571;
               _TreeStyle.folderOpenIcon = _embed_css_Assets_swf_TreeFolderOpen_179342287;
               _TreeStyle.disclosureClosedIcon = _embed_css_Assets_swf_TreeDisclosureClosed_187413420;
               _TreeStyle.verticalAlign = "middle";
               _TreeStyle.defaultLeafIcon = _embed_css_Assets_swf_TreeNodeIcon_376449406;
               _TreeStyle.paddingLeft = 2;
               _TreeStyle.paddingRight = 0;
            };
         }
      }
   }
}
