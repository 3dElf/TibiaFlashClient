package tibia.minimap.miniMapWidgetClasses
{
   import tibia.game.ContextMenuBase;
   import mx.core.IUIComponent;
   import flash.ui.ContextMenuItem;
   import flash.events.ContextMenuEvent;
   import tibia.minimap.MiniMapStorage;
   import tibia.minimap.EditMarkWidget;
   
   public class MiniMapWidgetContextMenu extends ContextMenuBase
   {
       
      protected var m_MiniMapStorage:MiniMapStorage;
      
      protected var m_PositionX:int = 0;
      
      protected var m_PositionY:int = 0;
      
      protected var m_PositionZ:int = 0;
      
      public function MiniMapWidgetContextMenu(param1:MiniMapStorage, param2:int, param3:int, param4:int)
      {
         super();
         if(param1 == null)
         {
            throw new ArgumentError("MiniMapWidgetContextMenu.MiniMapWidgetContextMenu: Invalid mini-map storage.");
         }
         this.m_MiniMapStorage = param1;
         this.m_PositionX = param2;
         this.m_PositionY = param3;
         this.m_PositionZ = param4;
      }
      
      override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
      {
         var _loc4_:ContextMenuItem = null;
         if(this.m_MiniMapStorage.getMark(this.m_PositionX,this.m_PositionY,this.m_PositionZ) == null)
         {
            _loc4_ = new ContextMenuItem(resourceManager.getString(MiniMapWidgetView.BUNDLE,"CTX_SET_MARK"));
            _loc4_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemEditMark);
            addItem(_loc4_);
         }
         else
         {
            _loc4_ = new ContextMenuItem(resourceManager.getString(MiniMapWidgetView.BUNDLE,"CTX_EDIT_MARK"));
            _loc4_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemEditMark);
            addItem(_loc4_);
            _loc4_ = new ContextMenuItem(resourceManager.getString(MiniMapWidgetView.BUNDLE,"CTX_CLEAR_MARK"));
            _loc4_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.onItemClearMark);
            addItem(_loc4_);
         }
         super.display(param1,param2,param3);
      }
      
      protected function onItemClearMark(param1:ContextMenuEvent) : void
      {
         if(param1 != null)
         {
            this.m_MiniMapStorage.removeMark(this.m_PositionX,this.m_PositionY,this.m_PositionZ);
         }
      }
      
      protected function onItemEditMark(param1:ContextMenuEvent) : void
      {
         var _loc2_:EditMarkWidget = null;
         if(param1 != null)
         {
            _loc2_ = new EditMarkWidget();
            _loc2_.setMiniMapStorage(this.m_MiniMapStorage);
            _loc2_.setPosition(this.m_PositionX,this.m_PositionY,this.m_PositionZ);
            _loc2_.show();
         }
      }
   }
}
