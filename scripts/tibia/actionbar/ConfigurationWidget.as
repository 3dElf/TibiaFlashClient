package tibia.actionbar
{
    import flash.display.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.controls.*;
    import tibia.actionbar.configurationWidgetClasses.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;

    public class ConfigurationWidget extends PopUpBase
    {
        private var m_UIInfoLabel:Label = null;
        private var m_SlotIndex:int = -1;
        private var m_UncommittedSlotIndex:Boolean = false;
        private var m_UIActionEditor:IActionEditor = null;
        private var m_UncommittedActionBar:Boolean = false;
        private var m_UIConstructed:Boolean = false;
        private var m_UIInfoBindings:Label = null;
        private var m_ActionBar:ActionBar = null;
        public static const BUNDLE:String = "ActionButtonConfigurationWidget";

        public function ConfigurationWidget()
        {
            minHeight = 64;
            minWidth = 256;
            return;
        }// end function

        public function set actionBar(param1:ActionBar) : void
        {
            if (this.m_ActionBar != param1)
            {
                this.m_ActionBar = param1;
                this.m_UncommittedActionBar = true;
                invalidateProperties();
                this.slotIndex = -1;
            }
            return;
        }// end function

        public function set slotIndex(param1:int) : void
        {
            if (param1 < 0 || param1 >= ActionBar.NUM_ACTIONS)
            {
                param1 = -1;
            }
            if (this.m_SlotIndex != param1)
            {
                this.m_SlotIndex = param1;
                this.m_UncommittedSlotIndex = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = false;
            if (this.m_UncommittedActionBar)
            {
                _loc_1 = true;
                this.m_UncommittedActionBar = false;
            }
            if (this.m_UncommittedSlotIndex)
            {
                if (this.m_UIActionEditor != null)
                {
                    removeChild(this.m_UIActionEditor as DisplayObject);
                    this.m_UIActionEditor = null;
                }
                if (this.actionBar != null && this.slotIndex >= 0 && this.slotIndex < ActionBar.NUM_ACTIONS)
                {
                    _loc_2 = this.actionBar.getAction(this.slotIndex);
                    if (_loc_2 is EquipAction || _loc_2 is UseAction)
                    {
                        this.m_UIActionEditor = new ObjectEditor();
                    }
                    else
                    {
                        this.m_UIActionEditor = new TextEditor();
                    }
                    this.m_UIActionEditor.action = _loc_2;
                    this.m_UIActionEditor.percentHeight = 100;
                    this.m_UIActionEditor.percentWidth = 100;
                    this.m_UIActionEditor.styleName = "actionConfigurationWidgetEditor";
                    addChildAt(this.m_UIActionEditor as DisplayObject, 0);
                }
                _loc_1 = true;
                this.m_UncommittedSlotIndex = false;
            }
            if (_loc_1)
            {
                _loc_3 = null;
                _loc_4 = null;
                if (this.actionBar != null && this.slotIndex >= 0 && this.slotIndex < ActionBar.NUM_ACTIONS)
                {
                    _loc_5 = this.actionBar.getBindings(this.slotIndex);
                    if (_loc_5 != null && _loc_5.length > 0)
                    {
                        _loc_4 = _loc_5.join(" / ");
                    }
                    else
                    {
                        _loc_4 = resourceManager.getString(BUNDLE, "INFO_BINDINGS_EMPTY");
                    }
                    _loc_3 = this.actionBar.getLabel(this.slotIndex);
                }
                title = resourceManager.getString(BUNDLE, "TITLE", [_loc_3]);
                this.m_UIInfoBindings.text = _loc_4;
                this.m_UIInfoLabel.text = _loc_3;
            }
            super.commitProperties();
            return;
        }// end function

        public function get slotIndex() : int
        {
            return this.m_SlotIndex;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            if (param1 && this.actionBar != null && this.slotIndex >= 0 && this.slotIndex < ActionBar.NUM_ACTIONS)
            {
                this.m_ActionBar.setAction(this.slotIndex, this.m_UIActionEditor.action);
            }
            super.hide(param1);
            return;
        }// end function

        public function get actionBar() : ActionBar
        {
            return this.m_ActionBar;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HRule();
                _loc_1.percentWidth = 100;
                addChild(_loc_1);
                _loc_2 = new Form();
                _loc_2.percentWidth = 100;
                _loc_2.setStyle("paddingBottom", 0);
                _loc_2.setStyle("paddingTop", 0);
                _loc_2.setStyle("verticalGap", 0);
                _loc_3 = new FormHeading();
                _loc_3.label = resourceManager.getString(BUNDLE, "INFO_HEADING");
                _loc_2.addChild(_loc_3);
                this.m_UIInfoLabel = new CustomLabel();
                this.m_UIInfoLabel.percentWidth = 100;
                this.m_UIInfoLabel.truncateToFit = true;
                this.m_UIInfoLabel.setStyle("fontWeight", "bold");
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "INFO_LABEL");
                _loc_4.percentWidth = 100;
                _loc_4.addChild(this.m_UIInfoLabel);
                _loc_2.addChild(_loc_4);
                this.m_UIInfoBindings = new CustomLabel();
                this.m_UIInfoBindings.percentWidth = 100;
                this.m_UIInfoBindings.truncateToFit = true;
                this.m_UIInfoBindings.setStyle("fontWeight", "bold");
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(BUNDLE, "INFO_BINDINGS");
                _loc_4.percentWidth = 100;
                _loc_4.addChild(this.m_UIInfoBindings);
                _loc_2.addChild(_loc_4);
                addChild(_loc_2);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

    }
}
