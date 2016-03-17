package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _DividedBoxStyle
   {
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_1858903108:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_1858903108;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_613235298:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_613235298;
      
      private static var _embed_css_Assets_swf_mx_skins_BoxDividerSkin_354749025:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_BoxDividerSkin_354749025;
       
      public function _DividedBoxStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DividedBox");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("DividedBox",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _DividedBoxStyle.dividerThickness = 3;
               _DividedBoxStyle.dividerColor = 7305079;
               _DividedBoxStyle.dividerAffordance = 6;
               _DividedBoxStyle.verticalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_1858903108;
               _DividedBoxStyle.dividerSkin = _embed_css_Assets_swf_mx_skins_BoxDividerSkin_354749025;
               _DividedBoxStyle.horizontalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_613235298;
               _DividedBoxStyle.dividerAlpha = 0.75;
               _DividedBoxStyle.verticalGap = 10;
               _DividedBoxStyle.horizontalGap = 10;
            };
         }
      }
   }
}
