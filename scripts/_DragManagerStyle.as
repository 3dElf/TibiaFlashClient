package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.DefaultDragImage;
   
   public class _DragManagerStyle
   {
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_578313209:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_578313209;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_577002088:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_577002088;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_577029725:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_577029725;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_1915603021:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_1915603021;
       
      public function _DragManagerStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DragManager");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("DragManager",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _DragManagerStyle.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_578313209;
               _DragManagerStyle.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_577029725;
               _DragManagerStyle.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_1915603021;
               _DragManagerStyle.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_577002088;
               _DragManagerStyle.defaultDragImageSkin = DefaultDragImage;
            };
         }
      }
   }
}
