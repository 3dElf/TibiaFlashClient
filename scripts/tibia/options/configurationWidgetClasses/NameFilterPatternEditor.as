package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import flash.ui.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.dataGridClasses.*;
    import mx.controls.listClasses.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.utility.*;
    import tibia.options.*;

    public class NameFilterPatternEditor extends HBox implements IDropInListItemRenderer, IFocusManagerComponent
    {
        private var m_UncommittedListData:Boolean = false;
        private var m_UncommittedData:Boolean = false;
        private var m_UncommittedText:Boolean = false;
        protected var m_Text:String = null;
        protected var m_ListData:BaseListData = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIText:TextInput = null;

        public function NameFilterPatternEditor()
        {
            setStyle("borderSkin", null);
            setStyle("borderStyle", "none");
            setStyle("horizontalAlign", "left");
            setStyle("verticalAlign", "middle");
            return;
        }// end function

        protected function onTextInput(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = null;
                if (event is KeyboardEvent && event.type == KeyboardEvent.KEY_DOWN && KeyboardEvent(event).keyCode == Keyboard.ENTER)
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                    this.finishEditText();
                }
                else if (event is KeyboardEvent)
                {
                    _loc_2 = String.fromCharCode(KeyboardEvent(event).charCode);
                }
                else if (event is TextEvent)
                {
                    _loc_2 = TextEvent(event).text;
                }
                if (this.m_UIText.selectionBeginIndex == 0 && (_loc_2 == null || _loc_2.length < 1 || StringHelper.s_IsWhitsepace(_loc_2)))
                {
                    event.preventDefault();
                    event.stopImmediatePropagation();
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedData)
            {
                this.startEditText();
                this.m_UncommittedData = false;
            }
            if (this.m_UncommittedListData)
            {
                this.startEditText();
                this.m_UncommittedListData = false;
            }
            if (this.m_UncommittedText)
            {
                if (this.m_Text != null)
                {
                    this.m_UIText.text = this.m_Text;
                }
                else
                {
                    this.m_UIText.text = resourceManager.getString(ns_options_internal::BUNDLE, "IGNORE_FILTEREDITOR_LBL_EMPTY_PATTERN");
                }
                this.m_UncommittedText = false;
            }
            return;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            if (this.m_ListData != param1)
            {
                this.m_ListData = param1;
                this.m_UncommittedListData = true;
                invalidateProperties();
            }
            return;
        }// end function

        private function finishEditText() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = null;
            if (this.m_ListData is ListData && owner is List)
            {
                _loc_1 = new ListEvent(ListEvent.ITEM_EDIT_END, false, true);
                _loc_1.columnIndex = this.m_ListData.columnIndex;
                _loc_1.rowIndex = this.m_ListData.rowIndex;
                _loc_1.reason = ListEventReason.NEW_ROW;
                _loc_1.itemRenderer = this;
                owner.dispatchEvent(_loc_1);
            }
            else if (this.m_ListData is ListData && owner is Tree)
            {
                _loc_1 = new ListEvent(ListEvent.ITEM_EDIT_END, false, true);
                _loc_1.columnIndex = this.m_ListData.columnIndex;
                _loc_1.rowIndex = this.m_ListData.rowIndex;
                _loc_1.reason = ListEventReason.NEW_ROW;
                _loc_1.itemRenderer = this;
                owner.dispatchEvent(_loc_1);
            }
            else if (this.m_ListData is DataGridListData && owner is DataGrid)
            {
                _loc_2 = this.m_ListData as DataGridListData;
                _loc_3 = new DataGridEvent(DataGridEvent.ITEM_EDIT_END, false, true);
                _loc_3.columnIndex = _loc_2.columnIndex;
                _loc_3.dataField = _loc_2.dataField;
                _loc_3.rowIndex = _loc_2.rowIndex;
                _loc_3.reason = DataGridEventReason.NEW_ROW;
                _loc_3.itemRenderer = this;
                owner.dispatchEvent(_loc_3);
            }
            return;
        }// end function

        override public function set data(param1:Object) : void
        {
            if (super.data != param1)
            {
                super.data = param1;
                this.m_UncommittedData = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function set text(param1:String) : void
        {
            if (this.m_Text == null || this.m_Text != param1)
            {
                this.m_Text = param1;
                this.m_UncommittedText = true;
                invalidateProperties();
            }
            return;
        }// end function

        override public function setFocus() : void
        {
            if (this.m_UIText != null)
            {
                this.m_UIText.setFocus();
                if (this.text == null)
                {
                    this.m_UIText.setSelection(0, 2147483647);
                }
            }
            else
            {
                super.setFocus();
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIText = new TextInput();
                this.m_UIText.percentHeight = NaN;
                this.m_UIText.percentWidth = 100;
                this.m_UIText.addEventListener(KeyboardEvent.KEY_DOWN, this.onTextInput);
                this.m_UIText.addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
                this.m_UIText.setStyle("borderSkin", null);
                this.m_UIText.setStyle("borderStyle", "none");
                addChild(this.m_UIText);
            }
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return this.m_ListData;
        }// end function

        public function get text() : String
        {
            var _loc_1:* = this.m_Text;
            var _loc_2:* = this.m_UIText != null ? (StringHelper.s_Trim(this.m_UIText.text)) : (null);
            if (_loc_2 == null || _loc_2.length < 1)
            {
                return null;
            }
            if (_loc_1 == null && _loc_2 == resourceManager.getString(ns_options_internal::BUNDLE, "IGNORE_FILTEREDITOR_LBL_EMPTY_PATTERN"))
            {
                return null;
            }
            return _loc_2;
        }// end function

        private function startEditText() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = super.data;
            var _loc_2:* = null;
            if (_loc_1 is String)
            {
                _loc_2 = String(_loc_1);
            }
            else if (this.m_ListData is DataGridListData)
            {
                _loc_3 = DataGridListData(this.m_ListData).dataField;
                if (_loc_1 != null && _loc_1.hasOwnProperty(_loc_3))
                {
                    _loc_2 = _loc_1[_loc_3] as String;
                }
            }
            this.text = _loc_2;
            return;
        }// end function

    }
}
