package tibia.game
{
    import flash.events.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.input.*;
    import tibia.network.*;

    public class SimpleEditTextWidget extends PopUpBase
    {
        private var m_InvalidReadOnly:Boolean = false;
        private var m_UncommittedMaxChars:Boolean = false;
        protected var m_MaxChars:int = 2.14748e+009;
        protected var m_ReadOnly:Boolean = false;
        private var m_UncommittedText:Boolean = false;
        protected var m_Text:String = null;
        private var m_UncommittedID:Boolean = false;
        protected var m_ID:uint = 0;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIText:TextArea = null;
        private static const BUNDLE:String = "EditTextWidget";

        public function SimpleEditTextWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE_EDIT");
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            width = 300;
            height = 300;
            this.invalidateReadOnly();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = null;
                var _loc_3:* = Tibia.s_GetCommunication();
                _loc_2 = Tibia.s_GetCommunication();
                if (!this.m_ReadOnly && _loc_3 != null && _loc_2.isGameRunning)
                {
                    _loc_2.sendCEDITGUILDMESSAGE(StringHelper.s_CleanNewline(this.m_UIText.text));
                }
            }
            super.hide(param1);
            return;
        }// end function

        private function onTextChange(event:Event) : void
        {
            if (event != null)
            {
                this.m_Text = this.m_UIText.text;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = false;
            if (this.m_UncommittedID)
            {
                this.m_UncommittedID = false;
            }
            if (this.m_UncommittedMaxChars)
            {
                this.m_UIText.maxChars = this.m_MaxChars;
                this.m_UncommittedMaxChars = false;
            }
            if (this.m_UncommittedText)
            {
                this.m_UIText.text = this.m_Text;
                this.m_UncommittedText = false;
            }
            if (this.m_InvalidReadOnly)
            {
                _loc_2 = this.m_Text != null && this.m_Text.length > 0;
                if (this.m_ReadOnly)
                {
                    buttonFlags = PopUpBase.BUTTON_CLOSE;
                }
                else
                {
                    buttonFlags = PopUpBase.BUTTON_OKAY | PopUpBase.BUTTON_CANCEL;
                }
                this.m_UIText.editable = !this.m_ReadOnly;
                this.m_InvalidReadOnly = false;
            }
            super.commitProperties();
            return;
        }// end function

        public function get maxChars() : int
        {
            return this.m_MaxChars;
        }// end function

        public function set text(param1:String) : void
        {
            if (param1 != null)
            {
                param1 = StringHelper.s_Trim(param1);
                param1 = param1.substr(0, this.m_MaxChars);
            }
            if (this.m_Text != param1)
            {
                this.m_Text = param1;
                this.m_UncommittedText = true;
                invalidateProperties();
                this.invalidateReadOnly();
            }
            return;
        }// end function

        public function get ID() : uint
        {
            return this.m_ID;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIText = new TextArea();
                this.m_UIText.maxChars = this.m_MaxChars;
                this.m_UIText.percentHeight = 100;
                this.m_UIText.percentWidth = 100;
                this.m_UIText.text = this.m_Text;
                this.m_UIText.addEventListener(Event.CHANGE, this.onTextChange);
                this.m_UIText.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIText.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                addChild(this.m_UIText);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set maxChars(param1:int) : void
        {
            if (this.m_MaxChars != param1)
            {
                if (param1 < this.m_MaxChars && this.m_Text != null)
                {
                    this.m_Text = StringHelper.s_Trim(this.m_Text);
                    this.m_Text = this.m_Text.substr(0, param1);
                    this.m_UncommittedText = true;
                    invalidateProperties();
                }
                this.m_MaxChars = param1;
                this.m_UncommittedMaxChars = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get text() : String
        {
            return this.m_Text;
        }// end function

        public function set ID(param1:uint) : void
        {
            if (this.m_ID != param1)
            {
                this.m_ID = param1;
                this.m_UncommittedID = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function invalidateReadOnly() : void
        {
            this.m_InvalidReadOnly = true;
            invalidateProperties();
            return;
        }// end function

    }
}
