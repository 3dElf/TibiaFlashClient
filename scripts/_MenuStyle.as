package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ListDropIndicator;
   
   public class _MenuStyle
   {
      
      private static var _embed_css_Assets_swf_MenuCheckEnabled_910602333:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckEnabled_910602333;
      
      private static var _embed_css_Assets_swf_MenuCheckDisabled_732240386:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckDisabled_732240386;
      
      private static var _embed_css_Assets_swf_MenuSeparator_1251447871:Class = _MenuStyle__embed_css_Assets_swf_MenuSeparator_1251447871;
      
      private static var _embed_css_Assets_swf_MenuRadioEnabled_1271141506:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioEnabled_1271141506;
      
      private static var _embed_css_Assets_swf_MenuBranchDisabled_1017897974:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchDisabled_1017897974;
      
      private static var _embed_css_Assets_swf_MenuBranchEnabled_1492763579:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchEnabled_1492763579;
      
      private static var _embed_css_Assets_swf_MenuRadioDisabled_372013117:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioDisabled_372013117;
       
      public function _MenuStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Menu");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Menu",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _MenuStyle.radioIcon = _embed_css_Assets_swf_MenuRadioEnabled_1271141506;
               _MenuStyle.borderStyle = "menuBorder";
               _MenuStyle.paddingTop = 1;
               _MenuStyle.rightIconGap = 15;
               _MenuStyle.branchIcon = _embed_css_Assets_swf_MenuBranchEnabled_1492763579;
               _MenuStyle.checkDisabledIcon = _embed_css_Assets_swf_MenuCheckDisabled_732240386;
               _MenuStyle.verticalAlign = "middle";
               _MenuStyle.paddingLeft = 1;
               _MenuStyle.paddingRight = 0;
               _MenuStyle.checkIcon = _embed_css_Assets_swf_MenuCheckEnabled_910602333;
               _MenuStyle.radioDisabledIcon = _embed_css_Assets_swf_MenuRadioDisabled_372013117;
               _MenuStyle.dropShadowEnabled = true;
               _MenuStyle.branchDisabledIcon = _embed_css_Assets_swf_MenuBranchDisabled_1017897974;
               _MenuStyle.dropIndicatorSkin = ListDropIndicator;
               _MenuStyle.separatorSkin = _embed_css_Assets_swf_MenuSeparator_1251447871;
               _MenuStyle.horizontalGap = 6;
               _MenuStyle.leftIconGap = 18;
               _MenuStyle.paddingBottom = 1;
            };
         }
      }
   }
}
