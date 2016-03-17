package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.skins.halo.ComboBoxArrowSkin;
   
   public class _ComboBoxStyle
   {
       
      public function _ComboBoxStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ComboBox");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ComboBox",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _ComboBoxStyle.fontWeight = "bold";
               _ComboBoxStyle.disabledIconColor = 9542041;
               _ComboBoxStyle.dropdownStyleName = "comboDropdown";
               _ComboBoxStyle.leading = 0;
               _ComboBoxStyle.arrowButtonWidth = 22;
               _ComboBoxStyle.cornerRadius = 5;
               _ComboBoxStyle.skin = ComboBoxArrowSkin;
               _ComboBoxStyle.paddingLeft = 5;
               _ComboBoxStyle.paddingRight = 5;
            };
         }
      }
   }
}
