package shared.controls
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;

    public class EmbeddedDialog extends VBox
    {
        private var m_UIText:Text = null;
        protected var m_ButtonFlags:uint = 8;
        private var m_UncommittedTitle:Boolean = true;
        private var m_UITitle:Label = null;
        private var m_UIContentBox:Box = null;
        private var m_UITitleBox:HBox = null;
        private var m_UncommittedText:Boolean = true;
        protected var m_Text:String = null;
        private var m_UncommittedButtonFlags:Boolean = true;
        protected var m_Title:String = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIButtonBox:HBox = null;
        public static const NO:uint = 2;
        public static const YES:uint = 1;
        public static const CLEAR:uint = 32;
        private static const BUNDLE:String = "Global";
        public static const OKAY:uint = 4;
        public static const CLOSE:uint = 16;
        private static const DEFAULT_MIN_HEIGHT:Number = 50;
        public static const CANCEL:uint = 8;
        private static const BUTTON_FLAGS:Array = [{data:EmbeddedDialog.OKAY, label:"BTN_OKAY", styleName:"buttonOkayStyle"}, {data:EmbeddedDialog.YES, label:"BTN_YES", styleName:"buttonYesStyle"}, {data:EmbeddedDialog.CLOSE, label:"BTN_CLOSE", styleName:"buttonCloseStyle"}, {data:EmbeddedDialog.NO, label:"BTN_NO", styleName:"buttonNoStyle"}, {data:EmbeddedDialog.CLEAR, label:"BTN_CLEAR", styleName:"buttonClearStyle"}, {data:EmbeddedDialog.CANCEL, label:"BTN_CANCEL", styleName:"buttonCancelStyle"}];
        public static const NONE:uint = 0;

        public function EmbeddedDialog()
        {
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            addEventListener(CloseEvent.CLOSE, this.onClose, false, EventPriority.DEFAULT_HANDLER, false);
            return;
        }// end function

        public function get buttonFlags() : uint
        {
            return this.m_ButtonFlags;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            super.commitProperties();
            if (this.m_UncommittedText)
            {
                if (this.m_UIText != null)
                {
                    this.m_UIText.text = this.m_Text;
                }
                this.m_UncommittedText = false;
            }
            if (this.m_UncommittedTitle)
            {
                this.m_UITitle.text = this.m_Title;
                this.m_UITitleBox.includeInLayout = this.m_Title != null;
                this.m_UITitleBox.visible = this.m_Title != null;
                this.m_UncommittedTitle = false;
            }
            if (this.m_UncommittedButtonFlags)
            {
                _loc_1 = 0;
                _loc_2 = null;
                _loc_1 = this.m_UIButtonBox.numChildren - 1;
                while (_loc_1 >= 0)
                {
                    
                    _loc_2 = this.m_UIButtonBox.removeChildAt(_loc_1) as Button;
                    if (_loc_2 != null)
                    {
                        _loc_2.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
                    }
                    _loc_1 = _loc_1 - 1;
                }
                _loc_1 = 0;
                while (_loc_1 < BUTTON_FLAGS.length)
                {
                    
                    if ((this.m_ButtonFlags & BUTTON_FLAGS[_loc_1].data) != 0)
                    {
                        _loc_2 = new CustomButton();
                        _loc_2.label = resourceManager.getString(BUNDLE, BUTTON_FLAGS[_loc_1].label);
                        _loc_2.data = BUTTON_FLAGS[_loc_1].data;
                        _loc_2.styleName = getStyle(BUTTON_FLAGS[_loc_1].styleName);
                        _loc_2.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                        _loc_2.minWidth = getStyle("minimumButtonWidth");
                        this.m_UIButtonBox.addChild(_loc_2);
                    }
                    _loc_1++;
                }
                this.m_UIButtonBox.includeInLayout = this.m_ButtonFlags != NONE;
                this.m_UIButtonBox.visible = this.m_ButtonFlags != NONE;
                this.m_UncommittedButtonFlags = false;
            }
            return;
        }// end function

        public function get titleBox() : Box
        {
            return this.m_UITitleBox;
        }// end function

        private function onButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event.currentTarget is Button)
            {
                _loc_2 = int(Button(event.currentTarget).data);
                _loc_3 = new CloseEvent(CloseEvent.CLOSE, false, true, _loc_2);
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            if (this.m_Text != param1)
            {
                this.m_Text = param1;
                this.m_UncommittedText = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UITitleBox = new HBox();
                this.m_UITitleBox.percentWidth = 100;
                this.m_UITitleBox.styleName = getStyle("titleBoxStyle");
                addChild(this.m_UITitleBox);
                this.m_UITitle = new Label();
                this.m_UITitle.styleName = getStyle("titleStyle");
                this.m_UITitleBox.addChild(this.m_UITitle);
                this.m_UIContentBox = new VBox();
                this.m_UIContentBox.minHeight = DEFAULT_MIN_HEIGHT;
                this.m_UIContentBox.percentHeight = 100;
                this.m_UIContentBox.percentWidth = 100;
                this.m_UIContentBox.styleName = getStyle("contentBoxStyle");
                this.createContent(this.m_UIContentBox);
                addChild(this.m_UIContentBox);
                this.m_UIButtonBox = new HBox();
                this.m_UIButtonBox.percentWidth = 100;
                this.m_UIButtonBox.styleName = getStyle("buttonBoxStyle");
                addChild(this.m_UIButtonBox);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        protected function createContent(param1:Box) : void
        {
            this.m_UIText = new Text();
            this.m_UIText.percentWidth = 100;
            this.m_UIText.styleName = getStyle("textStyle");
            param1.addChild(this.m_UIText);
            return;
        }// end function

        public function get title() : String
        {
            return this.m_Title;
        }// end function

        private function onClose(event:CloseEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            removeEventListener(CloseEvent.CLOSE, this.onClose);
            if (!event.cancelable || !event.isDefaultPrevented())
            {
                _loc_2 = this.m_UIButtonBox.numChildren - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = this.m_UIButtonBox.removeChildAt(_loc_2) as Button;
                    if (_loc_3 != null)
                    {
                        _loc_3.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
                    }
                    _loc_2 = _loc_2 - 1;
                }
                if (owner is Container && Container(owner).rawChildren.contains(this))
                {
                    Container(owner).rawChildren.removeChild(this);
                }
                else if (owner != null && owner.contains(this))
                {
                    owner.removeChild(this);
                }
            }
            return;
        }// end function

        public function set buttonFlags(param1:uint) : void
        {
            param1 = param1 & (YES | NO | OKAY | CANCEL | CLOSE | CLEAR);
            if (this.m_ButtonFlags != param1)
            {
                this.m_ButtonFlags = param1;
                this.m_UncommittedButtonFlags = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function get text() : String
        {
            return this.m_Text;
        }// end function

        public function get content() : Box
        {
            return this.m_UIContentBox;
        }// end function

        public function set title(param1:String) : void
        {
            if (this.m_Title != param1)
            {
                this.m_Title = param1;
                this.m_UncommittedTitle = true;
                invalidateProperties();
            }
            return;
        }// end function

    }
}
