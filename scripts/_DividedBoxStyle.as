package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _DividedBoxStyle
   {
      
      private static var _embed_css_Assets_swf_mx_skins_BoxDividerSkin_244285807:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_BoxDividerSkin_244285807;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_357960334:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_357960334;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1490310348:Class = _DividedBoxStyle__embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1490310348;
       
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
               _DividedBoxStyle.verticalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_VBoxDivider_357960334;
               _DividedBoxStyle.dividerSkin = _embed_css_Assets_swf_mx_skins_BoxDividerSkin_244285807;
               _DividedBoxStyle.horizontalDividerCursor = _embed_css_Assets_swf_mx_skins_cursor_HBoxDivider_1490310348;
               _DividedBoxStyle.dividerAlpha = 0.75;
               _DividedBoxStyle.verticalGap = 10;
               _DividedBoxStyle.horizontalGap = 10;
            };
         }
      }
   }
}
