package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TextAreaStyle
   {
       
      public function _TextAreaStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TextArea");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TextArea",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               _TextAreaStyle.borderStyle = "solid";
               _TextAreaStyle.verticalScrollBarStyleName = "textAreaVScrollBarStyle";
               _TextAreaStyle.backgroundColor = 16777215;
               _TextAreaStyle.horizontalScrollBarStyleName = "textAreaHScrollBarStyle";
               _TextAreaStyle.backgroundDisabledColor = 14540253;
            };
         }
      }
   }
}
