package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.DefaultDragImage;
   
   public class _DragManagerStyle
   {
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragCopy_627241039:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragCopy_627241039;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragReject_2100536315:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragReject_2100536315;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragLink_627503322:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragLink_627503322;
      
      private static var _embed_css_Assets_swf_mx_skins_cursor_DragMove_627469491:Class = _DragManagerStyle__embed_css_Assets_swf_mx_skins_cursor_DragMove_627469491;
       
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
               _DragManagerStyle.copyCursor = _embed_css_Assets_swf_mx_skins_cursor_DragCopy_627241039;
               _DragManagerStyle.moveCursor = _embed_css_Assets_swf_mx_skins_cursor_DragMove_627469491;
               _DragManagerStyle.rejectCursor = _embed_css_Assets_swf_mx_skins_cursor_DragReject_2100536315;
               _DragManagerStyle.linkCursor = _embed_css_Assets_swf_mx_skins_cursor_DragLink_627503322;
               _DragManagerStyle.defaultDragImageSkin = DefaultDragImage;
            };
         }
      }
   }
}
