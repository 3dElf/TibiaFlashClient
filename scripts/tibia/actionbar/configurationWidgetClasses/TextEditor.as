package tibia.actionbar.configurationWidgetClasses
{
    import flash.display.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.actionbar.configurationWidgetClasses.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.magic.*;
    import tibia.magic.spellListWidgetClasses.*;

    public class TextEditor extends VBox implements IActionEditor
    {
        private var m_UIType:RadioButtonGroup = null;
        private var m_Type:int = 0;
        private var m_SpellParameter:String = null;
        private var m_UncommittedSpell:Boolean = false;
        private var m_UISpell:ComboBox = null;
        private var m_UISpellParameter:TextInput = null;
        private var m_TalkText:String = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedTalkText:Boolean = false;
        private var m_UISpellIcon:SpellIconRenderer = null;
        private var m_UITalkText:TextArea = null;
        private var m_SpellsView:ArrayCollection = null;
        private var m_Spell:Spell = null;
        private var m_UncommittedSpellParameter:Boolean = false;
        private var m_UncommittedTalkAutoSend:Boolean = false;
        private var m_TalkAutoSend:Boolean = false;
        private var m_UITalkAutoSend:CheckBox = null;
        private var m_UncommittedType:Boolean = true;
        private var m_UISpellDescription:Text = null;
        private static const TYPE_TALK:int = 1;
        private static const BUNDLE:String = "ActionButtonConfigurationWidget";
        private static const TYPE_SPELL:int = 0;

        public function TextEditor()
        {
            label = resourceManager.getString(BUNDLE, "TEXT_TITLE");
            var _loc_1:* = new Sort();
            _loc_1.fields = [new SortField("name", true)];
            this.m_SpellsView = new ArrayCollection(SpellStorage.SPELLS);
            this.m_SpellsView.sort = _loc_1;
            this.m_SpellsView.refresh();
            addEventListener(MouseEvent.CLICK, this.onMouseClick, false, (EventPriority.DEFAULT + 1), false);
            return;
        }// end function

        private function onTalkAutoSendChange(event:MouseEvent) : void
        {
            this.talkAutoSend = this.m_UITalkAutoSend.selected;
            return;
        }// end function

        private function onTypeChange(event:ItemClickEvent) : void
        {
            this.type = int(this.m_UIType.selectedValue);
            return;
        }// end function

        protected function set type(param1:int) : void
        {
            if (param1 != TYPE_SPELL && param1 != TYPE_TALK)
            {
                param1 = TYPE_SPELL;
            }
            if (this.m_Type != param1)
            {
                this.m_Type = param1;
                this.m_UncommittedType = true;
                invalidateProperties();
                if (this.type == TYPE_SPELL)
                {
                    this.talkAutoSend = false;
                    this.talkText = null;
                }
                else
                {
                    this.spell = null;
                    this.spellParameter = null;
                }
            }
            return;
        }// end function

        private function onSpellChange(event:ListEvent) : void
        {
            this.spell = this.m_UISpell.selectedItem as Spell;
            this.spellParameter = null;
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new Form();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_1.styleName = "actionConfigurationWidgetRootContainer";
                this.m_UIType = new RadioButtonGroup();
                this.m_UIType.addEventListener(ItemClickEvent.ITEM_CLICK, this.onTypeChange);
                _loc_2 = new RadioButton();
                _loc_2.group = this.m_UIType;
                _loc_2.label = resourceManager.getString(BUNDLE, "TEXT_SPELL_RADIO");
                _loc_2.styleName = this;
                _loc_2.value = TYPE_SPELL;
                _loc_1.addChild(_loc_2);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "TEXT_SPELL_COMBO");
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UISpell = new ComboBox();
                this.m_UISpell.dataProvider = this.m_SpellsView;
                this.m_UISpell.dropdownFactory = new ClassFactory(CustomList);
                this.m_UISpell.labelField = "name";
                this.m_UISpell.percentHeight = NaN;
                this.m_UISpell.percentWidth = 100;
                this.m_UISpell.addEventListener(ListEvent.CHANGE, this.onSpellChange);
                _loc_3.addChild(this.m_UISpell);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.direction = FormItemDirection.HORIZONTAL;
                _loc_3.label = resourceManager.getString(BUNDLE, "TEXT_SPELL_DETAILS");
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UISpellIcon = new SpellIconRenderer();
                _loc_3.addChild(this.m_UISpellIcon);
                this.m_UISpellDescription = new Text();
                _loc_3.addChild(this.m_UISpellDescription);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "TEXT_SPELL_PARAMETER");
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UISpellParameter = new TextInput();
                this.m_UISpellParameter.percentHeight = NaN;
                this.m_UISpellParameter.percentWidth = 100;
                this.m_UISpellParameter.maxChars = 256;
                this.m_UISpellParameter.addEventListener(Event.CHANGE, this.onSpellParameterChange);
                this.m_UISpellParameter.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UISpellParameter.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                _loc_3.addChild(this.m_UISpellParameter);
                _loc_1.addChild(_loc_3);
                _loc_2 = new RadioButton();
                _loc_2.group = this.m_UIType;
                _loc_2.label = resourceManager.getString(BUNDLE, "TEXT_TALK_RADIO");
                _loc_2.styleName = this;
                _loc_2.value = TYPE_TALK;
                _loc_1.addChild(_loc_2);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "TEXT_TALK_TEXT");
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UITalkText = new TextArea();
                this.m_UITalkText.percentWidth = 100;
                this.m_UITalkText.height = 50;
                this.m_UITalkText.maxChars = 256;
                this.m_UITalkText.verticalScrollPolicy = ScrollPolicy.OFF;
                this.m_UITalkText.addEventListener(Event.CHANGE, this.onTalkTextChange);
                this.m_UITalkText.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UITalkText.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                _loc_3.addChild(this.m_UITalkText);
                _loc_1.addChild(_loc_3);
                _loc_3 = new FormItem();
                _loc_3.label = resourceManager.getString(BUNDLE, "TEXT_TALK_AUTOSEND");
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UITalkAutoSend = new CheckBox();
                this.m_UITalkAutoSend.percentWidth = 100;
                this.m_UITalkAutoSend.addEventListener(MouseEvent.CLICK, this.onTalkAutoSendChange);
                _loc_3.addChild(this.m_UITalkAutoSend);
                _loc_1.addChild(_loc_3);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function get talkAutoSend() : Boolean
        {
            return this.m_TalkAutoSend;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as DisplayObject;
            while (_loc_2 != null)
            {
                
                if (_loc_2 == this.m_UISpell || _loc_2 == this.m_UISpellDescription || _loc_2 == this.m_UISpellIcon || _loc_2 == this.m_UISpellParameter)
                {
                    this.type = TYPE_SPELL;
                    return;
                }
                if (_loc_2 == this.m_UITalkAutoSend || _loc_2 == this.m_UITalkText)
                {
                    this.type = TYPE_TALK;
                    return;
                }
                _loc_2 = _loc_2.parent;
            }
            return;
        }// end function

        protected function get spell() : Spell
        {
            return this.m_Spell;
        }// end function

        public function get action() : IAction
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.type == TYPE_SPELL && this.spell != null)
            {
                _loc_1 = null;
                if (this.spellParameter != null)
                {
                    _loc_1 = this.spellParameter.replace("/(^s+|s+$)/", "");
                }
                return new SpellAction(this.spell.ID, _loc_1);
            }
            if (this.type == TYPE_TALK && this.talkText != null)
            {
                _loc_2 = this.talkText.replace(/^\s+/, "").replace(/\s+$/, " ");
                return new TalkAction(_loc_2, this.talkAutoSend);
            }
            return null;
        }// end function

        protected function get type() : int
        {
            return this.m_Type;
        }// end function

        protected function set talkAutoSend(param1:Boolean) : void
        {
            if (this.m_TalkAutoSend != param1)
            {
                this.m_TalkAutoSend = param1;
                this.m_UncommittedTalkAutoSend = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function onTalkTextChange(event:Event) : void
        {
            this.talkText = this.m_UITalkText.text;
            return;
        }// end function

        protected function set spellParameter(param1:String) : void
        {
            if (this.spell == null || !this.spell.hasParameter)
            {
                param1 = null;
            }
            if (this.m_SpellParameter != param1)
            {
                this.m_SpellParameter = param1;
                this.m_UncommittedSpellParameter = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedType)
            {
                this.m_UIType.selectedValue = this.type;
                if (this.type == TYPE_SPELL)
                {
                    this.m_UISpell.enabled = true;
                    this.m_UISpellDescription.enabled = true;
                    this.m_UISpellIcon.enabled = true;
                    if (this.spell != null && this.spell.hasParameter)
                    {
                        this.m_UISpellParameter.enabled = true;
                        if (this.spellParameter != null)
                        {
                            var _loc_1:* = this.spellParameter.length;
                            this.m_UISpellParameter.selectionEndIndex = this.spellParameter.length;
                            this.m_UISpellParameter.selectionBeginIndex = _loc_1;
                        }
                        this.m_UISpellParameter.setFocus();
                    }
                    else
                    {
                        this.m_UISpellParameter.enabled = false;
                    }
                    this.m_UITalkAutoSend.enabled = false;
                    this.m_UITalkText.enabled = false;
                }
                else
                {
                    this.m_UISpell.enabled = false;
                    this.m_UISpellDescription.enabled = false;
                    this.m_UISpellIcon.enabled = false;
                    this.m_UISpellParameter.enabled = false;
                    this.m_UITalkAutoSend.enabled = true;
                    this.m_UITalkText.enabled = true;
                    if (this.talkText != null)
                    {
                        var _loc_1:* = this.talkText.length;
                        this.m_UITalkText.selectionEndIndex = this.talkText.length;
                        this.m_UITalkText.selectionBeginIndex = _loc_1;
                    }
                    this.m_UITalkText.setFocus();
                }
                this.m_UncommittedType = false;
            }
            if (this.m_UncommittedTalkText)
            {
                this.m_UITalkText.text = this.talkText;
                this.m_UncommittedTalkText = false;
            }
            if (this.m_UncommittedTalkAutoSend)
            {
                this.m_UITalkAutoSend.selected = this.talkAutoSend;
                this.m_UncommittedTalkAutoSend = false;
            }
            if (this.m_UncommittedSpell)
            {
                if (this.spell != null)
                {
                    this.m_UISpellDescription.text = this.spell.name + "\n" + this.spell.formula;
                    this.m_UISpellIcon.spell = this.spell;
                    this.m_UISpell.selectedItem = this.spell;
                    if (this.spell.hasParameter)
                    {
                        this.m_UISpellParameter.enabled = true;
                        this.m_UISpellParameter.setFocus();
                    }
                    else
                    {
                        this.m_UISpellParameter.enabled = false;
                    }
                    this.m_UISpellParameter.text = this.spellParameter;
                }
                else
                {
                    this.m_UISpellDescription.text = null;
                    this.m_UISpellIcon.spell = null;
                    this.m_UISpell.selectedItem = null;
                    this.m_UISpellParameter.enabled = false;
                    this.m_UISpellParameter.text = null;
                }
                this.m_UncommittedSpell = false;
            }
            if (this.m_UncommittedSpellParameter)
            {
                this.m_UISpellParameter.text = this.spellParameter;
                this.m_UncommittedSpellParameter = false;
            }
            return;
        }// end function

        protected function set spell(param1:Spell) : void
        {
            if (param1 == null && this.m_SpellsView.length > 0)
            {
                param1 = this.m_SpellsView.getItemAt(0) as Spell;
            }
            if (this.m_Spell != param1)
            {
                this.m_Spell = param1;
                this.m_UncommittedSpell = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function get spellParameter() : String
        {
            return this.m_SpellParameter;
        }// end function

        private function onSpellParameterChange(event:Event) : void
        {
            this.spellParameter = this.m_UISpellParameter.text;
            return;
        }// end function

        protected function set talkText(param1:String) : void
        {
            if (this.m_TalkText != param1)
            {
                this.m_TalkText = param1;
                this.m_UncommittedTalkText = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set action(param1:IAction) : void
        {
            var _loc_2:* = null;
            if (param1 is SpellAction)
            {
                this.type = TYPE_SPELL;
                this.talkText = null;
                this.talkAutoSend = false;
                this.spell = SpellAction(param1).spell;
                this.spellParameter = SpellAction(param1).parameter;
            }
            else if (param1 is TalkAction)
            {
                _loc_2 = param1 as TalkAction;
                this.type = TYPE_TALK;
                this.talkText = _loc_2.text;
                this.talkAutoSend = _loc_2.autoSend;
                this.spell = null;
                this.spellParameter = null;
            }
            else
            {
                this.type = TYPE_SPELL;
                this.talkText = null;
                this.talkAutoSend = false;
                this.spell = null;
                this.spellParameter = null;
            }
            return;
        }// end function

        protected function get talkText() : String
        {
            return this.m_TalkText;
        }// end function

    }
}
