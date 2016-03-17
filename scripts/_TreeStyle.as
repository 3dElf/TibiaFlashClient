package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TreeStyle
   {
      
      private static var _embed_css_Assets_swf_TreeNodeIcon_180898582:Class = _TreeStyle__embed_css_Assets_swf_TreeNodeIcon_180898582;
      
      private static var _embed_css_Assets_swf_TreeFolderOpen_1443591959:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderOpen_1443591959;
      
      private static var _embed_css_Assets_swf_TreeFolderClosed_267262203:Class = _TreeStyle__embed_css_Assets_swf_TreeFolderClosed_267262203;
      
      private static var _embed_css_Assets_swf_TreeDisclosureOpen_1289558550:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureOpen_1289558550;
      
      private static var _embed_css_Assets_swf_TreeDisclosureClosed_1469206452:Class = _TreeStyle__embed_css_Assets_swf_TreeDisclosureClosed_1469206452;
       
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
               _TreeStyle.disclosureOpenIcon = _embed_css_Assets_swf_TreeDisclosureOpen_1289558550;
               _TreeStyle.folderClosedIcon = _embed_css_Assets_swf_TreeFolderClosed_267262203;
               _TreeStyle.folderOpenIcon = _embed_css_Assets_swf_TreeFolderOpen_1443591959;
               _TreeStyle.disclosureClosedIcon = _embed_css_Assets_swf_TreeDisclosureClosed_1469206452;
               _TreeStyle.verticalAlign = "middle";
               _TreeStyle.defaultLeafIcon = _embed_css_Assets_swf_TreeNodeIcon_180898582;
               _TreeStyle.paddingLeft = 2;
               _TreeStyle.paddingRight = 0;
            };
         }
      }
   }
}
