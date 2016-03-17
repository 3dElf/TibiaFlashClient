package tibia.creatures.buddylistWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import tibia.creatures.BuddySet;
   import mx.core.IUIComponent;
   import flash.events.ContextMenuEvent;
   import tibia.creatures.EditBuddyWidget;
   import tibia.input.gameaction.BuddylistActionImpl;
   import tibia.input.gameaction.PrivateChatActionImpl;
   import shared.utility.closure;
   import tibia.reporting.reportType.Type;
   import tibia.reporting.ReportWidget;
   import flash.system.System;
   import tibia.creatures.buddylistClasses.Buddy;
   
   public class BuddylistItemContextMenu extends ContextMenuBase
   {
      
      private static const BUNDLE:String = "BuddylistWidget";
      
      private static const SORT_MODE:Array = [{
         "value":BuddySet.SORT_NAME,
         "label":"CTX_SORT_NAME"
      },{
         "value":BuddySet.SORT_ICON,
         "label":"CTX_SORT_ICON"
      },{
         "value":BuddySet.SORT_STATUS,
         "label":"CTX_SORT_STATUS"
      }];
       
      protected var m_Buddy:Buddy = null;
      
      protected var m_BuddySet:BuddySet = null;
      
      public function BuddylistItemContextMenu(param1:BuddySet, param2:Buddy)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("BuddylistItemContextmenu.BuddylistItemContextmenu: Invalid buddy set.");
         }
         this.m_BuddySet = param1;
         this.m_Buddy = param2;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var a_Owner:IUIComponent = param1;
         var a_StageX:Number = param2;
         var a_StageY:Number = param3;
         var NeedSeparator:Boolean = false;
         if(this.m_Buddy != null)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_EDIT_BUDDY",[this.m_Buddy.name]),function(param1:ContextMenuEvent):void
            {
               var _loc2_:EditBuddyWidget = new EditBuddyWidget();
               _loc2_.buddySet = m_BuddySet;
               _loc2_.buddy = m_Buddy;
               _loc2_.show();
            });
            createItem(resourceManager.getString(BUNDLE,"CTX_REMOVE_BUDDY",[this.m_Buddy.name]),function(param1:ContextMenuEvent):void
            {
               new BuddylistActionImpl(BuddylistActionImpl.REMOVE,m_Buddy.ID).perform();
            });
            NeedSeparator = true;
         }
         if(this.m_Buddy != null && Boolean(this.m_Buddy.online) && this.m_Buddy.ID != Tibia.s_GetPlayer().ID)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_OPEN_MESSAGE_CHANNEL",[this.m_Buddy.name]),function(param1:ContextMenuEvent):void
            {
               new PrivateChatActionImpl(PrivateChatActionImpl.OPEN_MESSAGE_CHANNEL,m_Buddy.name).perform();
            },NeedSeparator);
            NeedSeparator = true;
         }
         createItem(resourceManager.getString(BUNDLE,"CTX_ADD_BUDDY"),function(param1:ContextMenuEvent):void
         {
            new BuddylistActionImpl(BuddylistActionImpl.ADD_ASK_NAME,null).perform();
         },NeedSeparator);
         var i:int = 0;
         while(i < SORT_MODE.length)
         {
            if(this.m_BuddySet.sortOrder != SORT_MODE[i].value)
            {
               createItem(resourceManager.getString(BUNDLE,SORT_MODE[i].label),closure(null,function(param1:BuddySet, param2:int, param3:ContextMenuEvent):void
               {
                  param1.sortOrder = param2;
               },this.m_BuddySet,SORT_MODE[i].value));
            }
            i++;
         }
         createItem(resourceManager.getString(BUNDLE,!!this.m_BuddySet.showOffline?"CTX_HIDE_OFFLINE":"CTX_SHOW_OFFLINE"),function(param1:ContextMenuEvent):void
         {
            m_BuddySet.showOffline = !m_BuddySet.showOffline;
         });
         NeedSeparator = true;
         if(this.m_Buddy != null && Boolean(this.m_Buddy.isReportTypeAllowed(Type.REPORT_NAME)))
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_REPORT_NAME"),function(param1:ContextMenuEvent):void
            {
               new ReportWidget(Type.REPORT_NAME,m_Buddy).show();
            },NeedSeparator);
            NeedSeparator = true;
         }
         if(this.m_Buddy != null)
         {
            createItem(resourceManager.getString(BUNDLE,"CTX_COPY_NAME"),function(param1:ContextMenuEvent):void
            {
               System.setClipboard(m_Buddy.name);
            },NeedSeparator);
            NeedSeparator = false;
         }
         super.display(a_Owner,a_StageX,a_StageY);
      }
   }
}
