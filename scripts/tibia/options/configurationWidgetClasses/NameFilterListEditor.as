package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.collections.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.controls.dataGridClasses.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.chat.*;
    import tibia.options.*;

    public class NameFilterListEditor extends VBox
    {
        protected var m_UIList:DataGrid = null;
        protected var m_UIButtonAdd:Button = null;
        protected var m_DataProvider:IList = null;
        private var m_UIConstructed:Boolean = false;
        protected var m_UIButtonDel:Button = null;

        public function NameFilterListEditor()
        {
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if (this.m_UIList != null)
            {
                this.m_UIList.enabled = param1;
            }
            if (this.m_UIButtonAdd != null)
            {
                this.m_UIButtonAdd.enabled = param1;
            }
            if (this.m_UIButtonDel != null)
            {
                this.m_UIButtonDel.enabled = param1;
            }
            return;
        }// end function

        protected function onListEdit(event:DataGridEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null && this.m_DataProvider != null)
            {
                switch(event.type)
                {
                    case DataGridEvent.ITEM_EDIT_BEGIN:
                    {
                        break;
                    }
                    case DataGridEvent.ITEM_EDIT_END:
                    {
                        if (event.columnIndex == 1 && (event.reason == DataGridEventReason.CANCELLED || event.reason == DataGridEventReason.NEW_ROW || event.reason == DataGridEventReason.OTHER))
                        {
                            _loc_2 = NameFilterPatternEditor(this.m_UIList.itemEditorInstance);
                            if (_loc_2 == null)
                            {
                                _loc_2 = NameFilterPatternEditor(event.itemRenderer);
                            }
                            if (_loc_2 != null && _loc_2.text == null)
                            {
                                event.preventDefault();
                                this.m_UIList.editedItemPosition = null;
                                this.m_UIList.destroyItemEditor();
                                this.removeItem(event.rowIndex);
                            }
                        }
                        if (event.reason != DataGridEventReason.CANCELLED)
                        {
                            _loc_3 = new OptionsEditorEvent(OptionsEditorEvent.VALUE_CHANGE);
                            dispatchEvent(_loc_3);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIList = new CustomDataGrid();
                _loc_1 = new DataGridColumn();
                _loc_1.dataField = "permanent";
                _loc_1.editable = true;
                _loc_1.editorDataField = "selected";
                _loc_1.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_FILTEREDITOR_LBL_PERMANENT_COLUMN");
                _loc_1.itemRenderer = new ClassFactory(CheckBox);
                _loc_1.rendererIsEditor = true;
                _loc_1.width = 50;
                _loc_1.setStyle("textAlign", "center");
                _loc_2 = new DataGridColumn();
                _loc_2.dataField = "pattern";
                _loc_2.editable = true;
                _loc_2.editorDataField = "text";
                _loc_2.headerText = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_FILTEREDITOR_LBL_PATTERN_COLUMN");
                _loc_2.itemRenderer = new ClassFactory(NameFilterPatternEditor);
                _loc_2.rendererIsEditor = true;
                _loc_2.sortable = true;
                _loc_2.width = NaN;
                this.m_UIList.columns = [_loc_1, _loc_2];
                this.m_UIList.dataProvider = this.m_DataProvider;
                this.m_UIList.draggableColumns = false;
                this.m_UIList.editable = true;
                this.m_UIList.enabled = enabled;
                this.m_UIList.percentHeight = 100;
                this.m_UIList.percentWidth = 100;
                this.m_UIList.resizableColumns = false;
                this.m_UIList.sortableColumns = false;
                this.m_UIList.styleName = getStyle("nameFilterListStyle");
                this.m_UIList.addEventListener(DataGridEvent.ITEM_EDIT_BEGIN, this.onListEdit);
                this.m_UIList.addEventListener(DataGridEvent.ITEM_EDIT_END, this.onListEdit);
                addChild(this.m_UIList);
                _loc_3 = new HBox();
                _loc_3.percentHeight = NaN;
                _loc_3.percentWidth = 100;
                this.m_UIButtonAdd = new CustomButton();
                this.m_UIButtonAdd.enabled = enabled;
                this.m_UIButtonAdd.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_FILTEREDITOR_BTN_ADD");
                this.m_UIButtonAdd.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_3.addChild(this.m_UIButtonAdd);
                _loc_4 = new Spacer();
                _loc_4.percentWidth = 100;
                _loc_3.addChild(_loc_4);
                this.m_UIButtonDel = new CustomButton();
                this.m_UIButtonDel.enabled = enabled;
                this.m_UIButtonDel.label = resourceManager.getString(ConfigurationWidget.BUNDLE, "IGNORE_FILTEREDITOR_BTN_DEL");
                this.m_UIButtonDel.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_3.addChild(this.m_UIButtonDel);
                addChild(_loc_3);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        private function addItem() : NameFilterItem
        {
            var _loc_1:* = null;
            if (this.m_DataProvider != null)
            {
                this.stripEmptyPatterns(this.m_DataProvider);
                _loc_1 = new NameFilterItem(null, false);
                this.m_DataProvider.addItem(_loc_1);
                this.m_UIList.validateNow();
                this.m_UIList.editedItemPosition = {rowIndex:(this.m_DataProvider.length - 1), columnIndex:1};
                return _loc_1;
            }
            return null;
        }// end function

        public function set dataProvider(param1) : void
        {
            if (param1 && param1 is Array)
            {
                this.m_DataProvider = new ArrayCollection(param1 as Array);
            }
            else if (param1 && param1 is IList)
            {
                this.m_DataProvider = param1;
            }
            else
            {
                this.m_DataProvider = new ArrayCollection();
            }
            if (this.m_DataProvider != null)
            {
                this.stripEmptyPatterns(this.m_DataProvider);
            }
            if (this.m_UIList)
            {
                this.m_UIList.dataProvider = this.m_DataProvider;
                this.m_UIList.validateNow();
            }
            return;
        }// end function

        protected function onButtonClick(event:MouseEvent) : void
        {
            if (event != null && this.m_DataProvider != null)
            {
                switch(event.currentTarget)
                {
                    case this.m_UIButtonAdd:
                    {
                        this.addItem();
                        break;
                    }
                    case this.m_UIButtonDel:
                    {
                        this.removeItem(this.m_UIList.selectedIndex);
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function stripEmptyPatterns(param1:IList) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1 != null)
            {
                _loc_2 = param1.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    _loc_3 = NameFilterItem(param1.getItemAt(_loc_2));
                    if (_loc_3 == null || _loc_3.pattern == null)
                    {
                        param1.removeItemAt(_loc_2);
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            return;
        }// end function

        public function get dataProvider() : IList
        {
            return this.m_DataProvider;
        }// end function

        private function removeItem(param1:int) : NameFilterItem
        {
            var _loc_2:* = null;
            if (this.m_DataProvider != null && param1 > -1 && param1 < this.m_DataProvider.length)
            {
                _loc_2 = NameFilterItem(this.m_DataProvider.removeItemAt(param1));
                this.m_UIList.validateNow();
                var _loc_3:* = Math.min(param1, (this.m_DataProvider.length - 1));
                param1 = Math.min(param1, (this.m_DataProvider.length - 1));
                if (_loc_3 > -1)
                {
                    this.m_UIList.selectedIndex = param1;
                    this.m_UIList.scrollToIndex(param1);
                }
                return _loc_2;
            }
            else
            {
                return null;
            }
        }// end function

    }
}
