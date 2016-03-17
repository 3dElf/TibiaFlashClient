package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ToolTipBorder;
   
   public class _ToolTipStyle
   {
       
      public function _ToolTipStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ToolTip");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ToolTip",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ToolTipStyle.borderStyle = "toolTip";
               _ToolTipStyle.paddingTop = 2;
               _ToolTipStyle.borderColor = 9542041;
               _ToolTipStyle.backgroundColor = 16777164;
               _ToolTipStyle.borderSkin = ToolTipBorder;
               _ToolTipStyle.cornerRadius = 2;
               _ToolTipStyle.fontSize = 9;
               _ToolTipStyle.shadowColor = 0;
               _ToolTipStyle.paddingLeft = 4;
               _ToolTipStyle.paddingBottom = 2;
               _ToolTipStyle.backgroundAlpha = 0.95;
               _ToolTipStyle.paddingRight = 4;
            };
         }
      }
   }
}
