package tibia.input.widgetClasses
{
    import flash.events.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.*;

    public class AskPlayerNameWidget extends PopUpBase
    {
        protected var m_UILabel:Label = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIText:TextInput = null;
        private var m_UncommittedPrompt:Boolean = false;
        protected var m_Prompt:String = null;
        private var m_UncommittedName:Boolean = false;
        protected var m_Name:String = null;

        public function AskPlayerNameWidget()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UILabel = new Label();
                this.m_UILabel.text = this.m_Prompt;
                this.m_UILabel.percentHeight = NaN;
                this.m_UILabel.percentWidth = 100;
                addChild(this.m_UILabel);
                this.m_UIText = new TextInput();
                this.m_UIText.maxChars = Creature.MAX_NAME_LENGHT;
                this.m_UIText.minWidth = Creature.MAX_NAME_LENGHT * 10;
                this.m_UIText.text = this.m_Name;
                this.m_UIText.percentHeight = NaN;
                this.m_UIText.percentWidth = 100;
                this.m_UIText.addEventListener(Event.CHANGE, this.onTextChange);
                this.m_UIText.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIText.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                addChild(this.m_UIText);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get prompt() : String
        {
            return this.m_Prompt;
        }// end function

        public function set prompt(param1:String) : void
        {
            if (this.m_Prompt != param1)
            {
                this.m_Prompt = param1;
                this.m_UncommittedPrompt = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function onTextChange(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = StringHelper.s_Trim(this.m_UIText.text);
                if (this.m_Name != _loc_2)
                {
                    this.m_Name = _loc_2;
                    _loc_3 = new Event(Event.CHANGE);
                    dispatchEvent(_loc_3);
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedName)
            {
                this.m_UIText.text = this.m_Name;
                this.m_UncommittedName = false;
            }
            if (this.m_UncommittedPrompt)
            {
                this.m_UILabel.text = this.m_Prompt;
                this.m_UncommittedPrompt = false;
            }
            return;
        }// end function

        public function get playerName() : String
        {
            return this.m_Name;
        }// end function

        public function set playerName(param1:String) : void
        {
            var _loc_2:* = null;
            if (this.m_Name != param1)
            {
                this.m_Name = param1;
                this.m_UncommittedName = true;
                invalidateProperties();
                _loc_2 = new Event(Event.CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

    }
}
