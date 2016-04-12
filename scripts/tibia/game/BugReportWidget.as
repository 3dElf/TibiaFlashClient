package tibia.game
{
    import flash.events.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.input.*;
    import tibia.network.*;

    public class BugReportWidget extends PopUpBase
    {
        protected var m_UncommitedCategory:Boolean = false;
        private var m_UncommittedSystemMessage:Boolean = false;
        protected var m_UserMessage:String = null;
        protected var m_UIBugCategory:ComboBox = null;
        protected var m_BugInformation:Object = null;
        private var m_UncommittedUserMessage:Boolean = false;
        protected var m_UIUserMessage:TextArea = null;
        protected var m_Category:int = 3;
        private var m_UIConstructed:Boolean = false;
        public static const BUG_CATEGORY_TYPO:int = 1;
        public static const BUG_CATEGORY_MAP:int = 0;
        public static const BUG_CATEGORY_TECHNICAL:int = 2;
        private static const BUNDLE:String = "BugReportWidget";
        public static const MAX_TOTAL_MESSAGE_LENGTH:int = 1536;
        public static const MAX_USER_MESSAGE_LENGTH:int = 1024;
        public static const BUG_CATEGORY_OTHER:int = 3;

        public function BugReportWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = Tibia.s_GetCommunication();
                if (_loc_2 != null && _loc_2.allowBugreports && _loc_2.isGameRunning)
                {
                    _loc_2.sendCBUGREPORT(this.m_Category, this.m_UserMessage, this.m_BugInformation);
                }
            }
            super.hide(param1);
            return;
        }// end function

        public function get userMessage() : String
        {
            return this.m_UserMessage;
        }// end function

        protected function onTextChange(event:Event) : void
        {
            if (event != null)
            {
                this.m_UserMessage = StringHelper.s_Trim(this.m_UIUserMessage.text);
            }
            return;
        }// end function

        protected function onCategoryChange(event:Event) : void
        {
            if (event != null)
            {
                this.m_Category = this.m_UIBugCategory.selectedIndex;
            }
            return;
        }// end function

        public function get bugInformation()
        {
            return this.m_BugInformation;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedUserMessage)
            {
                this.m_UIUserMessage.text = this.m_UserMessage;
                this.m_UncommittedUserMessage = false;
            }
            if (this.m_UncommittedSystemMessage)
            {
                this.m_UncommittedSystemMessage = false;
            }
            if (this.m_UncommitedCategory)
            {
                this.m_UIBugCategory.selectedIndex = this.m_Category;
                this.m_UncommitedCategory = false;
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new Text();
                _loc_1.text = resourceManager.getString(BUNDLE, "PROMPT");
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                addChild(_loc_1);
                this.m_UIBugCategory = new ComboBox();
                this.m_UIBugCategory.minWidth = 300;
                this.m_UIBugCategory.percentWidth = 100;
                this.m_UIBugCategory.dataProvider = [resourceManager.getString(BUNDLE, "BUG_CATEGORY_MAP"), resourceManager.getString(BUNDLE, "BUG_CATEGORY_TYPO"), resourceManager.getString(BUNDLE, "BUG_CATEGORY_TECHNICAL"), resourceManager.getString(BUNDLE, "BUG_CATEGORY_OTHER")];
                this.m_UIBugCategory.selectedIndex = this.m_Category;
                this.m_UIBugCategory.addEventListener(Event.CHANGE, this.onCategoryChange);
                addChild(this.m_UIBugCategory);
                this.m_UIUserMessage = new TextArea();
                this.m_UIUserMessage.maxChars = BugReportWidget.MAX_USER_MESSAGE_LENGTH;
                this.m_UIUserMessage.minHeight = 200;
                this.m_UIUserMessage.minWidth = 300;
                this.m_UIUserMessage.percentHeight = NaN;
                this.m_UIUserMessage.percentWidth = 100;
                this.m_UIUserMessage.text = this.m_UserMessage;
                this.m_UIUserMessage.addEventListener(Event.CHANGE, this.onTextChange);
                this.m_UIUserMessage.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIUserMessage.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                addChild(this.m_UIUserMessage);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function set bugInformation(param1) : void
        {
            if (this.m_BugInformation != param1)
            {
                this.m_BugInformation = param1;
                this.m_UncommittedSystemMessage = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set userMessage(param1:String) : void
        {
            if (this.m_UserMessage != param1)
            {
                this.m_UserMessage = param1;
                this.m_UncommittedUserMessage = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set category(param1:int) : void
        {
            if (param1 >= BUG_CATEGORY_MAP && param1 <= BUG_CATEGORY_OTHER)
            {
                if (this.m_Category != param1)
                {
                    this.m_Category = param1;
                    this.m_UncommitedCategory = true;
                    invalidateProperties();
                }
            }
            else
            {
                throw new Error("BugReportWidget.setCategory: Invalid category " + param1);
            }
            return;
        }// end function

    }
}
