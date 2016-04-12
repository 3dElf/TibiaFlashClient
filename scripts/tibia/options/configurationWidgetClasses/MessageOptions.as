package tibia.options.configurationWidgetClasses
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.dataGridClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.options.*;
    import tibia.options.configurationWidgetClasses.*;

    public class MessageOptions extends VBox implements IOptionsEditor
    {
        private var m_UncommittedSelectedMode:Boolean = false;
        protected var m_SelectedMode:int = 0;
        protected var m_UIShowLevels:CheckBox = null;
        private var m_UncommittedValues:Boolean = true;
        protected var m_Options:OptionsStorage = null;
        protected var m_ID:int = 0;
        private var m_UIConstructed:Boolean = false;
        private var m_UncommittedFilterSet:Boolean = false;
        protected var m_AvailableFilterSet:IList = null;
        protected var m_UIFilter:DataGrid = null;
        private var m_UncommittedIndex:Boolean = false;
        protected var m_UIShowTimestamps:CheckBox = null;
        protected var m_UIReset:Button = null;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_FilterSet:IList = null;
        protected var m_Index:int = 0;
        protected var m_DeletedFilterSet:IList = null;
        private var m_UncommittedID:Boolean = false;

        public function MessageOptions()
        {
            label = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_LABEL");
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            this.m_AvailableFilterSet = new ArrayCollection();
            this.m_DeletedFilterSet = new ArrayCollection();
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            return;
        }// end function

        protected function onButtonClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.currentTarget == this.m_UIReset)
            {
                _loc_2 = new EmbeddedDialog();
                _loc_2.buttonFlags = EmbeddedDialog.YES | EmbeddedDialog.NO;
                _loc_2.text = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_DLG_RESET_TEXT");
                _loc_2.title = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_DLG_RESET_TITLE");
                _loc_2.addEventListener(CloseEvent.CLOSE, this.onConfirmReset);
                PopUpBase.getCurrent().embeddedDialog = _loc_2;
            }
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                _loc_1 = new VBox();
                _loc_1.percentHeight = 100;
                _loc_1.percentWidth = 100;
                _loc_1.styleName = "optionsConfigurationWidgetRootContainer";
                _loc_2 = new HBox();
                _loc_2.percentHeight = NaN;
                _loc_2.percentWidth = 100;
                _loc_2.setStyle("horizontalAlgin", "center");
                _loc_2.setStyle("verticalAlign", "middle");
                _loc_3 = new Form();
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                _loc_3.setStyle("paddingBottom", 2);
                _loc_3.setStyle("paddingTop", 2);
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_CONSOLE_TIMESTAMPS");
                _loc_4.percentHeight = NaN;
                _loc_4.percentWidth = 100;
                this.m_UIShowTimestamps = new CheckBox();
                this.m_UIShowTimestamps.addEventListener(Event.CHANGE, this.onCheckBoxChange);
                this.m_UIShowTimestamps.addEventListener(Event.CHANGE, this.onValueChange);
                _loc_4.addChild(this.m_UIShowTimestamps);
                _loc_3.addChild(_loc_4);
                _loc_4 = new FormItem();
                _loc_4.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_CONSOLE_LEVELS");
                _loc_4.percentHeight = NaN;
                _loc_4.percentWidth = 100;
                this.m_UIShowLevels = new CheckBox();
                this.m_UIShowLevels.addEventListener(Event.CHANGE, this.onCheckBoxChange);
                this.m_UIShowLevels.addEventListener(Event.CHANGE, this.onValueChange);
                _loc_4.addChild(this.m_UIShowLevels);
                _loc_3.addChild(_loc_4);
                _loc_2.addChild(_loc_3);
                this.m_UIReset = new CustomButton();
                this.m_UIReset.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_GENERAL_RESET");
                this.m_UIReset.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_2.addChild(this.m_UIReset);
                _loc_1.addChild(_loc_2);
                this.m_UIFilter = new CustomDataGrid();
                _loc_5 = [];
                _loc_6 = new DataGridColumn();
                _loc_6.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_COLUMN_MODE");
                _loc_6.dataField = "modeName";
                _loc_6.editable = false;
                _loc_6.sortable = false;
                _loc_6.width = 190;
                _loc_5.push(_loc_6);
                _loc_6 = new DataGridColumn();
                _loc_6.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_COLUMN_ONSCREEN");
                _loc_6.dataField = "showOnscreen";
                _loc_6.editable = true;
                _loc_6.editorDataField = "selected";
                _loc_6.itemRenderer = new ClassFactory(CheckBox);
                _loc_6.rendererIsEditor = true;
                _loc_6.sortable = false;
                _loc_6.width = 95;
                _loc_6.setStyle("textAlign", "center");
                _loc_5.push(_loc_6);
                _loc_6 = new DataGridColumn();
                _loc_6.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_COLUMN_CHANNEL");
                _loc_6.dataField = "showChannel";
                _loc_6.editable = true;
                _loc_6.editorDataField = "selected";
                _loc_6.itemRenderer = new ClassFactory(CheckBox);
                _loc_6.rendererIsEditor = true;
                _loc_6.sortable = false;
                _loc_6.width = 95;
                _loc_6.setStyle("textAlign", "center");
                _loc_5.push(_loc_6);
                _loc_6 = new DataGridColumn();
                _loc_6.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_COLUMN_COLOUR");
                _loc_6.dataField = "textColour";
                _loc_6.editable = true;
                _loc_6.editorDataField = "selectedIndex";
                _loc_6.itemRenderer = new ClassFactory(ColorComboBox);
                _loc_6.rendererIsEditor = true;
                _loc_6.sortable = false;
                _loc_6.width = 110;
                _loc_6.setStyle("textAlign", "center");
                _loc_5.push(_loc_6);
                this.m_UIFilter.columns = _loc_5;
                this.m_UIFilter.dataProvider = null;
                this.m_UIFilter.editable = true;
                this.m_UIFilter.draggableColumns = false;
                this.m_UIFilter.percentWidth = 100;
                this.m_UIFilter.percentHeight = 100;
                this.m_UIFilter.resizableColumns = false;
                this.m_UIFilter.sortableColumns = false;
                this.m_UIFilter.styleName = getStyle("messageModeListStyle");
                this.m_UIFilter.addEventListener(DataGridEvent.ITEM_EDIT_END, this.onGridEditEnd);
                this.m_UIFilter.addEventListener(ListEvent.CHANGE, this.onGridSelectionChange);
                _loc_1.addChild(this.m_UIFilter);
                addChild(_loc_1);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        private function onValueChange(event:Event) : void
        {
            var _loc_2:* = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
            dispatchEvent(_loc_2);
            return;
        }// end function

        protected function createFilterSet(param1) : IList
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = new Vector.<MessageMode>;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 is MessageFilterSet)
            {
                _loc_7 = param1 as MessageFilterSet;
                _loc_4 = MessageMode.MESSAGE_BEYOND_LAST;
                _loc_3 = MessageMode.MESSAGE_NONE;
                while (_loc_3 < _loc_4)
                {
                    
                    _loc_2.push(_loc_7.getMessageMode(_loc_3));
                    _loc_3++;
                }
            }
            else if (param1 is IList)
            {
                _loc_8 = param1 as IList;
                _loc_4 = _loc_8.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    var _loc_10:* = _loc_8.getItemAt(_loc_3) as MessageMode;
                    _loc_5 = _loc_8.getItemAt(_loc_3) as MessageMode;
                    if (_loc_10 != null)
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_3++;
                }
            }
            else if (param1 is Array)
            {
                _loc_9 = param1 as Array;
                _loc_4 = _loc_9.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_4)
                {
                    
                    var _loc_10:* = _loc_9[_loc_3] as MessageMode;
                    _loc_5 = _loc_9[_loc_3] as MessageMode;
                    if (_loc_10 != null)
                    {
                        _loc_2.push(_loc_5);
                    }
                    _loc_3++;
                }
            }
            else if (param1 is Vector.<MessageMode>)
            {
                _loc_2 = param1 as Vector.<MessageMode>;
            }
            else
            {
                throw new ArgumentError("MessageOptions.createFilterSet: Invalid filter set.");
            }
            var _loc_6:* = new ArrayCollection();
            _loc_4 = _loc_2.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_4)
            {
                
                var _loc_10:* = _loc_2[_loc_3];
                _loc_5 = _loc_2[_loc_3];
                if (_loc_10 != null && _loc_5.editable)
                {
                    _loc_6.addItem({mode:_loc_5.ID, modeName:_loc_5.toString(), showOnscreen:_loc_5.showOnscreenMessage, showChannel:_loc_5.showChannelMessage, textColour:_loc_5.textColour});
                }
                _loc_3++;
            }
            return _loc_6;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
            return;
        }// end function

        public function set ID(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.m_ID != param1)
            {
                _loc_2 = null;
                _loc_3 = -1;
                if (this.m_AvailableFilterSet != null)
                {
                    _loc_4 = this.m_AvailableFilterSet.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_4)
                    {
                        
                        var _loc_6:* = this.m_AvailableFilterSet.getItemAt(_loc_5);
                        _loc_2 = this.m_AvailableFilterSet.getItemAt(_loc_5);
                        if (_loc_6 != null && _loc_2.ID == param1)
                        {
                            _loc_3 = _loc_5;
                            break;
                        }
                        _loc_5++;
                    }
                }
                if (_loc_3 < 0)
                {
                    throw new ArgumentError("MessageOptions.set ID: Invalid ID.");
                }
                this.m_ID = param1;
                this.m_UncommittedID = true;
                this.m_Index = _loc_3;
                this.m_UncommittedIndex = true;
                this.m_FilterSet = _loc_2.filterSet as IList;
                this.m_UncommittedFilterSet = true;
                this.m_UncommittedSelectedMode = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function set selectedMode(param1:int) : void
        {
            if (!MessageMode.s_CheckMode(param1))
            {
                throw new ArgumentError("MessageOptions.set selectedMode: Invalid mode.");
            }
            if (this.m_SelectedMode != param1)
            {
                this.m_SelectedMode = param1;
                this.m_UncommittedSelectedMode = true;
                invalidateProperties();
            }
            return;
        }// end function

        protected function getModeIndex(param1:IList, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 != null && MessageMode.s_CheckMode(param2))
            {
                _loc_3 = param1.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_5 = param1.getItemAt(_loc_4);
                    if (_loc_5 != null && _loc_5.modeID == param2)
                    {
                        return _loc_4;
                    }
                    _loc_4++;
                }
            }
            return -1;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            super.commitProperties();
            if (this.m_UncommittedOptions)
            {
                this.initaliseFilterSets();
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedID)
            {
                this.m_UncommittedID = false;
            }
            if (this.m_UncommittedIndex)
            {
                _loc_1 = null;
                _loc_2 = false;
                _loc_3 = false;
                if (this.m_Index >= 0 && this.m_Index < this.m_AvailableFilterSet.length)
                {
                    _loc_1 = this.m_AvailableFilterSet.getItemAt(this.m_Index);
                    _loc_2 = _loc_1.showTimestamps;
                    _loc_3 = _loc_1.showLevels;
                }
                if (this.m_UIShowTimestamps != null)
                {
                    this.m_UIShowTimestamps.selected = _loc_2;
                }
                if (this.m_UIShowLevels != null)
                {
                    this.m_UIShowLevels.selected = _loc_3;
                }
                this.m_UncommittedIndex = false;
            }
            if (this.m_UncommittedSelectedMode)
            {
                _loc_4 = this.getModeIndex(this.m_FilterSet, this.m_SelectedMode);
                if (_loc_4 > -1 && this.m_UIFilter != null)
                {
                    this.m_UIFilter.selectedIndex = _loc_4;
                    this.m_UIFilter.scrollToIndex(_loc_4);
                }
                this.m_UncommittedSelectedMode = false;
            }
            if (this.m_UncommittedFilterSet)
            {
                if (this.m_UIFilter != null)
                {
                    this.m_UIFilter.dataProvider = this.m_FilterSet;
                }
                this.m_UncommittedFilterSet = false;
            }
            return;
        }// end function

        protected function onCreationComplete(event:FlexEvent) : void
        {
            if (event != null)
            {
                removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
                if (this.m_SelectedMode != MessageMode.MESSAGE_NONE)
                {
                    this.m_UncommittedSelectedMode = true;
                    invalidateProperties();
                }
            }
            return;
        }// end function

        protected function saveFilterSet(param1:IList, param2:MessageFilterSet) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.getItemAt(_loc_4);
                _loc_6 = param2.getMessageMode(_loc_5.mode);
                _loc_6.showOnscreenMessage = _loc_5.showOnscreen;
                _loc_6.showChannelMessage = _loc_5.showChannel;
                _loc_6.textColour = _loc_5.textColour;
                _loc_4++;
            }
            return;
        }// end function

        protected function onGridSelectionChange(event:ListEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = this.m_UIFilter.selectedIndex;
                _loc_3 = null;
                var _loc_4:* = this.m_FilterSet.getItemAt(_loc_2);
                _loc_3 = this.m_FilterSet.getItemAt(_loc_2);
                if (_loc_2 > -1 && this.m_FilterSet != null && _loc_4 != null)
                {
                    this.m_SelectedMode = int(_loc_3.modeID);
                }
                else
                {
                    this.m_SelectedMode = MessageMode.MESSAGE_NONE;
                }
            }
            return;
        }// end function

        public function get selectedMode() : int
        {
            return this.m_SelectedMode;
        }// end function

        protected function initaliseFilterSets() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.m_AvailableFilterSet.removeAll();
            this.m_DeletedFilterSet.removeAll();
            if (this.m_Options != null)
            {
                this.m_ID = MessageFilterSet.DEFAULT_SET;
                this.m_Index = -1;
                this.m_FilterSet = null;
                _loc_1 = this.m_Options.getMessageFilterSetIDs();
                _loc_2 = _loc_1.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = this.m_Options.getMessageFilterSet(_loc_1[_loc_3]);
                    _loc_5 = {ID:_loc_4.ID, name:resourceManager.getString(ConfigurationWidget.BUNDLE, "MESSAGE_DEFAULT_SET_NAME", [(_loc_4.ID + 1)]), filterSet:this.createFilterSet(_loc_4), showTimestamps:_loc_4.showTimestamps, showLevels:_loc_4.showLevels, dirty:false};
                    this.m_AvailableFilterSet.addItem(_loc_5);
                    if (this.m_ID == _loc_4.ID)
                    {
                        this.m_Index = _loc_3;
                        this.m_FilterSet = _loc_5.filterSet as IList;
                    }
                    _loc_3++;
                }
            }
            this.m_UncommittedID = true;
            this.m_UncommittedIndex = true;
            this.m_UncommittedFilterSet = true;
            this.m_UncommittedSelectedMode = true;
            invalidateDisplayList();
            invalidateProperties();
            return;
        }// end function

        protected function onConfirmReset(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            if (event.detail == EmbeddedDialog.YES)
            {
                this.m_Options.resetMessageFilterSet();
                this.m_UncommittedOptions = true;
                invalidateProperties();
                _loc_2 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        protected function onGridEditEnd(event:DataGridEvent) : void
        {
            var _loc_2:* = null;
            if (event != null && event.reason != DataGridEventReason.CANCELLED)
            {
                this.m_AvailableFilterSet.getItemAt(this.m_Index).dirty = true;
                _loc_2 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                dispatchEvent(_loc_2);
            }
            return;
        }// end function

        public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.m_Options != null && param1 && this.m_UncommittedValues)
            {
                _loc_2 = 0;
                _loc_3 = 0;
                _loc_3 = this.m_DeletedFilterSet.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    this.m_Options.removeMessageFilterSet(this.m_DeletedFilterSet.getItemAt(_loc_2).ID);
                    _loc_2++;
                }
                _loc_3 = this.m_AvailableFilterSet.length;
                _loc_2 = 0;
                while (_loc_2 < _loc_3)
                {
                    
                    _loc_4 = this.m_AvailableFilterSet.getItemAt(_loc_2);
                    if (_loc_4.dirty)
                    {
                        _loc_5 = new MessageFilterSet(_loc_4.ID);
                        _loc_5.showTimestamps = _loc_4.showTimestamps;
                        _loc_5.showLevels = _loc_4.showLevels;
                        this.saveFilterSet(_loc_4.filterSet, _loc_5);
                        this.m_Options.addMessageFilterSet(_loc_5);
                    }
                    _loc_2++;
                }
                this.m_UncommittedValues = false;
            }
            return;
        }// end function

        protected function onCheckBoxChange(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            var _loc_4:* = this.m_AvailableFilterSet.getItemAt(this.m_Index);
            _loc_2 = this.m_AvailableFilterSet.getItemAt(this.m_Index);
            if (this.m_Index >= 0 && this.m_Index < this.m_AvailableFilterSet.length && _loc_4 != null && event != null)
            {
                switch(event.currentTarget)
                {
                    case this.m_UIShowTimestamps:
                    {
                        _loc_2.showTimestamps = this.m_UIShowTimestamps.selected;
                        _loc_2.dirty = true;
                        break;
                    }
                    case this.m_UIShowLevels:
                    {
                        _loc_2.showLevels = this.m_UIShowLevels.selected;
                        _loc_2.dirty = true;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                dispatchEvent(_loc_3);
            }
            return;
        }// end function

    }
}
