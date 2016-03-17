package tibia.chat.chatWidgetClasses
{
   import mx.controls.Label;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class NicklistItemRenderer extends Label
   {
      
      public static const HEIGHT_HINT:Number = 18;
      
      {
         s_InitializeStyle();
      }
      
      private var m_UncommittedData:Boolean = false;
      
      public function NicklistItemRenderer()
      {
         super();
      }
      
      private static function s_InitializeStyle() : void
      {
         var Selector:String = "NicklistItemRenderer";
         var Decl:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Decl == null)
         {
            Decl = new CSSStyleDeclaration(Selector);
         }
         Decl.defaultFactory = function():void
         {
            NicklistItemRenderer.subscriberTextColor = 6355040;
            NicklistItemRenderer.inviteeTextColor = 16277600;
         };
         StyleManager.setStyleDeclaration(Selector,Decl,true);
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         this.m_UncommittedData = true;
         invalidateProperties();
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.m_UncommittedData)
         {
            if(data != null && Boolean(data.hasOwnProperty("nick")) && Boolean(data.hasOwnProperty("isSubscriber")))
            {
               text = data["nick"];
               if(data["isSubscriber"])
               {
                  setStyle("color",getStyle("subscriberTextColor"));
               }
               else
               {
                  setStyle("color",getStyle("inviteeTextColor"));
               }
            }
            else
            {
               text = null;
               setStyle("color",0);
            }
            this.m_UncommittedData = false;
         }
      }
   }
}
