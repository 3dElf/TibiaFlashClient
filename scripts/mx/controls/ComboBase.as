package mx.controls
{
    import flash.display.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import mx.styles.*;
    import mx.utils.*;

    public class ComboBase extends UIComponent implements IIMESupport, IFocusManagerComponent
    {
        private var _enabled:Boolean = false;
        var useFullDropdownSkin:Boolean = false;
        var selectedItemChanged:Boolean = false;
        var selectionChanged:Boolean = false;
        var downArrowButton:Button;
        private var _restrict:String;
        protected var collection:ICollectionView;
        private var _text:String = "";
        var border:IFlexDisplayObject;
        private var _selectedItem:Object;
        var editableChanged:Boolean = true;
        private var enabledChanged:Boolean = false;
        private var selectedUID:String;
        var selectedIndexChanged:Boolean = false;
        var oldBorderStyle:String;
        protected var textInput:TextInput;
        private var _editable:Boolean = false;
        var collectionIterator:IViewCursor;
        var textChanged:Boolean;
        private var _imeMode:String = null;
        protected var iterator:IViewCursor;
        var wrapDownArrowButton:Boolean = true;
        private var _selectedIndex:int = -1;
        static var createAccessibilityImplementation:Function;
        static const VERSION:String = "3.6.0.21751";
        private static var _textInputStyleFilters:Object = {backgroundAlpha:"backgroundAlpha", backgroundColor:"backgroundColor", backgroundImage:"backgroundImage", backgroundDisabledColor:"backgroundDisabledColor", backgroundSize:"backgroundSize", borderAlpha:"borderAlpha", borderColor:"borderColor", borderSides:"borderSides", borderSkin:"borderSkin", borderStyle:"borderStyle", borderThickness:"borderThickness", dropShadowColor:"dropShadowColor", dropShadowEnabled:"dropShadowEnabled", embedFonts:"embedFonts", focusAlpha:"focusAlpha", focusBlendMode:"focusBlendMode", focusRoundedCorners:"focusRoundedCorners", focusThickness:"focusThickness", leading:"leading", paddingLeft:"paddingLeft", paddingRight:"paddingRight", shadowDirection:"shadowDirection", shadowDistance:"shadowDistance", textDecoration:"textDecoration"};

        public function ComboBase()
        {
            tabEnabled = true;
            return;
        }// end function

        protected function collectionChangeHandler(event:Event) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = NaN;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (event is CollectionEvent)
            {
                _loc_2 = false;
                _loc_5 = CollectionEvent(event);
                if (_loc_5.kind == CollectionEventKind.ADD)
                {
                    if (selectedIndex >= _loc_5.location)
                    {
                        var _loc_9:* = _selectedIndex + 1;
                        _selectedIndex = _loc_9;
                    }
                }
                if (_loc_5.kind == CollectionEventKind.REMOVE)
                {
                    _loc_6 = 0;
                    while (_loc_6 < _loc_5.items.length)
                    {
                        
                        _loc_7 = itemToUID(_loc_5.items[_loc_6]);
                        if (selectedUID == _loc_7)
                        {
                            selectionChanged = true;
                        }
                        _loc_6++;
                    }
                    if (selectionChanged)
                    {
                        if (_selectedIndex >= collection.length)
                        {
                            _selectedIndex = collection.length - 1;
                        }
                        selectedIndexChanged = true;
                        _loc_2 = true;
                        invalidateDisplayList();
                    }
                    else if (selectedIndex >= _loc_5.location)
                    {
                        var _loc_9:* = _selectedIndex - 1;
                        _selectedIndex = _loc_9;
                        selectedIndexChanged = true;
                        _loc_2 = true;
                        invalidateDisplayList();
                    }
                }
                if (_loc_5.kind == CollectionEventKind.REFRESH)
                {
                    selectedItemChanged = true;
                    _loc_2 = true;
                }
                invalidateDisplayList();
                if (_loc_2)
                {
                    dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
                }
            }
            return;
        }// end function

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            _enabled = param1;
            enabledChanged = true;
            invalidateProperties();
            return;
        }// end function

        public function get imeMode() : String
        {
            return _imeMode;
        }// end function

        override protected function focusOutHandler(event:FocusEvent) : void
        {
            super.focusOutHandler(event);
            var _loc_2:* = focusManager;
            if (_loc_2)
            {
                _loc_2.defaultButtonEnabled = true;
            }
            if (_editable)
            {
                dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            }
            return;
        }// end function

        override public function get baselinePosition() : Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                return textInput.y + textInput.baselinePosition;
            }
            if (!validateBaselinePosition())
            {
                return NaN;
            }
            return textInput.y + textInput.baselinePosition;
        }// end function

        public function set imeMode(param1:String) : void
        {
            _imeMode = param1;
            if (textInput)
            {
                textInput.imeMode = _imeMode;
            }
            return;
        }// end function

        protected function itemToUID(param1:Object) : String
        {
            if (!param1)
            {
                return "null";
            }
            return UIDUtil.getUID(param1);
        }// end function

        protected function downArrowButton_buttonDownHandler(event:FlexEvent) : void
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.createChildren();
            if (!border)
            {
                _loc_1 = getStyle("borderSkin");
                if (_loc_1)
                {
                    border = new _loc_1;
                    if (border is IFocusManagerComponent)
                    {
                        IFocusManagerComponent(border).focusEnabled = false;
                    }
                    if (border is ISimpleStyleClient)
                    {
                        ISimpleStyleClient(border).styleName = this;
                    }
                    addChild(DisplayObject(border));
                }
            }
            if (!downArrowButton)
            {
                downArrowButton = new Button();
                downArrowButton.styleName = new StyleProxy(this, arrowButtonStyleFilters);
                downArrowButton.focusEnabled = false;
                addChild(downArrowButton);
                downArrowButton.addEventListener(FlexEvent.BUTTON_DOWN, downArrowButton_buttonDownHandler);
            }
            if (!textInput)
            {
                _loc_2 = getStyle("textInputStyleName");
                if (!_loc_2)
                {
                    _loc_2 = new StyleProxy(this, textInputStyleFilters);
                }
                textInput = new TextInput();
                textInput.editable = _editable;
                editableChanged = true;
                textInput.restrict = "^\x1b";
                textInput.focusEnabled = false;
                textInput.imeMode = _imeMode;
                textInput.styleName = _loc_2;
                textInput.addEventListener(Event.CHANGE, textInput_changeHandler);
                textInput.addEventListener(FlexEvent.ENTER, textInput_enterHandler);
                textInput.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
                textInput.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
                textInput.addEventListener(FlexEvent.VALUE_COMMIT, textInput_valueCommitHandler);
                addChild(textInput);
                textInput.move(0, 0);
                textInput.parentDrawsFocus = true;
            }
            return;
        }// end function

        public function set selectedItem(param1:Object) : void
        {
            setSelectedItem(param1);
            return;
        }// end function

        override protected function initializeAccessibility() : void
        {
            if (ComboBase.createAccessibilityImplementation != null)
            {
                ComboBase.createAccessibilityImplementation(this);
            }
            return;
        }// end function

        private function textInput_enterHandler(event:FlexEvent) : void
        {
            dispatchEvent(event);
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            return;
        }// end function

        protected function calculatePreferredSizeFromData(param1:int) : Object
        {
            return null;
        }// end function

        override public function setFocus() : void
        {
            if (textInput && _editable)
            {
                textInput.setFocus();
            }
            else
            {
                super.setFocus();
            }
            return;
        }// end function

        private function textInput_valueCommitHandler(event:FlexEvent) : void
        {
            _text = textInput.text;
            dispatchEvent(event);
            return;
        }// end function

        public function get text() : String
        {
            return _text;
        }// end function

        public function get dataProvider() : Object
        {
            return collection;
        }// end function

        protected function get arrowButtonStyleFilters() : Object
        {
            return null;
        }// end function

        public function set editable(param1:Boolean) : void
        {
            _editable = param1;
            editableChanged = true;
            invalidateProperties();
            dispatchEvent(new Event("editableChanged"));
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            if (downArrowButton)
            {
                downArrowButton.styleChanged(param1);
            }
            if (textInput)
            {
                textInput.styleChanged(param1);
            }
            if (border && border is ISimpleStyleClient)
            {
                ISimpleStyleClient(border).styleChanged(param1);
            }
            super.styleChanged(param1);
            return;
        }// end function

        public function get restrict() : String
        {
            return _restrict;
        }// end function

        public function get selectedItem() : Object
        {
            return _selectedItem;
        }// end function

        function get ComboDownArrowButton() : Button
        {
            return downArrowButton;
        }// end function

        private function setSelectedItem(param1:Object, param2:Boolean = true) : void
        {
            if (!collection || collection.length == 0)
            {
                _selectedItem = param1;
                selectedItemChanged = true;
                invalidateDisplayList();
                return;
            }
            var _loc_3:* = false;
            var _loc_4:* = collection.createCursor();
            var _loc_5:* = 0;
            do
            {
                
                if (param1 == _loc_4.current)
                {
                    _selectedIndex = _loc_5;
                    _selectedItem = param1;
                    selectedUID = itemToUID(param1);
                    selectionChanged = true;
                    _loc_3 = true;
                    break;
                }
                _loc_5++;
            }while (_loc_4.moveNext())
            if (!_loc_3)
            {
                selectedIndex = -1;
                _selectedItem = null;
                selectedUID = null;
            }
            invalidateDisplayList();
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            super.commitProperties();
            textInput.restrict = _restrict;
            if (textChanged)
            {
                textInput.text = _text;
                textChanged = false;
            }
            if (enabledChanged)
            {
                textInput.enabled = _enabled;
                editableChanged = true;
                downArrowButton.enabled = _enabled;
                enabledChanged = false;
            }
            if (editableChanged)
            {
                editableChanged = false;
                _loc_1 = _editable;
                if (wrapDownArrowButton == false)
                {
                    if (_loc_1)
                    {
                        if (oldBorderStyle)
                        {
                            setStyle("borderStyle", oldBorderStyle);
                        }
                    }
                    else
                    {
                        oldBorderStyle = getStyle("borderStyle");
                        setStyle("borderStyle", "comboNonEdit");
                    }
                }
                if (useFullDropdownSkin)
                {
                    downArrowButton.upSkinName = _loc_1 ? ("editableUpSkin") : ("upSkin");
                    downArrowButton.overSkinName = _loc_1 ? ("editableOverSkin") : ("overSkin");
                    downArrowButton.downSkinName = _loc_1 ? ("editableDownSkin") : ("downSkin");
                    downArrowButton.disabledSkinName = _loc_1 ? ("editableDisabledSkin") : ("disabledSkin");
                    downArrowButton.changeSkins();
                    downArrowButton.invalidateDisplayList();
                }
                if (textInput)
                {
                    textInput.editable = _loc_1;
                    textInput.selectable = _loc_1;
                    if (_loc_1)
                    {
                        textInput.removeEventListener(MouseEvent.MOUSE_DOWN, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.MOUSE_UP, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.ROLL_OVER, textInput_mouseEventHandler);
                        textInput.removeEventListener(MouseEvent.ROLL_OUT, textInput_mouseEventHandler);
                        textInput.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    }
                    else
                    {
                        textInput.addEventListener(MouseEvent.MOUSE_DOWN, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.MOUSE_UP, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.ROLL_OVER, textInput_mouseEventHandler);
                        textInput.addEventListener(MouseEvent.ROLL_OUT, textInput_mouseEventHandler);
                        textInput.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
                    }
                }
            }
            return;
        }// end function

        protected function get textInputStyleFilters() : Object
        {
            return _textInputStyleFilters;
        }// end function

        public function set text(param1:String) : void
        {
            _text = param1;
            textChanged = true;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            return;
        }// end function

        override protected function isOurFocus(param1:DisplayObject) : Boolean
        {
            return param1 == textInput || super.isOurFocus(param1);
        }// end function

        public function get editable() : Boolean
        {
            return _editable;
        }// end function

        override protected function measure() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            super.measure();
            var _loc_1:* = getStyle("arrowButtonWidth");
            _loc_2 = downArrowButton.getExplicitOrMeasuredHeight();
            if (collection && collection.length > 0)
            {
                _loc_3 = calculatePreferredSizeFromData(collection.length);
                _loc_4 = borderMetrics;
                _loc_5 = _loc_3.width + _loc_4.left + _loc_4.right + 8;
                _loc_6 = _loc_3.height + _loc_4.top + _loc_4.bottom + UITextField.TEXT_HEIGHT_PADDING;
                var _loc_8:* = _loc_5 + _loc_1;
                measuredWidth = _loc_5 + _loc_1;
                measuredMinWidth = _loc_8;
                var _loc_8:* = Math.max(_loc_6, _loc_2);
                measuredHeight = Math.max(_loc_6, _loc_2);
                measuredMinHeight = _loc_8;
            }
            else
            {
                measuredMinWidth = DEFAULT_MEASURED_MIN_WIDTH;
                measuredWidth = DEFAULT_MEASURED_WIDTH;
                measuredMinHeight = DEFAULT_MEASURED_MIN_HEIGHT;
                measuredHeight = DEFAULT_MEASURED_HEIGHT;
            }
            if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
            {
                _loc_7 = getStyle("paddingTop") + getStyle("paddingBottom");
                measuredMinHeight = measuredMinHeight + _loc_7;
                measuredHeight = measuredHeight + _loc_7;
            }
            return;
        }// end function

        protected function textInput_changeHandler(event:Event) : void
        {
            _text = textInput.text;
            if (_selectedIndex != -1)
            {
                _selectedIndex = -1;
                _selectedItem = null;
                selectedUID = null;
            }
            return;
        }// end function

        function getTextInput() : TextInput
        {
            return textInput;
        }// end function

        override protected function focusInHandler(event:FocusEvent) : void
        {
            super.focusInHandler(event);
            return;
        }// end function

        public function get value() : Object
        {
            if (_editable)
            {
                return text;
            }
            var _loc_1:* = selectedItem;
            if (_loc_1 == null || typeof(_loc_1) != "object")
            {
                return _loc_1;
            }
            return _loc_1.data != null ? (_loc_1.data) : (_loc_1.label);
        }// end function

        private function textInput_mouseEventHandler(event:Event) : void
        {
            downArrowButton.dispatchEvent(event);
            return;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _selectedIndex = param1;
            if (param1 == -1)
            {
                _selectedItem = null;
                selectedUID = null;
            }
            if (!collection || collection.length == 0)
            {
                selectedIndexChanged = true;
            }
            else if (param1 != -1)
            {
                param1 = Math.min(param1, (collection.length - 1));
                _loc_2 = iterator.bookmark;
                _loc_3 = param1;
                iterator.seek(CursorBookmark.FIRST, _loc_3);
                _loc_4 = iterator.current;
                _loc_5 = itemToUID(_loc_4);
                iterator.seek(_loc_2, 0);
                _selectedIndex = param1;
                _selectedItem = _loc_4;
                selectedUID = _loc_5;
            }
            selectionChanged = true;
            invalidateDisplayList();
            dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
            return;
        }// end function

        public function set dataProvider(param1:Object) : void
        {
            var _loc_3:* = null;
            if (param1 is Array)
            {
                collection = new ArrayCollection(param1 as Array);
            }
            else if (param1 is ICollectionView)
            {
                collection = ICollectionView(param1);
            }
            else if (param1 is IList)
            {
                collection = new ListCollectionView(IList(param1));
            }
            else if (param1 is XMLList)
            {
                collection = new XMLListCollection(param1 as XMLList);
            }
            else
            {
                _loc_3 = [param1];
                collection = new ArrayCollection(_loc_3);
            }
            iterator = collection.createCursor();
            collectionIterator = collection.createCursor();
            collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler, false, 0, true);
            var _loc_2:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_2.kind = CollectionEventKind.RESET;
            collectionChangeHandler(_loc_2);
            dispatchEvent(_loc_2);
            invalidateSize();
            invalidateDisplayList();
            return;
        }// end function

        protected function get borderMetrics() : EdgeMetrics
        {
            if (border && border is IRectangularBorder)
            {
                return IRectangularBorder(border).mx.core:IBorder::borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

        public function set restrict(param1:String) : void
        {
            _restrict = param1;
            invalidateProperties();
            dispatchEvent(new Event("restrictChanged"));
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            super.updateDisplayList(param1, param2);
            var _loc_3:* = param1;
            var _loc_4:* = param2;
            var _loc_5:* = getStyle("arrowButtonWidth");
            var _loc_6:* = textInput.getExplicitOrMeasuredHeight();
            if (isNaN(_loc_5))
            {
                _loc_5 = 0;
            }
            if (wrapDownArrowButton)
            {
                _loc_7 = borderMetrics;
                _loc_8 = _loc_4 - _loc_7.top - _loc_7.bottom;
                downArrowButton.setActualSize(_loc_8, _loc_8);
                downArrowButton.move(_loc_3 - _loc_5 - _loc_7.right, _loc_7.top);
                border.setActualSize(_loc_3, _loc_4);
                textInput.setActualSize(_loc_3 - _loc_5, _loc_6);
            }
            else if (!_editable && useFullDropdownSkin)
            {
                _loc_9 = getStyle("paddingTop");
                _loc_10 = getStyle("paddingBottom");
                downArrowButton.move(0, 0);
                border.setActualSize(_loc_3, _loc_4);
                textInput.setActualSize(_loc_3 - _loc_5, _loc_6);
                textInput.border.visible = false;
                if (FlexVersion.compatibilityVersion >= FlexVersion.VERSION_3_0)
                {
                    textInput.move(textInput.x, (_loc_4 - _loc_6 - _loc_9 - _loc_10) / 2 + _loc_9);
                }
                downArrowButton.setActualSize(param1, param2);
            }
            else
            {
                downArrowButton.move(_loc_3 - _loc_5, 0);
                border.setActualSize(_loc_3 - _loc_5, _loc_4);
                textInput.setActualSize(_loc_3 - _loc_5, _loc_4);
                downArrowButton.setActualSize(_loc_5, param2);
                textInput.border.visible = true;
            }
            if (selectedItemChanged)
            {
                selectedItem = selectedItem;
                selectedItemChanged = false;
                selectedIndexChanged = false;
            }
            if (selectedIndexChanged)
            {
                selectedIndex = selectedIndex;
                selectedIndexChanged = false;
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return _selectedIndex;
        }// end function

    }
}
