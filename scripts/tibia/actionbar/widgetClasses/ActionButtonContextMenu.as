package tibia.actionbar.widgetClasses
{
    import mx.core.*;
    import tibia.actionbar.*;
    import tibia.appearances.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.staticaction.*;
    import tibia.options.configurationWidgetClasses.*;

    public class ActionButtonContextMenu extends ContextMenuBase
    {
        protected var m_SlotIndex:int = -1;
        protected var m_ActionBar:ActionBar = null;

        public function ActionButtonContextMenu(param1:ActionBar, param2:int)
        {
            if (param1 == null)
            {
                throw new ArgumentError("ActionButtonContextMenu.ActionButtonContextMenu: Invalid action bar.");
            }
            this.m_ActionBar = param1;
            if (param2 < 0 || param2 >= ActionBar.NUM_ACTIONS)
            {
                throw new ArgumentError("ActionButtonContextMenu.ActionButtonContextMenu: Invalid slot index.");
            }
            this.m_SlotIndex = param2;
            return;
        }// end function

        override public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var Type:AppearanceType;
            var a_Owner:* = param1;
            var a_StageX:* = param2;
            var a_StageY:* = param3;
            var _Action:* = this.m_ActionBar.getAction(this.m_SlotIndex);
            var ShowEditAction:Boolean;
            if (_Action is UseAction)
            {
                Type = UseAction(_Action).type;
                ShowEditAction = Type == null || Type.isMultiUse || Type.isCloth;
            }
            if (ShowEditAction)
            {
                createTextItem(resourceManager.getString(ActionBarWidget.BUNDLE, "CTX_EDIT_ACTION"), function (param1) : void
            {
                var _loc_2:* = new ConfigurationWidget();
                _loc_2.actionBar = m_ActionBar;
                _loc_2.slotIndex = m_SlotIndex;
                _loc_2.show();
                return;
            }// end function
            );
            }
            if (_Action != null)
            {
                createTextItem(resourceManager.getString(ActionBarWidget.BUNDLE, "CTX_CLEAR_ACTION"), function (param1) : void
            {
                m_ActionBar.setAction(m_SlotIndex, null);
                return;
            }// end function
            );
            }
            createSeparatorItem();
            createTextItem(resourceManager.getString(ActionBarWidget.BUNDLE, "CTX_EDIT_HOTKEY"), function (param1) : void
            {
                var a_Event:* = param1;
                var _Action:* = StaticActionList.getActionButtonTrigger(m_ActionBar.location, m_SlotIndex);
                var Dialog:* = new tibia.options::ConfigurationWidget();
                Dialog.selectedIndex = tibia.options::ConfigurationWidget.HOTKEY;
                callLater(function (param1:IAction, param2:tibia.options::ConfigurationWidget) : void
                {
                    var _loc_3:* = param2.getEditor(tibia.options::ConfigurationWidget.HOTKEY) as HotkeyOptions;
                    if (_loc_3 != null)
                    {
                        _loc_3.action = param1;
                        _loc_3.beginEditBinding(param1);
                    }
                    return;
                }// end function
                , [_Action, Dialog]);
                Dialog.show();
                return;
            }// end function
            );
            super.display(a_Owner, a_StageX, a_StageY);
            return;
        }// end function

    }
}
