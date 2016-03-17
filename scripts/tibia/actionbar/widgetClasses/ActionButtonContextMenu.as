package tibia.actionbar.widgetClasses
{
   import tibia.game.ContextMenuBase;
   import flash.events.ContextMenuEvent;
   import tibia.actionbar.ConfigurationWidget;
   import mx.core.IUIComponent;
   import tibia.appearances.AppearanceType;
   import tibia.input.IAction;
   import tibia.input.gameaction.UseAction;
   import flash.ui.ContextMenuItem;
   import tibia.actionbar.ActionBar;
   import tibia.input.staticaction.StaticActionList;
   import tibia.options.configurationWidgetClasses.HotkeyOptions;
   
   public class ActionButtonContextMenu extends ContextMenuBase
   {
       
      protected var m_SlotIndex:int = -1;
      
      protected var m_ActionBar:ActionBar = null;
      
      public function ActionButtonContextMenu(param1:ActionBar, param2:int)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("ActionButtonContextMenu.ActionButtonContextMenu: Invalid action bar.");
         }
         this.m_ActionBar = param1;
         if(param2 < 0 || param2 >= ActionBar.NUM_ACTIONS)
         {
            throw new ArgumentError("ActionButtonContextMenu.ActionButtonContextMenu: Invalid slot index.");
         }
         this.m_SlotIndex = param2;
      }
      
      protected function onItemEditAction(param1:ContextMenuEvent) : void
      {
         var _loc2_:tibia.actionbar.ConfigurationWidget = null;
         if(param1 != null)
         {
            _loc2_ = new tibia.actionbar.ConfigurationWidget();
            _loc2_.actionBar = this.m_ActionBar;
            _loc2_.slotIndex = this.m_SlotIndex;
            _loc2_.show();
         }
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var _loc7_:AppearanceType = null;
         var _loc4_:IAction = this.m_ActionBar.getAction(this.m_SlotIndex);
         var _loc5_:Boolean = true;
         if(_loc4_ is UseAction)
         {
            _loc7_ = UseAction(_loc4_).type;
            _loc5_ = _loc7_ == null || Boolean(_loc7_.isMultiUse) || Boolean(_loc7_.isCloth);
         }
         var _loc6_:ContextMenuItem = null;
         if(_loc5_)
         {
            _loc6_ = new ContextMenuItem(resourceManager.getString(ActionBarWidget.BUNDLE,"CTX_EDIT_ACTION"));
            _loc6_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemEditAction);
            addItem(_loc6_);
         }
         if(_loc4_ != null)
         {
            _loc6_ = new ContextMenuItem(resourceManager.getString(ActionBarWidget.BUNDLE,"CTX_CLEAR_ACTION"));
            _loc6_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemClearAction);
            addItem(_loc6_);
         }
         _loc6_ = new ContextMenuItem(resourceManager.getString(ActionBarWidget.BUNDLE,"CTX_EDIT_HOTKEY"),true);
         _loc6_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemEditHotkey);
         addItem(_loc6_);
         super.display(param1,param2,param3);
      }
      
      protected function onItemClearAction(param1:ContextMenuEvent) : void
      {
         if(param1 != null)
         {
            this.m_ActionBar.setAction(this.m_SlotIndex,null);
         }
      }
      
      protected function onItemEditHotkey(param1:ContextMenuEvent) : void
      {
         var _Action:IAction = null;
         var Widget:tibia.options.ConfigurationWidget = null;
         var a_Event:ContextMenuEvent = param1;
         if(a_Event != null)
         {
            _Action = StaticActionList.getActionButtonTrigger(this.m_ActionBar.location,this.m_SlotIndex);
            Widget = new tibia.options.ConfigurationWidget();
            Widget.selectedIndex = tibia.options.ConfigurationWidget.HOTKEY;
            callLater(function(param1:IAction, param2:ConfigurationWidget):void
            {
               var _loc3_:HotkeyOptions = param2.getEditor(ConfigurationWidget.HOTKEY) as HotkeyOptions;
               if(_loc3_ != null)
               {
                  _loc3_.action = param1;
                  _loc3_.beginEditBinding(param1);
               }
            },[_Action,Widget]);
            Widget.show();
         }
      }
   }
}
