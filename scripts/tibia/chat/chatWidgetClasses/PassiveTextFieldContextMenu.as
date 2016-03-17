package tibia.chat.chatWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import mx.core.IUIComponent;
   import flash.events.ContextMenuEvent;
   import flash.system.System;
   
   public class PassiveTextFieldContextMenu extends ContextMenuBase
   {
      
      private static const BUNDLE:String = "Global";
       
      protected var m_TextField:tibia.chat.chatWidgetClasses.PassiveTextField = null;
      
      public function PassiveTextFieldContextMenu(param1:tibia.chat.chatWidgetClasses.PassiveTextField)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("PassiveTextFieldContextMenu.PassiveTextFieldContextMenu: Invalid text field.");
         }
         this.m_TextField = param1;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         var NeedSeparator:Boolean = false;
         var Selection:String = this.m_TextField.getSelectedText();
         if(Selection != null && Selection.length > 0)
         {
            if(this.m_TextField.enabled)
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_CUT"),function(param1:ContextMenuEvent):void
               {
                  if(m_TextField != null)
                  {
                     System.setClipboard(m_TextField.getSelectedText());
                     m_TextField.replaceSelectedText("");
                  }
               });
            }
            createItem(resourceManager.getString(BUNDLE,"CTX_COPY"),function(param1:ContextMenuEvent):void
            {
               if(m_TextField != null)
               {
                  System.setClipboard(m_TextField.getSelectedText());
               }
            });
            NeedSeparator = true;
         }
         if(Selection != null && Selection.length > 0)
         {
            if(this.m_TextField.enabled)
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_DELETE"),function(param1:ContextMenuEvent):void
               {
                  if(m_TextField != null)
                  {
                     m_TextField.replaceSelectedText("");
                  }
               },NeedSeparator);
               NeedSeparator = true;
            }
         }
         createItem(resourceManager.getString(BUNDLE,"CTX_SELECT_ALL"),function(param1:ContextMenuEvent):void
         {
            if(m_TextField != null && m_TextField.text != null)
            {
               m_TextField.setSelection(0,m_TextField.text.length);
            }
         },NeedSeparator);
         super.display(a_Owner,a_StageX,a_StageY);
      }
   }
}
