package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ListDropIndicator;
   
   public class _MenuStyle
   {
      
      private static var _embed_css_Assets_swf_MenuSeparator_229201407:Class = _MenuStyle__embed_css_Assets_swf_MenuSeparator_229201407;
      
      private static var _embed_css_Assets_swf_MenuCheckEnabled_1090021853:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckEnabled_1090021853;
      
      private static var _embed_css_Assets_swf_MenuBranchDisabled_2051719078:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchDisabled_2051719078;
      
      private static var _embed_css_Assets_swf_MenuRadioEnabled_1023758274:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioEnabled_1023758274;
      
      private static var _embed_css_Assets_swf_MenuBranchEnabled_247927339:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchEnabled_247927339;
      
      private static var _embed_css_Assets_swf_MenuCheckDisabled_493500994:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckDisabled_493500994;
      
      private static var _embed_css_Assets_swf_MenuRadioDisabled_1597890051:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioDisabled_1597890051;
       
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
               _MenuStyle.radioIcon = _embed_css_Assets_swf_MenuRadioEnabled_1023758274;
               _MenuStyle.borderStyle = "menuBorder";
               _MenuStyle.paddingTop = 1;
               _MenuStyle.rightIconGap = 15;
               _MenuStyle.branchIcon = _embed_css_Assets_swf_MenuBranchEnabled_247927339;
               _MenuStyle.checkDisabledIcon = _embed_css_Assets_swf_MenuCheckDisabled_493500994;
               _MenuStyle.verticalAlign = "middle";
               _MenuStyle.paddingLeft = 1;
               _MenuStyle.paddingRight = 0;
               _MenuStyle.checkIcon = _embed_css_Assets_swf_MenuCheckEnabled_1090021853;
               _MenuStyle.radioDisabledIcon = _embed_css_Assets_swf_MenuRadioDisabled_1597890051;
               _MenuStyle.dropShadowEnabled = true;
               _MenuStyle.branchDisabledIcon = _embed_css_Assets_swf_MenuBranchDisabled_2051719078;
               _MenuStyle.dropIndicatorSkin = ListDropIndicator;
               _MenuStyle.separatorSkin = _embed_css_Assets_swf_MenuSeparator_229201407;
               _MenuStyle.horizontalGap = 6;
               _MenuStyle.leftIconGap = 18;
               _MenuStyle.paddingBottom = 1;
            };
         }
      }
   }
}
