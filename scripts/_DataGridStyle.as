package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.DataGridSortArrow;
   import mx.skins.halo.DataGridColumnDropIndicator;
   import mx.skins.halo.DataGridColumnResizeSkin;
   import mx.skins.halo.DataGridHeaderSeparator;
   import mx.skins.halo.DataGridHeaderBackgroundSkin;
   
   public class _DataGridStyle
   {
      
      private static var _embed_css_Assets_swf_cursorStretch_970976020:Class = _DataGridStyle__embed_css_Assets_swf_cursorStretch_970976020;
       
      public function _DataGridStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("DataGrid");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("DataGrid",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _DataGridStyle.sortArrowSkin = DataGridSortArrow;
               _DataGridStyle.columnDropIndicatorSkin = DataGridColumnDropIndicator;
               _DataGridStyle.columnResizeSkin = DataGridColumnResizeSkin;
               _DataGridStyle.stretchCursor = _embed_css_Assets_swf_cursorStretch_970976020;
               _DataGridStyle.alternatingItemColors = [16250871,16777215];
               _DataGridStyle.headerStyleName = "dataGridStyles";
               _DataGridStyle.headerSeparatorSkin = DataGridHeaderSeparator;
               _DataGridStyle.headerBackgroundSkin = DataGridHeaderBackgroundSkin;
               _DataGridStyle.headerColors = [16777215,15132390];
               _DataGridStyle.headerDragProxyStyleName = "headerDragProxyStyle";
               _DataGridStyle.verticalGridLineColor = 13421772;
            };
         }
      }
   }
}
