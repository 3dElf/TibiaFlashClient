package tibia.game
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.collections.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.game.serverModalDialogClasses.*;
    import tibia.network.*;

    public class ServerModalDialog extends PopUpBase
    {
        private var m_Choices:Vector.<Choice>;
        private var m_UIMessage:Text = null;
        private var m_DefaultEscapeButton:uint = 255;
        private var m_UncommittedSelectedChoice:Boolean = false;
        private var m_SelectedChoice:int = -1;
        private var m_Buttons:Vector.<Choice>;
        private var m_Message:String = null;
        private var m_DefaultEnterButton:uint = 255;
        private var m_UncommittedChoices:Boolean = false;
        private var m_ID:uint = 0;
        private var m_UncommittedButtons:Boolean = false;
        private var m_UIChoices:List = null;
        private var m_UncommittedMessage:Boolean = false;

        public function ServerModalDialog(param1:uint)
        {
            this.m_Buttons = new Vector.<Choice>;
            this.m_Choices = new Vector.<Choice>;
            this.buttonFlags = BUTTON_NONE;
            keyboardFlags = KEY_NONE;
            this.m_ID = param1;
            addEventListener(CloseEvent.CLOSE, this.onClose);
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            return;
        }// end function

        public function get buttons() : Vector.<Choice>
        {
            return this.m_Buttons;
        }// end function

        override protected function commitProperties() : void
        {
            var Child:DisplayObject;
            var i:int;
            var ChoicesList:IList;
            super.commitProperties();
            if (this.m_UncommittedButtons)
            {
                Child;
                i;
                i = (footer.numChildren - 1);
                while (i >= 0)
                {
                    
                    Child = footer.removeChildAt(i);
                    Child.removeEventListener(MouseEvent.CLICK, this.onClose);
                    i = (i - 1);
                }
                if (this.buttons != null)
                {
                    i;
                    while (i < this.buttons.length)
                    {
                        
                        Child = new CustomButton();
                        Button(Child).label = this.buttons[i].label;
                        Button(Child).data = this.buttons[i].value;
                        Child.addEventListener(MouseEvent.CLICK, this.onClose);
                        footer.addChild(Child);
                        i = (i + 1);
                    }
                }
                this.m_UncommittedButtons = false;
            }
            if (this.m_UncommittedChoices)
            {
                if (this.choices != null && this.choices.length > 0)
                {
                    if (this.m_UIChoices == null)
                    {
                        this.m_UIChoices = new CustomList();
                        this.m_UIChoices.doubleClickEnabled = true;
                        this.m_UIChoices.minWidth = 250;
                        this.m_UIChoices.minHeight = 150;
                        this.m_UIChoices.percentHeight = 100;
                        this.m_UIChoices.percentWidth = 75;
                        this.m_UIChoices.addEventListener(ListEvent.CHANGE, this.onChoiceChange);
                        this.m_UIChoices.addEventListener(MouseEvent.DOUBLE_CLICK, this.onChoiceDoubleClick);
                        addChild(this.m_UIChoices);
                    }
                    ChoicesList = new ArrayList();
                    this.choices.forEach(function (param1:Choice, param2, param3) : void
            {
                ChoicesList.addItem(param1);
                return;
            }// end function
            );
                    this.m_UIChoices.dataProvider = ChoicesList;
                    this.selectedChoice = 0;
                }
                else
                {
                    if (this.m_UIChoices != null)
                    {
                        removeChild(this.m_UIChoices);
                        this.m_UIChoices = null;
                    }
                    this.selectedChoice = -1;
                }
                this.m_UncommittedChoices = false;
            }
            if (this.m_UncommittedMessage)
            {
                this.m_UIMessage.htmlText = this.message;
                this.m_UncommittedMessage = false;
            }
            if (this.m_UncommittedSelectedChoice)
            {
                if (this.selectedChoice != -1 && this.m_UIChoices != null)
                {
                    this.m_UIChoices.selectedIndex = this.selectedChoice;
                    callLater(this.m_UIChoices.scrollToIndex, [this.selectedChoice]);
                }
                this.m_UncommittedSelectedChoice = false;
            }
            return;
        }// end function

        public function set defaultEnterButton(param1:uint) : void
        {
            if (this.m_DefaultEnterButton != param1)
            {
                this.m_DefaultEnterButton = param1;
                if (this.m_DefaultEnterButton != 255)
                {
                    keyboardFlags = keyboardFlags | KEY_ENTER;
                }
                else
                {
                    keyboardFlags = keyboardFlags & ~KEY_ENTER;
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIMessage = new Text();
            this.m_UIMessage.htmlText = this.message;
            this.m_UIMessage.maxHeight = NaN;
            this.m_UIMessage.maxWidth = 300;
            this.m_UIMessage.percentHeight = 100;
            this.m_UIMessage.percentWidth = 100;
            addChild(this.m_UIMessage);
            return;
        }// end function

        public function get message() : String
        {
            return this.m_Message;
        }// end function

        private function onClose(event:Event) : void
        {
            var _loc_2:* = 255;
            if (event is CloseEvent && this.defaultEscapeButton != 255 && CloseEvent(event).detail === BUTTON_CANCEL)
            {
                _loc_2 = this.defaultEscapeButton;
            }
            else if (event is CloseEvent && this.defaultEnterButton != 255 && CloseEvent(event).detail === BUTTON_OKAY)
            {
                _loc_2 = this.defaultEnterButton;
            }
            else if (event is MouseEvent && event.target is IDataRenderer)
            {
                _loc_2 = uint(IDataRenderer(event.target).data);
            }
            else
            {
                throw IllegalOperationError("ServerModalDialog.onClose: Event " + event.type + " is not supported.");
            }
            var _loc_3:* = 255;
            if (this.choices != null && this.choices.length > 0 && this.selectedChoice != -1)
            {
                _loc_3 = this.choices[this.selectedChoice].value;
            }
            var _loc_4:* = Tibia.s_GetCommunication();
            if (Tibia.s_GetCommunication() != null && _loc_4.isGameRunning)
            {
                _loc_4.sendCANSWERMODALDIALOG(this.ID, _loc_2, _loc_3);
            }
            if (!(event is CloseEvent) || event.target == this)
            {
                this.hide(false);
            }
            return;
        }// end function

        public function set message(param1:String) : void
        {
            if (this.m_Message != param1)
            {
                this.m_Message = param1;
                this.m_UncommittedMessage = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function get ID() : uint
        {
            return this.m_ID;
        }// end function

        private function get selectedChoice() : int
        {
            return this.m_SelectedChoice;
        }// end function

        public function set buttons(param1:Vector.<Choice>) : void
        {
            if (this.m_Buttons != param1)
            {
                this.m_Buttons = param1;
                this.m_UncommittedButtons = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        public function set defaultEscapeButton(param1:uint) : void
        {
            if (this.m_DefaultEscapeButton != param1)
            {
                this.m_DefaultEscapeButton = param1;
                if (this.m_DefaultEscapeButton != 255)
                {
                    keyboardFlags = keyboardFlags | KEY_ESCAPE;
                }
                else
                {
                    keyboardFlags = keyboardFlags & ~KEY_ESCAPE;
                }
            }
            return;
        }// end function

        public function set choices(param1:Vector.<Choice>) : void
        {
            if (this.m_Choices != param1)
            {
                this.m_Choices = param1;
                this.m_UncommittedChoices = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = footer.numChildren - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = footer.removeChildAt(_loc_2);
                _loc_3.removeEventListener(MouseEvent.CLICK, this.onClose);
                _loc_2 = _loc_2 - 1;
            }
            super.hide(param1);
            return;
        }// end function

        override public function set buttonFlags(param1:uint) : void
        {
            return;
        }// end function

        public function get choices() : Vector.<Choice>
        {
            return this.m_Choices;
        }// end function

        public function get defaultEscapeButton() : uint
        {
            return this.m_DefaultEscapeButton;
        }// end function

        override public function get buttonFlags() : uint
        {
            return BUTTON_NONE;
        }// end function

        private function onChoiceChange(event:ListEvent) : void
        {
            if (event != null)
            {
                this.selectedChoice = this.m_UIChoices.selectedIndex;
            }
            return;
        }// end function

        public function get defaultEnterButton() : uint
        {
            return this.m_DefaultEnterButton;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.DOWN)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.selectedChoice + 1;
                _loc_2.selectedChoice = _loc_3;
            }
            else if (event.keyCode == Keyboard.UP)
            {
                var _loc_2:* = this;
                var _loc_3:* = this.selectedChoice - 1;
                _loc_2.selectedChoice = _loc_3;
            }
            return;
        }// end function

        private function onChoiceDoubleClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (this.choices != null && this.selectedChoice != -1 && this.defaultEnterButton != 255)
            {
                _loc_2 = new CloseEvent(CloseEvent.CLOSE);
                _loc_2.detail = BUTTON_OKAY;
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        private function set selectedChoice(param1:int) : void
        {
            if (this.choices != null)
            {
                param1 = Math.max(0, Math.min(param1, (this.choices.length - 1)));
            }
            else
            {
                param1 = -1;
            }
            if (this.m_SelectedChoice != param1)
            {
                this.m_SelectedChoice = param1;
                this.m_UncommittedSelectedChoice = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}
