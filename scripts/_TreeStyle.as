package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TreeStyle
   {
      
      private static var _embed_css_Assets_swf_TreeFolderClosed_15774541:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderClosed_15774541;
      
      private static var _embed_css_Assets_swf_TreeFolderOpen_1361697953:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderOpen_1361697953;
      
      private static var _embed_css_Assets_swf_TreeDisclosureOpen_1262743968:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureOpen_1262743968;
      
      private static var _embed_css_Assets_swf_TreeDisclosureClosed_1350640962:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureClosed_1350640962;
      
      private static var _embed_css_Assets_swf_TreeNodeIcon_231923820:Class = _TreeStyle__embed_css_Assets_swf_TreeNodeIcon_231923820;
       
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
               _TreeStyle.disclosureOpenIcon = _embed_css_Assets_swf_TreeDisclosureOpen_1262743968;
               _TreeStyle.folderClosedIcon = _embed_css_Assets_swf_TreeFolderClosed_15774541;
               _TreeStyle.folderOpenIcon = _embed_css_Assets_swf_TreeFolderOpen_1361697953;
               _TreeStyle.disclosureClosedIcon = _embed_css_Assets_swf_TreeDisclosureClosed_1350640962;
               _TreeStyle.verticalAlign = "middle";
               _TreeStyle.defaultLeafIcon = _embed_css_Assets_swf_TreeNodeIcon_231923820;
               _TreeStyle.paddingLeft = 2;
               _TreeStyle.paddingRight = 0;
            };
         }
      }
   }
}
