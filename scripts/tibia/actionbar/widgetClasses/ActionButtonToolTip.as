package tibia.actionbar.widgetClasses
{
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import tibia.actionbar.*;
    import tibia.container.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.magic.*;

    public class ActionButtonToolTip extends VBox implements IToolTip
    {
        private var m_ActionButton:IActionButton = null;
        private var m_UIForm:Form = null;
        private var m_ActionBar:ActionBar = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedActionBar:Boolean = false;
        private var m_UncommittedActionButton:Boolean = false;
        static const TYPE_INSTANT:int = 1;
        static const TYPE_RUNE:int = 2;
        static const GROUP_ATTACK:int = 1;
        public static const BUNDLE:String = "ActionBarWidget";
        static const GROUP_SUPPORT:int = 3;
        static const GROUP_HEALING:int = 2;
        static const GROUP_POWERSTRIKES:int = 4;
        static const TYPE_NONE:int = 0;
        static const GROUP_NONE:int = 0;

        public function ActionButtonToolTip()
        {
            return;
        }// end function

        public function get actionButton() : IActionButton
        {
            return this.m_ActionButton;
        }// end function

        private function disableTruncateToFit(param1:IChildList) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = [param1];
            while (_loc_2.length > 0)
            {
                
                _loc_3 = _loc_2.shift() as IChildList;
                if (_loc_3 == null)
                {
                    continue;
                }
                if (_loc_3 is Label)
                {
                    Label(_loc_3).truncateToFit = false;
                }
                if (_loc_3 is IRawChildrenContainer)
                {
                    _loc_3 = IRawChildrenContainer(_loc_3).rawChildren;
                }
                _loc_4 = _loc_3.numChildren - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_2.push(_loc_3.getChildAt(_loc_4));
                    _loc_4 = _loc_4 - 1;
                }
            }
            return;
        }// end function

        public function set actionButton(param1:IActionButton) : void
        {
            if (this.m_ActionButton != param1)
            {
                this.m_ActionButton = param1;
                this.m_UncommittedActionButton = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            super.commitProperties();
            if (this.m_UncommittedActionBar || this.m_UncommittedActionButton)
            {
                this.m_UIForm.removeAllChildren();
                if (this.actionBar != null && this.actionButton != null)
                {
                    _loc_1 = this.actionButton.action;
                    this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_ACTION"), _loc_1 != null ? (String(_loc_1)) : (resourceManager.getString(BUNDLE, "TIP_ITEM_EMPTY")));
                    if (_loc_1 is UseAction || _loc_1 is EquipAction)
                    {
                        _loc_4 = -1;
                        _loc_5 = -1;
                        if (_loc_1 is UseAction)
                        {
                            _loc_4 = UseAction(_loc_1).type.ID;
                            _loc_5 = UseAction(_loc_1).data;
                        }
                        else
                        {
                            _loc_4 = EquipAction(_loc_1).type.ID;
                            _loc_5 = EquipAction(_loc_1).data;
                        }
                        _loc_6 = Tibia.s_GetContainerStorage();
                        if (_loc_4 != -1 && _loc_5 != -1 && _loc_6 != null)
                        {
                            _loc_7 = _loc_6.getAvailableInventory(_loc_4, _loc_5);
                            this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_USE_REMAINING"), String(_loc_7));
                        }
                    }
                    else if (_loc_1 is SpellAction)
                    {
                        _loc_8 = SpellAction(_loc_1).spell;
                        this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_SPELL_FORMULA"), _loc_8.getFormattedFormula(SpellAction(_loc_1).parameter), new ClassFactory(Label));
                        this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_SPELL_DELAY"), int(_loc_8.delaySelf / 1000) + "s");
                        _loc_9 = null;
                        if (_loc_8.castMana > 0)
                        {
                            _loc_9 = String(_loc_8.castMana);
                        }
                        else
                        {
                            _loc_9 = resourceManager.getString(BUNDLE, "TIP_LABEL_SPELL_MANA_VARYING");
                        }
                        this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_SPELL_CAST"), _loc_9 + " / " + _loc_8.castSoulPoints);
                    }
                    this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_LABEL"), this.actionBar.getLabel(this.actionButton.position));
                    _loc_2 = this.actionBar.getBindings(this.actionButton.position);
                    _loc_3 = null;
                    if (_loc_2 != null && _loc_2.length > 0)
                    {
                        _loc_3 = _loc_2.join(" / ");
                    }
                    else
                    {
                        _loc_3 = resourceManager.getString(BUNDLE, "TIP_ITEM_EMPTY");
                    }
                    this.createFormLabel(this.m_UIForm, resourceManager.getString(BUNDLE, "TIP_LABEL_HOTKEY"), _loc_3, new ClassFactory(Label));
                }
                this.m_UncommittedActionBar = false;
                this.m_UncommittedActionButton = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIForm = new Form();
                this.m_UIForm.horizontalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIForm.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UIForm.setStyle("paddingBottom", 0);
                this.m_UIForm.setStyle("paddingTop", 0);
                this.m_UIForm.setStyle("indicatorGap", 4);
                this.m_UIForm.setStyle("verticalGap", 0);
                addChild(this.m_UIForm);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            return;
        }// end function

        public function get text() : String
        {
            return "";
        }// end function

        private function createFormLabel(param1:Form, param2:String, param3:String, param4:ClassFactory = null) : void
        {
            var _loc_5:* = new Text();
            _loc_5.maxWidth = 200;
            _loc_5.text = param3;
            _loc_5.setStyle("fontWeight", "bold");
            var _loc_6:* = new FormItem();
            _loc_6.label = param2;
            _loc_6.addChild(_loc_5);
            param1.addChild(_loc_6);
            this.disableTruncateToFit(_loc_6);
            return;
        }// end function

        public function set actionBar(param1:ActionBar) : void
        {
            if (this.m_ActionBar != param1)
            {
                this.m_ActionBar = param1;
                this.m_UncommittedActionBar = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get actionBar() : ActionBar
        {
            return this.m_ActionBar;
        }// end function

    }
}
