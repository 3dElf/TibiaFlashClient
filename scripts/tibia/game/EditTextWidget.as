package tibia.game
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.appearances.widgetClasses.*;
    import tibia.input.*;
    import tibia.network.*;

    public class EditTextWidget extends PopUpBase
    {
        private var m_UncommittedAuthor:Boolean = false;
        protected var m_UIObject:SkinnedAppearanceRenderer = null;
        private var m_InvalidReadOnly:Boolean = false;
        private var m_UncommittedMaxChars:Boolean = false;
        protected var m_MaxChars:int = 2.14748e+009;
        protected var m_ReadOnly:Boolean = false;
        protected var m_ID:uint = 0;
        private var m_UIConstructed:Boolean = false;
        private var m_InvalidHeading:Boolean = false;
        private var m_UncommittedObjectRef:Boolean = false;
        protected var m_Author:String = null;
        private var m_UncommittedText:Boolean = false;
        private var m_UncommittedDate:Boolean = false;
        protected var m_Date:String = null;
        protected var m_ObjectRef:AppearanceTypeRef = null;
        private var m_UncommittedID:Boolean = false;
        protected var m_Text:String = null;
        protected var m_UIText:TextArea = null;
        protected var m_UIHeading:Text = null;
        private static const BUNDLE:String = "EditTextWidget";

        public function EditTextWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            keyboardFlags = PopUpBase.KEY_ESCAPE;
            width = 300;
            height = 300;
            this.invalidateReadOnly();
            this.invalidateHeading();
            return;
        }// end function

        public function get author() : String
        {
            return this.m_Author;
        }// end function

        public function set author(param1:String) : void
        {
            if (this.m_Author != param1)
            {
                this.m_Author = param1;
                this.m_UncommittedAuthor = true;
                this.invalidateHeading();
                invalidateProperties();
            }
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

        public function get ID() : uint
        {
            return this.m_ID;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new HBox();
                _loc_1.percentHeight = NaN;
                _loc_1.percentWidth = 100;
                _loc_1.setStyle("horizontalAlign", "left");
                _loc_1.setStyle("verticalAlign", "middle");
                _loc_1.setStyle("paddingBottom", 0);
                _loc_1.setStyle("paddingLeft", 0);
                _loc_1.setStyle("paddingRight", 0);
                _loc_1.setStyle("paddingWidth", 0);
                this.m_UIObject = new SkinnedAppearanceRenderer();
                _loc_1.addChild(this.m_UIObject);
                this.m_UIHeading = new Text();
                _loc_1.addChild(this.m_UIHeading);
                addChild(_loc_1);
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

        public function get date() : String
        {
            return this.m_Date;
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

        public function get object() : AppearanceTypeRef
        {
            return this.m_ObjectRef;
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
                    _loc_2.sendCEDITTEXT(this.m_ID, StringHelper.s_CleanNewline(this.m_UIText.text));
                }
            }
            super.hide(param1);
            return;
        }// end function

        protected function invalidateHeading() : void
        {
            this.m_InvalidHeading = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = false;
            if (this.m_UncommittedAuthor)
            {
                this.m_UncommittedAuthor = false;
            }
            if (this.m_UncommittedDate)
            {
                this.m_UncommittedDate = false;
            }
            if (this.m_UncommittedID)
            {
                this.m_UncommittedID = false;
            }
            if (this.m_UncommittedMaxChars)
            {
                this.m_UIText.maxChars = this.m_MaxChars;
                this.m_UncommittedMaxChars = false;
            }
            if (this.m_UncommittedObjectRef)
            {
                this.m_UIObject.appearance = this.m_ObjectRef;
                this.m_UncommittedObjectRef = false;
            }
            if (this.m_UncommittedText)
            {
                this.m_UIText.text = this.m_Text;
                this.m_UncommittedText = false;
            }
            if (this.m_InvalidReadOnly)
            {
                _loc_4 = this.m_Text != null && this.m_Text.length > 0;
                var _loc_7:* = Tibia.s_GetAppearanceStorage();
                _loc_1 = Tibia.s_GetAppearanceStorage();
                var _loc_7:* = _loc_1.getObjectType(this.m_ObjectRef.ID);
                _loc_2 = _loc_1.getObjectType(this.m_ObjectRef.ID);
                if (this.m_ObjectRef != null && _loc_7 != null && _loc_7 != null)
                {
                    this.m_ReadOnly = !(_loc_2.isWriteable || _loc_2.isWriteableOnce && !_loc_4);
                }
                else
                {
                    this.m_ReadOnly = true;
                }
                if (this.m_ReadOnly)
                {
                    buttonFlags = PopUpBase.BUTTON_CLOSE;
                }
                else
                {
                    buttonFlags = PopUpBase.BUTTON_OKAY | PopUpBase.BUTTON_CANCEL;
                }
                this.m_UIText.editable = !this.m_ReadOnly;
                this.invalidateHeading();
                this.m_InvalidReadOnly = false;
            }
            if (this.m_InvalidHeading)
            {
                _loc_5 = this.m_Author != null && this.m_Author.length > 0;
                _loc_6 = this.m_Date != null && this.m_Date.length > 0;
                _loc_4 = this.m_Text != null && this.m_Text.length > 0;
                if (this.m_ReadOnly)
                {
                    if (_loc_4 && _loc_5 && _loc_6)
                    {
                        _loc_3 = "HEADING_RO_TEXT_AUTHOR_DATE";
                    }
                    else if (_loc_4 && _loc_5 && !_loc_6)
                    {
                        _loc_3 = "HEADING_RO_TEXT_AUTHOR";
                    }
                    else if (_loc_4)
                    {
                        _loc_3 = "HEADING_RO_TEXT";
                    }
                    else
                    {
                        _loc_3 = "HEADING_RO";
                    }
                }
                else if (_loc_4 && _loc_5 && _loc_6)
                {
                    _loc_3 = "HEADING_RW_TEXT_AUTHOR_DATE";
                }
                else if (_loc_4 && _loc_5 && !_loc_6)
                {
                    _loc_3 = "HEADING_RW_TEXT_AUTHOR";
                }
                else if (_loc_4)
                {
                    _loc_3 = "HEADING_RW_TEXT";
                }
                else
                {
                    _loc_3 = "HEADING_RW";
                }
                this.m_UIHeading.text = resourceManager.getString(BUNDLE, _loc_3, [this.m_Author, this.m_Date]);
                this.m_InvalidHeading = false;
            }
            super.commitProperties();
            return;
        }// end function

        protected function invalidateReadOnly() : void
        {
            this.m_InvalidReadOnly = true;
            invalidateProperties();
            return;
        }// end function

        public function get maxChars() : int
        {
            return this.m_MaxChars;
        }// end function

        public function set date(param1:String) : void
        {
            if (this.m_Date != param1)
            {
                this.m_Date = param1;
                this.m_UncommittedDate = true;
                this.invalidateHeading();
                invalidateProperties();
            }
            return;
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
                this.invalidateHeading();
                invalidateProperties();
                this.invalidateReadOnly();
            }
            return;
        }// end function

        public function set object(param1:AppearanceTypeRef) : void
        {
            if (this.m_ObjectRef != param1)
            {
                this.m_ObjectRef = param1;
                this.m_UncommittedObjectRef = true;
                this.invalidateHeading();
                invalidateProperties();
                this.invalidateReadOnly();
            }
            return;
        }// end function

    }
}
