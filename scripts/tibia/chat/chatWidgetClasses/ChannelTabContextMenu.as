package tibia.chat.chatWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import tibia.chat.Channel;
   import tibia.chat.ChatStorage;
   import mx.core.IUIComponent;
   import flash.events.ContextMenuEvent;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import tibia.input.gameaction.SaveChannelActionImpl;
   
   public class ChannelTabContextMenu extends ContextMenuBase
   {
      
      private static const BUNDLE:String = "ChatWidget";
       
      protected var m_Channel:Channel = null;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      public function ChannelTabContextMenu(param1:ChatStorage, param2:Channel)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("ChannelTabContextMenu.ChannelTabContextMenu: Invalid chat storage.");
         }
         if(param2 == null)
         {
            throw new ArgumentError("ChannelTabContextMenu.ChannelTabContextMenu: Invalid chat channel.");
         }
         this.m_ChatStorage = param1;
         this.m_Channel = param2;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         var NeedSeparator:Boolean = false;
         if(Boolean(this.m_ChatStorage.hasOwnPrivateChannel) && this.m_Channel.ID == this.m_ChatStorage.ownPrivateChannelID)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_TAB_INVITE"),function(param1:ContextMenuEvent):void
            {
               new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE,null).perform();
            });
            createItem(resourceManager.getString(BUNDLE,"CTX_TAB_EXCLUDE"),function(param1:ContextMenuEvent):void
            {
               new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_EXCLUDE,null).perform();
            });
            NeedSeparator = true;
         }
         if(this.m_Channel.closable)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_TAB_CLOSE"),function(param1:ContextMenuEvent):void
            {
               if(m_Channel != null && m_ChatStorage != null)
               {
                  m_ChatStorage.leaveChannel(m_Channel);
               }
            },NeedSeparator);
            NeedSeparator = true;
         }
         if(Tibia.s_GetChatWidget().rightChannel != this.m_Channel)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_TAB_SHOW_RIGHT"),function(param1:ContextMenuEvent):void
            {
               Tibia.s_GetChatWidget().rightChannel = m_Channel;
            },NeedSeparator);
            NeedSeparator = true;
         }
         createItem(resourceManager.getString(BUNDLE,"CTX_TAB_SAVE"),function(param1:ContextMenuEvent):void
         {
            if(m_Channel != null && m_ChatStorage != null)
            {
               new SaveChannelActionImpl(m_ChatStorage,m_Channel).perform();
            }
         },NeedSeparator);
         createItem(resourceManager.getString(BUNDLE,"CTX_TAB_CLEAR"),function(param1:ContextMenuEvent):void
         {
            if(m_Channel != null)
            {
               m_Channel.clearMessages();
            }
         });
         super.display(a_Owner,a_StageX,a_StageY);
      }
   }
}
