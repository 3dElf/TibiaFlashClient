package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.ui.*;
    import mx.collections.*;
    import mx.controls.dataGridClasses.*;
    import mx.controls.listClasses.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;

    public class ComboBox extends ComboBase implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer
    {
        private var _labelField:String = "label";
        private var dropdownBorderStyle:String = "solid";
        private var implicitSelectedIndex:Boolean = false;
        private var _selectedIndexOnDropdown:int = -1;
        private var preferredDropdownWidth:Number;
        private var collectionChanged:Boolean = false;
        private var labelFunctionChanged:Boolean;
        private var selectedItemSet:Boolean;
        private var _dropdownWidth:Number = 100;
        private var inTween:Boolean = false;
        private var _oldIndex:int;
        private var tweenUp:Boolean = false;
        private var tween:Tween = null;
        private var labelFieldChanged:Boolean;
        private var _dropdown:ListBase;
        private var _dropdownFactory:IFactory;
        private var explicitText:Boolean;
        private var _prompt:String;
        private var _data:Object;
        private var bInKeyDown:Boolean = false;
        private var promptChanged:Boolean = false;
        private var _rowCount:int = 5;
        private var bRemoveDropdown:Boolean = true;
        private var _showingDropdown:Boolean = false;
        private var triggerEvent:Event;
        private var _listData:BaseListData;
        private var _itemRenderer:IFactory;
        private var _labelFunction:Function;
        static const VERSION:String = "3.6.0.21751";
        static var createAccessibilityImplementation:Function;

        public function ComboBox()
        {
            _dropdownFactory = new ClassFactory(List);
            dataProvider = new ArrayCollection();
            useFullDropdownSkin = true;
            wrapDownArrowButton = false;
            addEventListener("unload", unloadHandler);
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
            return;
        }// end function

        override protected function calculatePreferredSizeFromData(param1:int) : Object
        {
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = iterator ? (iterator.bookmark) : (null);
            iterator.seek(CursorBookmark.FIRST, 0);
            var _loc_5:* = iterator != null;
            var _loc_7:* = 0;
            while (_loc_7 < param1)
            {
                
                if (_loc_5)
                {
                    _loc_8 = iterator ? (iterator.current) : (null);
                }
                else
                {
                    _loc_8 = null;
                }
                _loc_9 = itemToLabel(_loc_8);
                _loc_6 = measureText(_loc_9);
                _loc_2 = Math.max(_loc_2, _loc_6.width);
                _loc_3 = Math.max(_loc_3, _loc_6.height);
                if (iterator)
                {
                    iterator.moveNext();
                }
                _loc_7++;
            }
            if (prompt)
            {
                _loc_6 = measureText(prompt);
                _loc_2 = Math.max(_loc_2, _loc_6.width);
                _loc_3 = Math.max(_loc_3, _loc_6.height);
            }
            _loc_2 = _loc_2 + (getStyle("paddingLeft") + getStyle("paddingRight"));
            if (iterator)
            {
                iterator.seek(_loc_4, 0);
            }
            return {width:_loc_2, height:_loc_3};
        }// end function

        private function dropdown_scrollHandler(event:Event) : void
        {
            var _loc_2:* = null;
            if (event is ScrollEvent)
            {
                _loc_2 = ScrollEvent(event);
                if (_loc_2.detail == ScrollEventDetail.THUMB_TRACK || _loc_2.detail == ScrollEventDetail.THUMB_POSITION || _loc_2.detail == ScrollEventDetail.LINE_UP || _loc_2.detail == ScrollEventDetail.LINE_DOWN)
                {
                    dispatchEvent(_loc_2);
                }
            }
            return;
        }// end function

        public function get dropdown() : ListBase
        {
            return getDropdown();
        }// end function

        public function get selectedLabel() : String
        {
            var _loc_1:* = selectedItem;
            return itemToLabel(_loc_1);
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            if (_showingDropdown && _dropdown)
            {
                if (!event.relatedObject || !_dropdown.contains(event.relatedObject))
                {
                    close();
                }
            }
            super.focusOutHandler(event);
            return;
        }// end function

        private function destroyDropdown() : void
        {
            if (inTween)
            {
                tween.endTween();
            }
            displayDropdown(false, null, false);
            return;
        }// end function

        public function get dropdownWidth() : Number
        {
            return _dropdownWidth;
        }// end function

        private function unloadHandler(event:Event) : void
        {
            if (inTween)
            {
                UIComponent.resumeBackgroundProcessing();
                inTween = false;
            }
            if (_dropdown)
            {
                _dropdown.parent.removeChild(_dropdown);
            }
            return;
        }// end function

        public function open() : void
        {
            displayDropdown(true);
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            var _loc_2:* = undefined;
            _data = param1;
            if (_listData && _listData is DataGridListData)
            {
                _loc_2 = _data[DataGridListData(_listData).dataField];
            }
            else if (_listData is ListData && ListData(_listData).labelField in _data)
            {
                _loc_2 = _data[ListData(_listData).labelField];
            }
            else
            {
                _loc_2 = _data;
            }
            if (_loc_2 !== undefined && !selectedItemSet)
            {
                selectedItem = _loc_2;
                selectedItemSet = false;
            }
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
            return;
        }// end function

        public function get rowCount() : int
        {
            return Math.max(1, Math.min(collection.length, _rowCount));
        }// end function

        override protected function textInput_changeHandler(event:Event) : void
        {
            super.textInput_changeHandler(event);
            dispatchChangeEvent(event, -1, -2);
            return;
        }// end function

        private function dropdown_itemRollOutHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredMinWidth = Math.max(measuredWidth, DEFAULT_MEASURED_MIN_WIDTH);
            var _loc_1:* = measureText("M").height + 6;
            var _loc_2:* = borderMetrics;
            var _loc_3:* = Math.max(_loc_1 + _loc_2.top + _loc_2.bottom, DEFAULT_MEASURED_MIN_HEIGHT);
            measuredHeight = Math.max(_loc_1 + _loc_2.top + _loc_2.bottom, DEFAULT_MEASURED_MIN_HEIGHT);
            measuredMinHeight = _loc_3;
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                var _loc_3:* = measuredHeight + (getStyle("paddingTop") + getStyle("paddingBottom"));
                measuredHeight = measuredHeight + (getStyle("paddingTop") + getStyle("paddingBottom"));
                measuredMinHeight = _loc_3;
            }
            return;
        }// end function

        private function dropdown_itemRollOverHandler(event:Event) : void
        {
            dispatchEvent(event);
            return;
        }// end function

        public function get prompt() : String
        {
            return _prompt;
        }// end function

        override protected function keyDownHandler(event:KeyboardEvent) : void
        {
            var _loc_2:* = 0;
            if (!enabled)
            {
                return;
            }
            if (event.target == textInput)
            {
                return;
            }
            if (event.ctrlKey && event.keyCode == Keyboard.DOWN)
            {
                displayDropdown(true, event);
                event.stopPropagation();
            }
            else if (event.ctrlKey && event.keyCode == Keyboard.UP)
            {
                close(event);
                event.stopPropagation();
            }
            else if (event.keyCode == Keyboard.ESCAPE)
            {
                if (_showingDropdown)
                {
                    if (_oldIndex != _dropdown.selectedIndex)
                    {
                        selectedIndex = _oldIndex;
                    }
                    displayDropdown(false);
                    event.stopPropagation();
                }
            }
            else if (event.keyCode == Keyboard.ENTER)
            {
                if (_showingDropdown)
                {
                    close();
                    event.stopPropagation();
                }
            }
            else if (!editable || event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.PAGE_UP || event.keyCode == Keyboard.PAGE_DOWN)
            {
                _loc_2 = selectedIndex;
                bInKeyDown = _showingDropdown;
                dropdown.dispatchEvent(event.clone());
                event.stopPropagation();
                bInKeyDown = false;
            }
            return;
        }// end function

        public function set dropdownWidth(param1:Number) : void
        {
            _dropdownWidth = param1;
            preferredDropdownWidth = param1;
            if (_dropdown)
            {
                _dropdown.setActualSize(param1, _dropdown.height);
            }
            dispatchEvent(new Event("dropdownWidthChanged"));
            return;
        }// end function

        public function get labelField() : String
        {
            return _labelField;
        }// end function

        public function set dropdownFactory(param1:IFactory) : void
        {
            _dropdownFactory = param1;
            dispatchEvent(new Event("dropdownFactoryChanged"));
            return;
        }// end function

        override public function set dataProvider(param1:Object) : void
        {
            selectionChanged = true;
            super.dataProvider = param1;
            destroyDropdown();
            invalidateProperties();
            invalidateSize();
            return;
        }// end function

        function get isShowingDropdown() : Boolean
        {
            return _showingDropdown;
        }// end function

        override protected function collectionChangeHandler(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = selectedIndex;
            super.collectionChangeHandler(event);
            if (event is CollectionEvent)
            {
                _loc_3 = CollectionEvent(event);
                if (collection.length == 0)
                {
                    if (!selectedIndexChanged && !selectedItemChanged)
                    {
                        if (super.selectedIndex != -1)
                        {
                            super.selectedIndex = -1;
                        }
                        implicitSelectedIndex = true;
                        invalidateDisplayList();
                    }
                    if (textInput && !editable)
                    {
                        textInput.text = "";
                    }
                }
                else if (_loc_3.kind == CollectionEventKind.ADD)
                {
                    if (collection.length == _loc_3.items.length)
                    {
                        if (selectedIndex == -1 && _prompt == null)
                        {
                            selectedIndex = 0;
                        }
                    }
                    else
                    {
                        return;
                    }
                }
                else if (_loc_3.kind == CollectionEventKind.UPDATE)
                {
                    if (_loc_3.location == selectedIndex || _loc_3.items[0].source == selectedItem)
                    {
                        selectionChanged = true;
                    }
                }
                else
                {
                    if (_loc_3.kind == CollectionEventKind.REPLACE)
                    {
                        return;
                    }
                    if (_loc_3.kind == CollectionEventKind.RESET)
                    {
                        collectionChanged = true;
                        if (!selectedIndexChanged && !selectedItemChanged)
                        {
                            selectedIndex = prompt ? (-1) : (0);
                        }
                        invalidateProperties();
                    }
                }
                invalidateDisplayList();
                destroyDropdown();
            }
            return;
        }// end function

        function onTweenEnd(param1:Number) : void
        {
            if (_dropdown)
            {
                _dropdown.scrollRect = null;
                inTween = false;
                _dropdown.enabled = true;
                _dropdown.visible = _showingDropdown;
                if (bRemoveDropdown)
                {
                    _dropdown.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, dropdown_mouseOutsideHandler);
                    _dropdown.removeEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, dropdown_mouseOutsideHandler);
                    _dropdown.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, dropdown_mouseOutsideHandler);
                    _dropdown.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, dropdown_mouseOutsideHandler);
                    PopUpManager.removePopUp(_dropdown);
                    _dropdown = null;
                }
            }
            bRemoveDropdown = true;
            UIComponent.resumeBackgroundProcessing();
            var _loc_2:* = new DropdownEvent(_showingDropdown ? (DropdownEvent.OPEN) : (DropdownEvent.CLOSE));
            _loc_2.triggerEvent = triggerEvent;
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function get listData() : BaseListData
        {
            return _listData;
        }// end function

        private function getDropdown() : ListBase
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!initialized)
            {
                return null;
            }
            if (!hasDropdown())
            {
                _loc_2 = getStyle("dropDownStyleName");
                if (_loc_2 == null)
                {
                    _loc_2 = getStyle("dropdownStyleName");
                }
                _dropdown = dropdownFactory.newInstance();
                _dropdown.visible = false;
                _dropdown.focusEnabled = false;
                _dropdown.owner = this;
                if (itemRenderer)
                {
                    _dropdown.itemRenderer = itemRenderer;
                }
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _dropdown.styleName = this;
                }
                if (_loc_2)
                {
                    if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                    {
                        _loc_3 = StyleManager.getStyleDeclaration("." + _loc_2);
                        if (_loc_3)
                        {
                            _dropdown.styleDeclaration = _loc_3;
                        }
                    }
                    else
                    {
                        _dropdown.styleName = _loc_2;
                    }
                }
                else if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
                {
                    _dropdown.setStyle("cornerRadius", 0);
                }
                PopUpManager.addPopUp(_dropdown, this);
                _dropdown.setStyle("selectionDuration", 0);
                if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0 && dropdownBorderStyle && dropdownBorderStyle != "")
                {
                    _dropdown.setStyle("borderStyle", dropdownBorderStyle);
                }
                if (!dataProvider)
                {
                    dataProvider = new ArrayCollection();
                }
                _dropdown.dataProvider = dataProvider;
                _dropdown.rowCount = rowCount;
                _dropdown.width = _dropdownWidth;
                _dropdown.selectedIndex = selectedIndex;
                _oldIndex = selectedIndex;
                _dropdown.verticalScrollPolicy = ScrollPolicy.AUTO;
                _dropdown.labelField = _labelField;
                _dropdown.labelFunction = itemToLabel;
                _dropdown.allowDragSelection = true;
                _dropdown.addEventListener("change", dropdown_changeHandler);
                _dropdown.addEventListener(ScrollEvent.SCROLL, dropdown_scrollHandler);
                _dropdown.addEventListener(ListEvent.ITEM_ROLL_OVER, dropdown_itemRollOverHandler);
                _dropdown.addEventListener(ListEvent.ITEM_ROLL_OUT, dropdown_itemRollOutHandler);
                _dropdown.addEventListener(ListEvent.ITEM_CLICK, dropdown_itemClickHandler);
                UIComponentGlobals.layoutManager.validateClient(_dropdown, true);
                _dropdown.setActualSize(_dropdownWidth, _dropdown.getExplicitOrMeasuredHeight());
                _dropdown.validateDisplayList();
                _dropdown.cacheAsBitmap = true;
                systemManager.addEventListener(Event.RESIZE, stage_resizeHandler, false, 0, true);
            }
            var _loc_1:* = transform.concatenatedMatrix;
            _dropdown.scaleX = _loc_1.a;
            _dropdown.scaleY = _loc_1.d;
            return _dropdown;
        }// end function

        private function stage_resizeHandler(event:Event) : void
        {
            destroyDropdown();
            return;
        }// end function

        override protected function downArrowButton_buttonDownHandler(event:FlexEvent) : void
        {
            if (_showingDropdown)
            {
                close(event);
            }
            else
            {
                displayDropdown(true, event);
            }
            return;
        }// end function

        override public function set selectedItem(param1:Object) : void
        {
            selectedItemSet = true;
            implicitSelectedIndex = false;
            super.selectedItem = param1;
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (ComboBox.createAccessibilityImplementation != null)
            {
                ComboBox.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        public function itemToLabel(param1:Object, ... args) : String
        {
            args = new activation;
            var item:* = param1;
            var rest:* = args;
            if ( == null)
            {
                return "";
            }
            if (labelFunction != null)
            {
                return labelFunction();
            }
            if (typeof() == "object")
            {
                try
                {
                    if (this[labelField] != null)
                    {
                        item = this[labelField];
                    }
                }
                catch (e:Error)
                {
                }
            }
            else if (typeof() == "xml")
            {
                try
                {
                    if (this[labelField].length() != 0)
                    {
                        item = this[labelField];
                    }
                }
                catch (e:Error)
                {
                }
            }
            if (typeof() == "string")
            {
                return String();
            }
            try
            {
                return this.toString();
            }
            catch (e:Error)
            {
            }
            return " ";
        }// end function

        public function get data() : Object
        {
            return _data;
        }// end function

        function onTweenUpdate(param1:Number) : void
        {
            if (_dropdown)
            {
                _dropdown.scrollRect = new Rectangle(0, param1, _dropdown.width, _dropdown.height);
            }
            return;
        }// end function

        private function removedFromStageHandler(event:Event) : void
        {
            destroyDropdown();
            return;
        }// end function

        private function dropdown_mouseOutsideHandler(event:Event) : void
        {
            var _loc_2:* = null;
            if (event is MouseEvent)
            {
                _loc_2 = MouseEvent(event);
                if (_loc_2.target != _dropdown)
                {
                    return;
                }
                if (!hitTestPoint(_loc_2.stageX, _loc_2.stageY, true))
                {
                    close(event);
                }
            }
            else if (event is SandboxMouseEvent)
            {
                close(event);
            }
            return;
        }// end function

        public function get dropdownFactory() : IFactory
        {
            return _dropdownFactory;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            destroyDropdown();
            super.styleChanged(param1);
            return;
        }// end function

        public function set prompt(param1:String) : void
        {
            _prompt = param1;
            promptChanged = true;
            invalidateProperties();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            explicitText = textChanged;
            super.commitProperties();
            if (collectionChanged)
            {
                if (selectedIndex == -1 && implicitSelectedIndex && _prompt == null)
                {
                    selectedIndex = 0;
                }
                selectedIndexChanged = true;
                collectionChanged = false;
            }
            if (promptChanged && prompt != null && selectedIndex == -1)
            {
                promptChanged = false;
                textInput.text = prompt;
            }
            return;
        }// end function

        function hasDropdown() : Boolean
        {
            return _dropdown != null;
        }// end function

        public function set listData(param1:BaseListData) : void
        {
            _listData = param1;
            return;
        }// end function

        public function set labelField(param1:String) : void
        {
            _labelField = param1;
            labelFieldChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFieldChanged"));
            return;
        }// end function

        public function set labelFunction(param1:Function) : void
        {
            _labelFunction = param1;
            labelFunctionChanged = true;
            invalidateDisplayList();
            dispatchEvent(new Event("labelFunctionChanged"));
            return;
        }// end function

        protected function get dropDownStyleFilters() : Object
        {
            return null;
        }// end function

        public function set rowCount(param1:int) : void
        {
            _rowCount = param1;
            if (_dropdown)
            {
                _dropdown.rowCount = param1;
            }
            return;
        }// end function

        private function dropdown_changeHandler(event:Event) : void
        {
            var _loc_2:* = selectedIndex;
            if (_dropdown)
            {
                selectedIndex = _dropdown.selectedIndex;
            }
            if (!_showingDropdown)
            {
                dispatchChangeEvent(event, _loc_2, selectedIndex);
            }
            else if (!bInKeyDown)
            {
                close();
            }
            return;
        }// end function

        private function dropdown_itemClickHandler(event:ListEvent) : void
        {
            if (_showingDropdown)
            {
                close();
            }
            return;
        }// end function

        public function get labelFunction() : Function
        {
            return _labelFunction;
        }// end function

        override public function set selectedIndex(param1:int) : void
        {
            super.selectedIndex = param1;
            if (param1 >= 0)
            {
                selectionChanged = true;
            }
            implicitSelectedIndex = false;
            invalidateDisplayList();
            if (textInput && !textChanged && param1 >= 0)
            {
                textInput.text = selectedLabel;
            }
            else if (textInput && prompt)
            {
                textInput.text = prompt;
            }
            return;
        }// end function

        private function dispatchChangeEvent(event:Event, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            if (param2 != param3)
            {
                _loc_4 = event is ListEvent ? (event) : (new ListEvent("change"));
                dispatchEvent(_loc_4);
            }
            return;
        }// end function

        private function displayDropdown(param1:Boolean, param2:Event = null, param3:Boolean = true) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = NaN;
            if (!initialized || param1 == _showingDropdown)
            {
                return;
            }
            if (inTween)
            {
                tween.endTween();
            }
            var _loc_8:* = new Point(0, unscaledHeight);
            _loc_8 = localToGlobal(_loc_8);
            var _loc_9:* = systemManager.topLevelSystemManager;
            var _loc_10:* = _loc_9.getSandboxRoot();
            if (_loc_9 != _loc_10)
            {
                _loc_12 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                _loc_10.dispatchEvent(_loc_12);
                _loc_11 = Rectangle(_loc_12.value);
            }
            else
            {
                _loc_11 = _loc_9.getVisibleApplicationRect();
            }
            if (param1)
            {
                _selectedIndexOnDropdown = selectedIndex;
                getDropdown();
                _dropdown.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE, dropdown_mouseOutsideHandler);
                _dropdown.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE, dropdown_mouseOutsideHandler);
                if (_dropdown.parent == null)
                {
                    PopUpManager.addPopUp(_dropdown, this);
                }
                else
                {
                    PopUpManager.bringToFront(_dropdown);
                }
                if (_loc_8.y + _dropdown.height > _loc_11.bottom && _loc_8.y > _loc_11.top + _dropdown.height)
                {
                    _loc_8.y = _loc_8.y - (unscaledHeight + _dropdown.height);
                    _loc_4 = -_dropdown.height;
                    tweenUp = true;
                }
                else
                {
                    _loc_4 = _dropdown.height;
                    tweenUp = false;
                }
                _loc_8 = _dropdown.parent.globalToLocal(_loc_8);
                _loc_13 = _dropdown.selectedIndex;
                if (_loc_13 == -1)
                {
                    _loc_13 = 0;
                }
                _loc_14 = _dropdown.verticalScrollPosition;
                _loc_14 = _loc_13 - 1;
                _loc_14 = Math.min(Math.max(_loc_14, 0), _dropdown.maxVerticalScrollPosition);
                _dropdown.verticalScrollPosition = _loc_14;
                if (_dropdown.x != _loc_8.x || _dropdown.y != _loc_8.y)
                {
                    _dropdown.move(_loc_8.x, _loc_8.y);
                }
                _dropdown.scrollRect = new Rectangle(0, _loc_4, _dropdown.width, _dropdown.height);
                if (!_dropdown.visible)
                {
                    _dropdown.visible = true;
                }
                bRemoveDropdown = false;
                _showingDropdown = param1;
                _loc_6 = getStyle("openDuration");
                _loc_5 = 0;
                _loc_7 = getStyle("openEasingFunction") as Function;
            }
            else if (_dropdown)
            {
                _loc_5 = _loc_8.y + _dropdown.height > _loc_11.bottom || tweenUp ? (-_dropdown.height) : (_dropdown.height);
                _showingDropdown = param1;
                _loc_4 = 0;
                _loc_6 = getStyle("closeDuration");
                _loc_7 = getStyle("closeEasingFunction") as Function;
                _dropdown.resetDragScrolling();
            }
            inTween = true;
            UIComponentGlobals.layoutManager.validateNow();
            UIComponent.suspendBackgroundProcessing();
            if (_dropdown)
            {
                _dropdown.enabled = false;
            }
            _loc_6 = Math.max(1, _loc_6);
            if (!param3)
            {
                _loc_6 = 1;
            }
            tween = new Tween(this, _loc_4, _loc_5, _loc_6);
            if (_loc_7 != null && tween)
            {
                tween.easingFunction = _loc_7;
            }
            triggerEvent = param2;
            return;
        }// end function

        public function get itemRenderer() : IFactory
        {
            return _itemRenderer;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            super.updateDisplayList(param1, param2);
            if (_dropdown && !inTween)
            {
                if (!_showingDropdown)
                {
                    destroyDropdown();
                }
            }
            else if (_showingDropdown)
            {
                bRemoveDropdown = false;
            }
            var _loc_3:* = preferredDropdownWidth;
            if (isNaN(_loc_3))
            {
                var _loc_4:* = param1;
                _dropdownWidth = param1;
                _loc_3 = _loc_4;
            }
            if (labelFieldChanged)
            {
                if (_dropdown)
                {
                    _dropdown.labelField = _labelField;
                }
                selectionChanged = true;
                if (!explicitText)
                {
                    textInput.text = selectedLabel;
                }
                labelFieldChanged = false;
            }
            if (labelFunctionChanged)
            {
                selectionChanged = true;
                if (!explicitText)
                {
                    textInput.text = selectedLabel;
                }
                labelFunctionChanged = false;
            }
            if (selectionChanged)
            {
                if (!textChanged)
                {
                    if (selectedIndex == -1 && prompt)
                    {
                        textInput.text = prompt;
                    }
                    else if (!explicitText)
                    {
                        textInput.text = selectedLabel;
                    }
                }
                textInput.invalidateDisplayList();
                textInput.validateNow();
                if (editable)
                {
                    textInput.getTextField().setSelection(0, textInput.text.length);
                    textInput.getTextField().scrollH = 0;
                }
                if (_dropdown)
                {
                    _dropdown.selectedIndex = selectedIndex;
                }
                selectionChanged = false;
            }
            if (_dropdown && _dropdown.rowCount != rowCount)
            {
                _dropdown.rowCount = rowCount;
            }
            return;
        }// end function

        public function close(event:Event = null) : void
        {
            if (_showingDropdown)
            {
                if (_dropdown && selectedIndex != _dropdown.selectedIndex)
                {
                    selectedIndex = _dropdown.selectedIndex;
                }
                displayDropdown(false, event);
                dispatchChangeEvent(new Event("dummy"), _selectedIndexOnDropdown, selectedIndex);
            }
            return;
        }// end function

        public function set itemRenderer(param1:IFactory) : void
        {
            _itemRenderer = param1;
            if (_dropdown)
            {
                _dropdown.itemRenderer = param1;
            }
            invalidateSize();
            invalidateDisplayList();
            dispatchEvent(new Event("itemRendererChanged"));
            return;
        }// end function

        override public function set showInAutomationHierarchy(param1:Boolean) : void
        {
            return;
        }// end function

    }
}
