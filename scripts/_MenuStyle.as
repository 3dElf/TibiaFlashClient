package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ListDropIndicator;
   
   public class _MenuStyle
   {
      
      private static var _embed_css_Assets_swf_MenuCheckDisabled_114086032:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckDisabled_114086032;
      
      private static var _embed_css_Assets_swf_MenuCheckEnabled_459209427:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckEnabled_459209427;
      
      private static var _embed_css_Assets_swf_MenuBranchDisabled_31467896:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchDisabled_31467896;
      
      private static var _embed_css_Assets_swf_MenuSeparator_1578081969:Class = _MenuStyle__embed_css_Assets_swf_MenuSeparator_1578081969;
      
      private static var _embed_css_Assets_swf_MenuRadioDisabled_997765811:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioDisabled_997765811;
      
      private static var _embed_css_Assets_swf_MenuRadioEnabled_1722801680:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioEnabled_1722801680;
      
      private static var _embed_css_Assets_swf_MenuBranchEnabled_1969326389:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchEnabled_1969326389;
       
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
               _MenuStyle.radioIcon = _embed_css_Assets_swf_MenuRadioEnabled_1722801680;
               _MenuStyle.borderStyle = "menuBorder";
               _MenuStyle.paddingTop = 1;
               _MenuStyle.rightIconGap = 15;
               _MenuStyle.branchIcon = _embed_css_Assets_swf_MenuBranchEnabled_1969326389;
               _MenuStyle.checkDisabledIcon = _embed_css_Assets_swf_MenuCheckDisabled_114086032;
               _MenuStyle.verticalAlign = "middle";
               _MenuStyle.paddingLeft = 1;
               _MenuStyle.paddingRight = 0;
               _MenuStyle.checkIcon = _embed_css_Assets_swf_MenuCheckEnabled_459209427;
               _MenuStyle.radioDisabledIcon = _embed_css_Assets_swf_MenuRadioDisabled_997765811;
               _MenuStyle.dropShadowEnabled = true;
               _MenuStyle.branchDisabledIcon = _embed_css_Assets_swf_MenuBranchDisabled_31467896;
               _MenuStyle.dropIndicatorSkin = ListDropIndicator;
               _MenuStyle.separatorSkin = _embed_css_Assets_swf_MenuSeparator_1578081969;
               _MenuStyle.horizontalGap = 6;
               _MenuStyle.leftIconGap = 18;
               _MenuStyle.paddingBottom = 1;
            };
         }
      }
   }
}
