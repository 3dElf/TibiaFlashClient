package tibia.chat.chatWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import tibia.chat.Channel;
   import mx.core.IUIComponent;
   import flash.events.ContextMenuEvent;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import tibia.input.gameaction.BuddylistActionImpl;
   import tibia.input.gameaction.NameFilterActionImpl;
   import flash.system.System;
   import tibia.reporting.reportType.Type;
   import tibia.reporting.ReportWidget;
   import tibia.chat.ChatStorage;
   import tibia.network.Connection;
   import tibia.worldmap.WorldMapStorage;
   import tibia.chat.MessageMode;
   import tibia.chat.ChannelMessage;
   
   public class ChannelContextMenu extends ContextMenuBase
   {
      
      private static const BUNDLE:String = "ChatWidget";
       
      protected var m_Channel:Channel = null;
      
      protected var m_Message:ChannelMessage = null;
      
      protected var m_View:tibia.chat.chatWidgetClasses.ChannelView = null;
      
      protected var m_ChatStorage:ChatStorage = null;
      
      protected var m_SpeakerName:String = null;
      
      public function ChannelContextMenu(param1:ChatStorage, param2:Channel, param3:ChannelMessage, param4:String, param5:tibia.chat.chatWidgetClasses.ChannelView)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid chat storage.");
         }
         if(param2 == null)
         {
            throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid chat channel.");
         }
         if(param3 == null && param4 == null)
         {
            throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Message and Name may not be both null.");
         }
         if(param5 == null)
         {
            throw new ArgumentError("ChannelContextMenu.ChannelContextMenu: Invalid channel view.");
         }
         this.m_ChatStorage = param1;
         this.m_Channel = param2;
         this.m_Message = param3;
         this.m_SpeakerName = param4;
         this.m_View = param5;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var SelectedText:String = null;
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         var NeedSeparator:Boolean = false;
         if(this.m_SpeakerName != null && this.m_SpeakerName != Tibia.s_GetPlayer().name && (this.m_Message == null || this.m_Message.speakerLevel > 0))
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_PRIVATE_MESSAGE",[this.m_SpeakerName]),function(param1:ContextMenuEvent):void
            {
               new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL,m_SpeakerName).perform();
            });
            if(Boolean(this.m_ChatStorage.hasOwnPrivateChannel) && this.m_Channel.ID != this.m_ChatStorage.ownPrivateChannelID)
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_PRIVATE_INVITE"),function(param1:ContextMenuEvent):void
               {
                  new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_INVITE,m_SpeakerName).perform();
               });
            }
            else if(Boolean(this.m_ChatStorage.hasOwnPrivateChannel) && this.m_Channel.ID == this.m_ChatStorage.ownPrivateChannelID)
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_PRIVATE_EXCLUDE"),function(param1:ContextMenuEvent):void
               {
                  new PrivateChatActionImpl(PrivateChatActionImpl.CHAT_CHANNEL_EXCLUDE,m_SpeakerName).perform();
               });
            }
            if(!BuddylistActionImpl.s_IsBuddy(this.m_SpeakerName))
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_ADD_BUDDY"),function(param1:ContextMenuEvent):void
               {
                  new BuddylistActionImpl(BuddylistActionImpl.ADD_BY_NAME,m_SpeakerName).perform();
               });
            }
            if(NameFilterActionImpl.s_IsBlacklisted(this.m_SpeakerName))
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_PLAYER_UNIGNORE",[this.m_SpeakerName]),function(param1:ContextMenuEvent):void
               {
                  new NameFilterActionImpl(NameFilterActionImpl.UNIGNORE,m_SpeakerName).perform();
               });
            }
            else
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_PLAYER_IGNORE",[this.m_SpeakerName]),function(param1:ContextMenuEvent):void
               {
                  new NameFilterActionImpl(NameFilterActionImpl.IGNORE,m_SpeakerName).perform();
               });
            }
            NeedSeparator = true;
         }
         if(this.m_Message != null)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_SELECT_ALL"),function(param1:ContextMenuEvent):void
            {
               m_View.selectAll();
            },NeedSeparator);
            SelectedText = this.m_View.getSelectedText();
            if(SelectedText != null && SelectedText.length > 0)
            {
               createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_COPY_SELECTED_TEXT"),function(param1:ContextMenuEvent):void
               {
                  System.setClipboard(m_View.getSelectedText());
               });
            }
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_COPY_MESSAGE"),function(param1:ContextMenuEvent):void
            {
               System.setClipboard(m_Message.plainText);
            });
            NeedSeparator = true;
         }
         var ReportEnabled:Boolean = false;
         if(this.m_Message != null && Boolean(this.m_Message.isReportTypeAllowed(Type.REPORT_STATEMENT)))
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_REPORT_STATEMENT"),function(param1:ContextMenuEvent):void
            {
               new ReportWidget(Type.REPORT_STATEMENT,m_Message).show();
            },NeedSeparator);
            NeedSeparator = false;
            ReportEnabled = true;
         }
         if(this.m_Message != null && Boolean(this.m_Message.isReportTypeAllowed(Type.REPORT_NAME)))
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_REPORT_NAME"),function(param1:ContextMenuEvent):void
            {
               new ReportWidget(Type.REPORT_NAME,m_Message).show();
            },NeedSeparator);
            NeedSeparator = false;
            ReportEnabled = true;
         }
         NeedSeparator = ReportEnabled;
         if(this.m_Channel.ID === ChatStorage.HELP_CHANNEL_ID && this.m_Message != null && this.m_Message.ID > 0)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_THANK_YOU"),function(param1:ContextMenuEvent):void
            {
               var _loc2_:Connection = Tibia.s_GetConnection();
               if(_loc2_ != null && Boolean(_loc2_.isGameRunning))
               {
                  _loc2_.sendCTHANKYOU(m_Message.ID);
               }
               var _loc3_:String = resourceManager.getString(BUNDLE,"CTX_VIEW_THANK_YOU_FEEDBACK");
               var _loc4_:WorldMapStorage = Tibia.s_GetWorldMapStorage();
               if(_loc4_ != null)
               {
                  _loc4_.addOnscreenMessage(null,-1,null,0,MessageMode.MESSAGE_THANKYOU,_loc3_);
               }
               if(m_ChatStorage != null)
               {
                  m_ChatStorage.addChannelMessage(-1,-1,null,0,MessageMode.MESSAGE_THANKYOU,_loc3_);
               }
            },NeedSeparator);
            NeedSeparator = true;
         }
         if(this.m_SpeakerName != null)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_VIEW_COPY_NAME"),function(param1:ContextMenuEvent):void
            {
               System.setClipboard(m_SpeakerName);
            },NeedSeparator);
         }
         super.display(a_Owner,a_StageX,a_StageY);
      }
   }
}
