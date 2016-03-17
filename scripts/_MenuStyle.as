package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ListDropIndicator;
   
   public class _MenuStyle
   {
      
      private static var _embed_css_Assets_swf_MenuBranchDisabled_125649870:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchDisabled_125649870;
      
      private static var _embed_css_Assets_swf_MenuBranchEnabled_1920950979:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchEnabled_1920950979;
      
      private static var _embed_css_Assets_swf_MenuRadioDisabled_1023072517:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioDisabled_1023072517;
      
      private static var _embed_css_Assets_swf_MenuCheckDisabled_30652986:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckDisabled_30652986;
      
      private static var _embed_css_Assets_swf_MenuSeparator_1360082183:Class = _MenuStyle__embed_css_Assets_swf_MenuSeparator_1360082183;
      
      private static var _embed_css_Assets_swf_MenuRadioEnabled_1630713274:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioEnabled_1630713274;
      
      private static var _embed_css_Assets_swf_MenuCheckEnabled_482349349:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckEnabled_482349349;
       
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
               _MenuStyle.radioIcon = _embed_css_Assets_swf_MenuRadioEnabled_1630713274;
               _MenuStyle.borderStyle = "menuBorder";
               _MenuStyle.paddingTop = 1;
               _MenuStyle.rightIconGap = 15;
               _MenuStyle.branchIcon = _embed_css_Assets_swf_MenuBranchEnabled_1920950979;
               _MenuStyle.checkDisabledIcon = _embed_css_Assets_swf_MenuCheckDisabled_30652986;
               _MenuStyle.verticalAlign = "middle";
               _MenuStyle.paddingLeft = 1;
               _MenuStyle.paddingRight = 0;
               _MenuStyle.checkIcon = _embed_css_Assets_swf_MenuCheckEnabled_482349349;
               _MenuStyle.radioDisabledIcon = _embed_css_Assets_swf_MenuRadioDisabled_1023072517;
               _MenuStyle.dropShadowEnabled = true;
               _MenuStyle.branchDisabledIcon = _embed_css_Assets_swf_MenuBranchDisabled_125649870;
               _MenuStyle.dropIndicatorSkin = ListDropIndicator;
               _MenuStyle.separatorSkin = _embed_css_Assets_swf_MenuSeparator_1360082183;
               _MenuStyle.horizontalGap = 6;
               _MenuStyle.leftIconGap = 18;
               _MenuStyle.paddingBottom = 1;
            };
         }
      }
   }
}
