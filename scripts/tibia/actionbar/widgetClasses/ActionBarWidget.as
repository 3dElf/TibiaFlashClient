package tibia.actionbar.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.graphics.*;
    import mx.managers.*;
    import mx.states.*;
    import shared.controls.*;
    import tibia.actionbar.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.help.*;
    import tibia.input.*;
    import tibia.input.gameaction.*;
    import tibia.input.mapping.*;
    import tibia.magic.*;
    import tibia.network.*;
    import tibia.options.*;

    public class ActionBarWidget extends Container
    {
        private var m_UncommittedScrollPosition:Boolean = false;
        private var m_UncommittedMaxScrollPosition:Boolean = false;
        protected var m_ActionBar:ActionBar = null;
        protected var m_Direction:int = 0;
        protected var m_MaxChildHeight:Number = 0;
        protected var m_MaxChildWidth:Number = 0;
        protected var m_MaxScrollPosition:int = 29;
        protected var m_Options:OptionsStorage = null;
        protected var m_ScrollPosition:int = 0;
        private var m_UncommittedCurrentState:Boolean = false;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_UIScrollUpButton:Button = null;
        private var m_UncommittedLocation:Boolean = false;
        protected var m_Location:int = 0;
        private var m_UncommittedContainerStorage:Boolean = false;
        protected var m_UIToggleButton:Button = null;
        private var m_UncommittedDirection:Boolean = false;
        protected var m_ContainerStorage:ContainerStorage = null;
        protected var m_UIScrollDownButton:Button = null;
        private var m_UncommittedActionBar:Boolean = false;
        public static const BUNDLE:String = "ActionBarWidget";
        static const DRAG_TYPE_CHANNEL:String = "channel";
        public static const DIRECTION_HORIZONTAL:int = 0;
        static const DRAG_TYPE_STATUSWIDGET:String = "statusWidget";
        public static const DIRECTION_VERTICAL:int = 1;
        static const DRAG_TYPE_ACTION:String = "action";
        public static const STATE_OPEN:String = "open";
        static const DRAG_TYPE_OBJECT:String = "object";
        static const DRAG_OPACITY:Number = 0.75;
        public static const STATE_COLLAPSED:String = "collapsed";
        static const DRAG_TYPE_SPELL:String = "spell";
        static const DRAG_TYPE_WIDGETBASE:String = "widgetBase";
        private static const TOGGLE_BUTTON_FILTER_MAP:Object = {toggleBackgroundImage:"borderBackgroundImage", toggleDisabledImage:"borderDefaultDisabledImage", toggleOutImage:"borderDefaultOutImage", toggleOverImage:"borderDefaultOverImage", toggleStyle:"borderStyle", toggleSkin:"skin"};

        public function ActionBarWidget(param1:int = 0)
        {
            this.m_Direction = param1;
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            var _loc_2:* = new State();
            _loc_2.name = STATE_COLLAPSED;
            states.push(_loc_2);
            _loc_2 = new State();
            _loc_2.name = STATE_OPEN;
            states.push(_loc_2);
            this.currentState = STATE_COLLAPSED;
            addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            return;
        }// end function

        public function set actionBar(param1:ActionBar) : void
        {
            var _loc_2:* = this.actionBar;
            if (_loc_2 !== param1)
            {
                this._198267389actionBar = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "actionBar", _loc_2, param1));
            }
            return;
        }// end function

        private function updateActions() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = Math.min(ActionBar.NUM_ACTIONS, numChildren);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = getChildAt(_loc_2) as IActionButton;
                if (_loc_3 != null)
                {
                    _loc_3.action = this.m_ActionBar != null ? (this.m_ActionBar.getAction(_loc_2)) : (null);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function onButtonActionDragStop(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            if (_loc_3 != null)
            {
                this.updateButtonDragListeners(_loc_2, false);
            }
            return;
        }// end function

        private function onButtonMouseDown(event:MouseEvent) : void
        {
            if (event is MouseRepeatEvent)
            {
                MouseRepeatEvent(event).repeatEnabled = true;
                MouseRepeatEvent(event).repeatInterval = 200;
            }
            var _loc_2:* = event.currentTarget as IActionButton;
            if ((this.options == null || !this.options.generalActionBarsLock) && _loc_2 != null)
            {
                this.updateButtonDragListeners(_loc_2, _loc_2.action != null);
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            layoutChrome(param1, param2);
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (this.m_UIScrollUpButton != null)
            {
                this.m_UIScrollUpButton.visible = false;
            }
            if (this.m_UIScrollDownButton != null)
            {
                this.m_UIScrollDownButton.visible = false;
            }
            _loc_7 = 0;
            _loc_8 = numChildren;
            while (_loc_7 < _loc_8)
            {
                
                getChildAt(_loc_7).visible = false;
                _loc_7++;
            }
            _loc_5 = this.m_UIToggleButton.getExplicitOrMeasuredHeight();
            _loc_6 = this.m_UIToggleButton.getExplicitOrMeasuredWidth();
            if (this.m_Direction == DIRECTION_HORIZONTAL)
            {
                _loc_3 = (param1 - _loc_6) / 2;
                if (this.m_Location == ActionBarSet.LOCATION_BOTTOM)
                {
                    _loc_4 = param2 - _loc_5;
                }
                else
                {
                    _loc_4 = 0;
                }
            }
            else
            {
                _loc_4 = (param2 - _loc_5) / 2;
                if (this.m_Location == ActionBarSet.LOCATION_RIGHT)
                {
                    _loc_3 = param1 - _loc_6;
                }
                else
                {
                    _loc_3 = 0;
                }
            }
            this.m_UIToggleButton.visible = this.options != null && !this.options.generalActionBarsLock;
            this.m_UIToggleButton.move(_loc_3, _loc_4);
            this.m_UIToggleButton.setActualSize(_loc_6, _loc_5);
            rawChildren.setChildIndex(this.m_UIToggleButton, (rawChildren.numChildren - 1));
            if (currentState != STATE_OPEN)
            {
                return;
            }
            var _loc_9:* = this.m_Direction == DIRECTION_HORIZONTAL ? (getStyle("horizontalGap")) : (getStyle("verticalGap"));
            var _loc_10:* = 0;
            var _loc_11:* = _loc_9;
            var _loc_12:* = -_loc_9;
            if (this.m_Direction == DIRECTION_HORIZONTAL)
            {
                _loc_11 = _loc_11 + (param1 - viewMetricsAndPadding.left - viewMetricsAndPadding.right);
            }
            else
            {
                _loc_11 = _loc_11 + (param2 - viewMetricsAndPadding.top - viewMetricsAndPadding.bottom);
            }
            _loc_10 = this.m_Direction == DIRECTION_HORIZONTAL ? (this.m_UIScrollUpButton.getExplicitOrMeasuredWidth()) : (this.m_UIScrollUpButton.getExplicitOrMeasuredHeight());
            _loc_11 = _loc_11 - (_loc_10 + _loc_9);
            _loc_12 = _loc_12 + (_loc_10 + _loc_9);
            _loc_10 = this.m_Direction == DIRECTION_HORIZONTAL ? (this.m_UIScrollDownButton.getExplicitOrMeasuredWidth()) : (this.m_UIScrollDownButton.getExplicitOrMeasuredHeight());
            _loc_11 = _loc_11 - (_loc_10 + _loc_9);
            _loc_12 = _loc_12 + (_loc_10 + _loc_9);
            var _loc_13:* = null;
            var _loc_14:* = new Vector.<Point>;
            var _loc_15:* = 0;
            _loc_7 = 0;
            _loc_8 = numChildren;
            while (_loc_7 < _loc_8)
            {
                
                var _loc_17:* = getChildAt(_loc_7) as IUIComponent;
                _loc_13 = getChildAt(_loc_7) as IUIComponent;
                if (_loc_17 != null)
                {
                    _loc_5 = _loc_13.getExplicitOrMeasuredHeight();
                    _loc_6 = _loc_13.getExplicitOrMeasuredWidth();
                    _loc_14.push(new Point(_loc_6, _loc_5));
                    _loc_10 = this.m_Direction == DIRECTION_HORIZONTAL ? (_loc_6) : (_loc_5);
                    if (_loc_7 >= this.m_ScrollPosition && _loc_11 >= _loc_10)
                    {
                        _loc_15++;
                        _loc_11 = _loc_11 - (_loc_10 + _loc_9);
                        _loc_12 = _loc_12 + (_loc_10 + _loc_9);
                    }
                }
                _loc_7++;
            }
            while (_loc_11 > 0 && this.m_ScrollPosition > 0)
            {
                
                _loc_10 = this.m_Direction == DIRECTION_HORIZONTAL ? (_loc_14[(this.m_ScrollPosition - 1)].x) : (_loc_14[(this.m_ScrollPosition - 1)].y);
                if (_loc_11 < _loc_10)
                {
                    break;
                }
                var _loc_17:* = this;
                var _loc_18:* = this.m_ScrollPosition - 1;
                _loc_17.m_ScrollPosition = _loc_18;
                _loc_15++;
                _loc_11 = _loc_11 - (_loc_10 + _loc_9);
                _loc_12 = _loc_12 + (_loc_10 + _loc_9);
            }
            this.maxScrollPosition = ActionBar.NUM_ACTIONS - _loc_15;
            var _loc_16:* = Math.floor(_loc_11 / 2);
            _loc_6 = this.m_UIScrollDownButton.getExplicitOrMeasuredWidth();
            _loc_5 = this.m_UIScrollDownButton.getExplicitOrMeasuredHeight();
            if (this.m_Direction == DIRECTION_HORIZONTAL)
            {
                _loc_4 = viewMetricsAndPadding.top + (this.m_MaxChildHeight - _loc_5) / 2;
                _loc_3 = viewMetricsAndPadding.left + _loc_16;
                _loc_16 = _loc_16 + (getStyle("paddingLeft") + _loc_6 + _loc_9);
            }
            else
            {
                _loc_4 = viewMetricsAndPadding.top + _loc_16;
                _loc_3 = viewMetricsAndPadding.left + (this.m_MaxChildWidth - _loc_6) / 2;
                _loc_16 = _loc_16 + (getStyle("paddingTop") + _loc_5 + _loc_9);
            }
            this.m_UIScrollDownButton.enabled = this.m_ScrollPosition > 0;
            this.m_UIScrollDownButton.visible = true;
            this.m_UIScrollDownButton.move(_loc_3, _loc_4);
            this.m_UIScrollDownButton.setActualSize(_loc_6, _loc_5);
            rawChildren.setChildIndex(this.m_UIScrollDownButton, rawChildren.numChildren - 2);
            _loc_4 = getStyle("paddingTop");
            _loc_3 = getStyle("paddingLeft");
            _loc_7 = 0;
            while (_loc_7 < _loc_15)
            {
                
                var _loc_17:* = getChildAt(this.m_ScrollPosition + _loc_7) as IUIComponent;
                _loc_13 = getChildAt(this.m_ScrollPosition + _loc_7) as IUIComponent;
                if (_loc_17 != null)
                {
                    _loc_5 = _loc_14[this.m_ScrollPosition + _loc_7].y;
                    _loc_6 = _loc_14[this.m_ScrollPosition + _loc_7].x;
                    if (this.m_Direction == DIRECTION_HORIZONTAL)
                    {
                        _loc_3 = _loc_16;
                        _loc_16 = _loc_16 + (_loc_6 + _loc_9);
                    }
                    else
                    {
                        _loc_4 = _loc_16;
                        _loc_16 = _loc_16 + (_loc_5 + _loc_9);
                    }
                    _loc_13.move(_loc_3, _loc_4);
                    _loc_13.setActualSize(_loc_6, _loc_5);
                    _loc_13.visible = true;
                }
                _loc_7++;
            }
            _loc_5 = this.m_UIScrollUpButton.getExplicitOrMeasuredHeight();
            _loc_6 = this.m_UIScrollUpButton.getExplicitOrMeasuredWidth();
            if (this.m_Direction == DIRECTION_HORIZONTAL)
            {
                _loc_4 = viewMetricsAndPadding.top + (this.m_MaxChildHeight - _loc_5) / 2;
                _loc_3 = this.m_UIScrollDownButton.x + _loc_12 - _loc_6;
            }
            else
            {
                _loc_4 = this.m_UIScrollDownButton.y + _loc_12 - _loc_5;
                _loc_3 = viewMetricsAndPadding.left + (this.m_MaxChildWidth - _loc_6) / 2;
            }
            this.m_UIScrollUpButton.enabled = this.m_ScrollPosition + _loc_15 < ActionBar.NUM_ACTIONS;
            this.m_UIScrollUpButton.visible = true;
            this.m_UIScrollUpButton.move(_loc_3, _loc_4);
            this.m_UIScrollUpButton.setActualSize(_loc_6, _loc_5);
            rawChildren.setChildIndex(this.m_UIScrollUpButton, rawChildren.numChildren - 3);
            return;
        }// end function

        private function updateToggleButton() : void
        {
            if (this.m_UIToggleButton != null)
            {
                this.m_UIToggleButton.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
                rawChildren.removeChild(this.m_UIToggleButton);
            }
            this.m_UIToggleButton = new CustomButton();
            this.m_UIToggleButton.styleName = getStyle("toggleButtonStyle");
            this.m_UIToggleButton.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            rawChildren.addChild(this.m_UIToggleButton);
            return;
        }// end function

        private function onButtonActionDragEvent(event:DragEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = -1;
            var _loc_16:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            var _loc_16:* = event.dragSource;
            _loc_3 = event.dragSource;
            var _loc_16:* = _loc_3.dataForFormat("dragActionBar") as ActionBar;
            _loc_4 = _loc_3.dataForFormat("dragActionBar") as ActionBar;
            var _loc_16:* = int(_loc_3.dataForFormat("dragActionPosition"));
            _loc_5 = int(_loc_3.dataForFormat("dragActionPosition"));
            if ((this.options == null || !this.options.generalActionBarsLock) && _loc_16 != null && _loc_16 != null && _loc_3.hasFormat("dragType") && _loc_3.dataForFormat("dragType") == DRAG_TYPE_ACTION && _loc_3.hasFormat("dragActionBar") && _loc_16 != null && _loc_3.hasFormat("dragActionPosition") && _loc_16 >= 0 && _loc_5 <= ActionBar.NUM_ACTIONS && this.m_ActionBar != null)
            {
                if (event.type == DragEvent.DRAG_DROP)
                {
                    _loc_6 = _loc_4.getAction(_loc_5);
                    _loc_4.setAction(_loc_5, this.m_ActionBar.getAction(_loc_2.position));
                    this.m_ActionBar.setAction(_loc_2.position, _loc_6);
                    _loc_7 = null;
                    _loc_8 = null;
                    var _loc_16:* = this.options.getMappingSet(this.options.generalInputSetID);
                    _loc_7 = this.options.getMappingSet(this.options.generalInputSetID);
                    var _loc_16:* = this.options.generalInputSetMode == MappingSet.CHAT_MODE_OFF ? (_loc_7.chatModeOff) : (_loc_7.chatModeOn);
                    _loc_8 = this.options.generalInputSetMode == MappingSet.CHAT_MODE_OFF ? (_loc_7.chatModeOff) : (_loc_7.chatModeOn);
                    if (event.shiftKey && this.options != null && _loc_16 != null && _loc_16 != null)
                    {
                        _loc_9 = _loc_4.getTrigger(_loc_5);
                        _loc_10 = _loc_8.getBindingsByAction(_loc_9);
                        _loc_11 = 0;
                        _loc_12 = 0;
                        _loc_11 = _loc_10.length;
                        _loc_12 = 0;
                        while (_loc_12 < _loc_11)
                        {
                            
                            _loc_8.removeItem(_loc_10[_loc_12]);
                            _loc_12++;
                        }
                        _loc_13 = this.m_ActionBar.getTrigger(_loc_2.position);
                        _loc_14 = _loc_8.getBindingsByAction(_loc_13);
                        _loc_11 = _loc_14.length;
                        _loc_12 = 0;
                        while (_loc_12 < _loc_11)
                        {
                            
                            _loc_8.removeItem(_loc_14[_loc_12]);
                            _loc_12++;
                        }
                        while (_loc_10.length < _loc_14.length)
                        {
                            
                            _loc_10.push(new Binding(_loc_9, 0, 0, 0, null, true));
                        }
                        while (_loc_14.length < _loc_10.length)
                        {
                            
                            _loc_14.push(new Binding(_loc_13, 0, 0, 0, null, true));
                        }
                        _loc_11 = _loc_10.length;
                        _loc_12 = 0;
                        while (_loc_12 < _loc_11)
                        {
                            
                            if (!_loc_10[_loc_12].editable || !_loc_14[_loc_12].editable)
                            {
                            }
                            else
                            {
                                _loc_15 = _loc_10[_loc_12].clone();
                                _loc_10[_loc_12].update(_loc_14[_loc_12]);
                                _loc_14[_loc_12].update(_loc_15);
                                if (_loc_10[_loc_12].keyCode != 0)
                                {
                                    _loc_8.addItem(_loc_10[_loc_12]);
                                }
                                if (_loc_14[_loc_12].keyCode != 0)
                                {
                                    _loc_8.addItem(_loc_14[_loc_12]);
                                }
                            }
                            _loc_12++;
                        }
                    }
                }
                else if (event.type == DragEvent.DRAG_ENTER)
                {
                    DragManager.acceptDragDrop(_loc_2);
                }
            }
            return;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.updateActionButtons();
            this.updateScrollButtons();
            this.updateToggleButton();
            return;
        }// end function

        private function set _198267389actionBar(param1:ActionBar) : void
        {
            if (this.m_ActionBar != param1)
            {
                if (this.m_ActionBar != null)
                {
                    this.m_ActionBar.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange);
                }
                this.m_ActionBar = param1;
                if (this.m_ActionBar != null)
                {
                    this.m_ActionBar.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onActionBarChange);
                }
                this.m_UncommittedActionBar = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        private function onUIEffectsCommandEvent(event:UIEffectsRetrieveComponentCommandEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            if (event.type == UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT && event.identifier == ActionBarWidget)
            {
                _loc_2 = event.subIdentifier as AppearanceType;
                if (_loc_2 != null)
                {
                    _loc_3 = Math.min(ActionBar.NUM_ACTIONS, numChildren);
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3)
                    {
                        
                        _loc_5 = getChildAt(_loc_4) as IActionButton;
                        if (_loc_5 != null)
                        {
                            _loc_6 = _loc_5.action;
                            if (_loc_6 != null)
                            {
                                _loc_7 = -1;
                                if (_loc_6 is UseAction)
                                {
                                    _loc_7 = UseAction(_loc_6).type.ID;
                                }
                                else if (_loc_6 is EquipAction)
                                {
                                    _loc_7 = EquipAction(_loc_6).type.ID;
                                }
                                if (_loc_7 == _loc_2.ID)
                                {
                                    event.resultUIComponent = _loc_5 as UIComponent;
                                }
                            }
                        }
                        _loc_4++;
                    }
                }
            }
            return;
        }// end function

        public function get scrollPosition() : int
        {
            return this.m_ScrollPosition;
        }// end function

        private function onButtonClick(event:MouseEvent) : void
        {
            var a_Event:* = event;
            var Btn:IActionButton;
            var _loc_3:* = a_Event.currentTarget as IActionButton;
            Btn = a_Event.currentTarget as IActionButton;
            if (_loc_3 != null && this.m_ActionBar != null)
            {
                switch(a_Event.type)
                {
                    case MouseEvent.RIGHT_CLICK:
                    {
                        new ActionButtonContextMenu(this.m_ActionBar, Btn.position).display(this, a_Event.stageX, a_Event.stageY);
                        break;
                    }
                    case MouseRepeatEvent.REPEAT_MOUSE_DOWN:
                    {
                        this.updateButtonDragListeners(Btn, false);
                    }
                    case MouseEvent.CLICK:
                    {
                        if (Btn.action != null)
                        {
                            try
                            {
                                Btn.action.perform(a_Event.type == MouseRepeatEvent.REPEAT_MOUSE_DOWN);
                            }
                            catch (e)
                            {
                            }
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

        public function get maxScrollPosition() : int
        {
            return this.m_MaxScrollPosition;
        }// end function

        private function updateScrollButtons() : void
        {
            if (this.m_UIScrollUpButton != null)
            {
                this.m_UIScrollUpButton.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
                this.m_UIScrollUpButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.m_UIScrollUpButton.removeEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onMouseClick);
                rawChildren.removeChild(this.m_UIScrollUpButton);
            }
            this.m_UIScrollUpButton = new CustomButton();
            this.m_UIScrollUpButton.styleName = getStyle("scrollUpButtonStyle");
            this.m_UIScrollUpButton.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.m_UIScrollUpButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.m_UIScrollUpButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onMouseClick);
            rawChildren.addChild(this.m_UIScrollUpButton);
            if (this.m_UIScrollDownButton != null)
            {
                this.m_UIScrollDownButton.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
                this.m_UIScrollDownButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.m_UIScrollDownButton.removeEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onMouseClick);
                rawChildren.removeChild(this.m_UIScrollDownButton);
            }
            this.m_UIScrollDownButton = new CustomButton();
            this.m_UIScrollDownButton.styleName = getStyle("scrollDownButtonStyle");
            this.m_UIScrollDownButton.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            this.m_UIScrollDownButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.m_UIScrollDownButton.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onMouseClick);
            rawChildren.addChild(this.m_UIScrollDownButton);
            return;
        }// end function

        private function onActionBarChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "visible")
            {
                this.currentState = this.m_ActionBar.visible ? (STATE_OPEN) : (STATE_COLLAPSED);
            }
            else if (event.property == "action")
            {
                this.updateActions();
                this.updateToolTips();
            }
            return;
        }// end function

        override public function set currentState(param1:String) : void
        {
            if (param1 != STATE_COLLAPSED && param1 != STATE_OPEN)
            {
                param1 = STATE_OPEN;
            }
            if (currentState != param1)
            {
                super.currentState = param1;
                this.m_UncommittedCurrentState = true;
                invalidateDisplayList();
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            if (event.currentTarget == this.m_UIScrollDownButton)
            {
                this.scrollPosition = this.scrollPosition - (event.shiftKey ? (10) : (1));
            }
            else if (event.currentTarget == this.m_UIScrollUpButton)
            {
                this.scrollPosition = this.scrollPosition + (event.shiftKey ? (10) : (1));
            }
            else if (event.currentTarget == this.m_UIToggleButton)
            {
                if (this.m_ActionBar != null)
                {
                    this.m_ActionBar.visible = !this.m_ActionBar.visible;
                }
            }
            return;
        }// end function

        private function onButtonToolTip(event:ToolTipEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            var _loc_4:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            if (_loc_4 != null)
            {
                _loc_3 = new ActionButtonToolTip();
                _loc_3.actionBar = this.actionBar;
                _loc_3.actionButton = _loc_2;
                event.toolTip = _loc_3;
            }
            return;
        }// end function

        public function set maxScrollPosition(param1:int) : void
        {
            param1 = Math.max(0, Math.min(param1, (ActionBar.NUM_ACTIONS - 1)));
            if (this.m_MaxScrollPosition != param1)
            {
                this.m_MaxScrollPosition = param1;
                this.m_UncommittedMaxScrollPosition = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        private function onContainerChange(event:PropertyChangeEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (event.property == "playerInventory")
            {
                _loc_2 = Math.min(ActionBar.NUM_ACTIONS, numChildren);
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_4 = getChildAt(_loc_3) as IActionButton;
                    _loc_5 = _loc_4 != null ? (_loc_4.action) : (null);
                    if (_loc_5 is UseAction || _loc_5 is EquipAction)
                    {
                        _loc_4.invalidateDisplayList();
                    }
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function get containerStorage() : ContainerStorage
        {
            return this.m_ContainerStorage;
        }// end function

        public function set scrollPosition(param1:int) : void
        {
            param1 = Math.max(0, Math.min(param1, this.m_MaxScrollPosition, (ActionBar.NUM_ACTIONS - 1)));
            if (this.m_ScrollPosition != param1)
            {
                this.m_ScrollPosition = param1;
                this.m_UncommittedScrollPosition = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            if (this.m_Options != param1)
            {
                if (this.m_Options != null)
                {
                    this.m_Options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_Options = param1;
                if (this.m_Options != null)
                {
                    this.m_Options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onOptionsChange);
                }
                this.m_UncommittedOptions = true;
                invalidateDisplayList();
                invalidateProperties();
                this.updateActionBar();
            }
            return;
        }// end function

        private function onCreationComplete(event:FlexEvent) : void
        {
            var _loc_2:* = Tibia.s_GetConnection();
            if (_loc_2 != null)
            {
                _loc_2.addEventListener(ConnectionEvent.GAME, this.onConnectionEstablished, false, EventPriority.DEFAULT, true);
            }
            Tibia.s_GetUIEffectsManager().addEventListener(UIEffectsRetrieveComponentCommandEvent.GET_UI_COMPONENT, this.onUIEffectsCommandEvent);
            return;
        }// end function

        private function onConnectionEstablished(event:ConnectionEvent) : void
        {
            this.updateToolTips();
            return;
        }// end function

        override public function styleChanged(param1:String) : void
        {
            switch(param1)
            {
                case "actionButton":
                {
                    this.updateActionButtons();
                    break;
                }
                case "toggleButton":
                {
                    this.updateToggleButton();
                    break;
                }
                case "scrollDownButton":
                case "scrollUpButton":
                {
                    this.updateScrollButtons();
                    break;
                }
                default:
                {
                    super.styleChanged(param1);
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function updateActionButtons() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            _loc_1 = numChildren - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = removeChildAt(_loc_1);
                _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
                _loc_2.removeEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.onButtonClick);
                _loc_2.removeEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onButtonClick);
                _loc_2.removeEventListener(DragEvent.DRAG_DROP, this.onButtonActionDragEvent);
                _loc_2.removeEventListener(DragEvent.DRAG_ENTER, this.onButtonActionDragEvent);
                _loc_2.removeEventListener(DragEvent.DRAG_COMPLETE, this.onButtonActionDragStop);
                _loc_2.removeEventListener(DragEvent.DRAG_DROP, this.onButtonObjectDragEvent);
                _loc_2.removeEventListener(DragEvent.DRAG_ENTER, this.onButtonObjectDragEvent);
                _loc_2.removeEventListener(DragEvent.DRAG_DROP, this.onButtonSpellDragEvent);
                _loc_2.removeEventListener(DragEvent.DRAG_ENTER, this.onButtonSpellDragEvent);
                _loc_2.removeEventListener(ToolTipEvent.TOOL_TIP_CREATE, this.onButtonToolTip);
                _loc_1 = _loc_1 - 1;
            }
            _loc_1 = 0;
            while (_loc_1 < ActionBar.NUM_ACTIONS)
            {
                
                _loc_3 = new ActionButton();
                _loc_3.owner = this;
                _loc_3.position = _loc_1;
                _loc_3.styleName = "actionBarWidget";
                _loc_3.toolTip = " ";
                _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.onButtonMouseDown);
                _loc_3.addEventListener(MouseEvent.CLICK, this.onButtonClick);
                _loc_3.addEventListener(MouseEvent.RIGHT_CLICK, this.onButtonClick);
                _loc_3.addEventListener(MouseRepeatEvent.REPEAT_MOUSE_DOWN, this.onButtonClick);
                _loc_3.addEventListener(DragEvent.DRAG_DROP, this.onButtonActionDragEvent);
                _loc_3.addEventListener(DragEvent.DRAG_ENTER, this.onButtonActionDragEvent);
                _loc_3.addEventListener(DragEvent.DRAG_COMPLETE, this.onButtonActionDragStop);
                _loc_3.addEventListener(DragEvent.DRAG_DROP, this.onButtonObjectDragEvent);
                _loc_3.addEventListener(DragEvent.DRAG_ENTER, this.onButtonObjectDragEvent);
                _loc_3.addEventListener(DragEvent.DRAG_DROP, this.onButtonSpellDragEvent);
                _loc_3.addEventListener(DragEvent.DRAG_ENTER, this.onButtonSpellDragEvent);
                _loc_3.addEventListener(ToolTipEvent.TOOL_TIP_CREATE, this.onButtonToolTip);
                addChild(_loc_3 as DisplayObject);
                _loc_1++;
            }
            this.updateActions();
            return;
        }// end function

        private function onButtonActionDragStart(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = null;
            var _loc_5:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            if ((this.options == null || !this.options.generalActionBarsLock) && _loc_5 != null)
            {
                _loc_3 = new DragSource();
                _loc_3.addData(DRAG_TYPE_ACTION, "dragType");
                _loc_3.addData(this.m_ActionBar, "dragActionBar");
                _loc_3.addData(_loc_2.position, "dragActionPosition");
                _loc_4 = new Image();
                _loc_4.source = new Bitmap(ImageSnapshot.captureBitmapData(_loc_2));
                DragManager.doDrag(_loc_2, _loc_3, event, _loc_4, -event.localX, -event.localY, DRAG_OPACITY);
                this.updateButtonDragListeners(_loc_2, false);
            }
            return;
        }// end function

        private function onButtonObjectDragEvent(event:DragEvent) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_8:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            var _loc_8:* = event.dragSource;
            _loc_3 = event.dragSource;
            var _loc_8:* = _loc_3.dataForFormat("dragObject") as ObjectInstance;
            _loc_4 = _loc_3.dataForFormat("dragObject") as ObjectInstance;
            var _loc_8:* = _loc_4.type;
            _loc_5 = _loc_4.type;
            if ((this.options == null || !this.options.generalActionBarsLock) && _loc_8 != null && _loc_8 != null && _loc_3.hasFormat("dragType") && _loc_3.dataForFormat("dragType") == DRAG_TYPE_OBJECT && _loc_3.hasFormat("dragObject") && _loc_8 != null && _loc_8 != null && _loc_5.isTakeable && this.m_ActionBar != null)
            {
                if (event.type == DragEvent.DRAG_DROP)
                {
                    _loc_6 = null;
                    _loc_7 = _loc_5.isLiquidContainer || _loc_5.isLiquidPool ? (_loc_4.data) : (0);
                    if (_loc_5.isCloth)
                    {
                        _loc_6 = new EquipAction(_loc_4, _loc_7, EquipAction.TARGET_AUTO);
                    }
                    else
                    {
                        _loc_6 = new UseAction(_loc_4, _loc_7, _loc_5.isMultiUse ? (UseAction.TARGET_CROSSHAIR) : (UseAction.TARGET_SELF));
                    }
                    this.m_ActionBar.setAction(_loc_2.position, _loc_6);
                }
                else if (event.type == DragEvent.DRAG_ENTER)
                {
                    DragManager.acceptDragDrop(_loc_2);
                }
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            if (this.m_UncommittedDirection)
            {
                this.m_UncommittedDirection = false;
            }
            if (this.m_UncommittedActionBar)
            {
                this.updateActions();
                this.updateToolTips();
                if (this.m_ActionBar != null)
                {
                    this.currentState = this.m_ActionBar.visible ? (STATE_OPEN) : (STATE_COLLAPSED);
                }
                else
                {
                    this.currentState = STATE_COLLAPSED;
                }
                this.m_UncommittedActionBar = false;
            }
            if (this.m_UncommittedOptions)
            {
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedContainerStorage)
            {
                this.m_UncommittedContainerStorage = false;
            }
            if (this.m_UncommittedMaxScrollPosition)
            {
                this.scrollPosition = Math.max(0, Math.min(this.m_ScrollPosition, this.m_MaxScrollPosition));
                this.m_UncommittedMaxScrollPosition = false;
            }
            if (this.m_UncommittedScrollPosition)
            {
                this.m_UncommittedScrollPosition = false;
            }
            if (this.m_UncommittedLocation)
            {
                this.m_UncommittedLocation = false;
            }
            if (this.m_UncommittedCurrentState)
            {
                this.scrollPosition = 0;
                this.m_UIToggleButton.selected = currentState == STATE_OPEN;
                this.m_UncommittedCurrentState = false;
            }
            return;
        }// end function

        private function onMouseDown(event:MouseEvent) : void
        {
            if (event is MouseRepeatEvent && (event.currentTarget == this.m_UIScrollDownButton || event.currentTarget == this.m_UIScrollUpButton))
            {
                MouseRepeatEvent(event).repeatEnabled = true;
            }
            return;
        }// end function

        private function updateToolTips() : void
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (this.m_ActionBar == null || this.m_ActionBar.length < 1)
            {
                return;
            }
            var _loc_1:* = Tibia.s_GetAppearanceStorage();
            var _loc_2:* = Tibia.s_GetCommunication();
            if (_loc_1 == null || _loc_2 == null || !_loc_2.isGameRunning)
            {
                return;
            }
            var _loc_3:* = new Vector.<AppearanceTypeRef>;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            _loc_4 = 0;
            _loc_7 = this.m_ActionBar.size;
            while (_loc_4 < _loc_7)
            {
                
                _loc_8 = this.m_ActionBar.getAction(_loc_4);
                _loc_9 = -1;
                _loc_10 = -1;
                if (_loc_8 is UseAction)
                {
                    _loc_9 = UseAction(_loc_8).type.ID;
                    _loc_10 = UseAction(_loc_8).data;
                }
                else if (_loc_8 is EquipAction)
                {
                    _loc_9 = EquipAction(_loc_8).type.ID;
                    _loc_10 = EquipAction(_loc_8).data;
                }
                if (_loc_9 > -1 && _loc_10 > -1 && _loc_1.getCachedObjectTypeName(_loc_9, _loc_10) == null)
                {
                    _loc_3.push(new AppearanceTypeRef(_loc_9, _loc_10));
                }
                _loc_4++;
            }
            _loc_3 = _loc_3.sort(AppearanceTypeRef.s_Compare);
            _loc_7 = _loc_3.length;
            _loc_4 = 0;
            _loc_5 = 0;
            while (_loc_4 < _loc_7)
            {
                
                while (_loc_5 < _loc_7 && _loc_3[_loc_4].equals(_loc_3[_loc_5]))
                {
                    
                    _loc_5++;
                }
                if (_loc_5 - _loc_4 > 1)
                {
                    _loc_6 = _loc_5 - _loc_4 - 1;
                    _loc_7 = _loc_7 - _loc_6;
                    _loc_5 = _loc_4 + 1;
                    while (_loc_5 < _loc_7)
                    {
                        
                        _loc_3[_loc_5] = _loc_3[_loc_5 + _loc_6];
                        _loc_5++;
                    }
                }
                _loc_4++;
                _loc_5 = _loc_4;
            }
            _loc_3.length = _loc_7;
            _loc_2.sendCGETOBJECTINFO(_loc_3);
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_1:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            super.measure();
            _loc_1 = viewMetricsAndPadding;
            var _loc_2:* = this.m_Direction == DIRECTION_HORIZONTAL ? (getStyle("horizontalGap")) : (getStyle("verticalGap"));
            var _loc_3:* = this.m_UIToggleButton.getExplicitOrMeasuredHeight();
            var _loc_4:* = this.m_UIToggleButton.getExplicitOrMeasuredWidth();
            _loc_5 = this.m_UIScrollUpButton.getExplicitOrMeasuredHeight() + this.m_UIScrollDownButton.getExplicitOrMeasuredHeight();
            _loc_6 = this.m_UIScrollUpButton.getExplicitOrMeasuredWidth() + this.m_UIScrollDownButton.getExplicitOrMeasuredWidth();
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = numChildren;
            if (this.m_Direction == DIRECTION_HORIZONTAL)
            {
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_7 = UIComponent(getChildAt(_loc_14));
                    _loc_10 = _loc_7.getExplicitOrMeasuredWidth();
                    _loc_13 = _loc_7.getExplicitOrMeasuredHeight();
                    _loc_8 = Math.max(_loc_8, _loc_13);
                    _loc_11 = Math.max(_loc_11, _loc_10);
                    _loc_12 = _loc_12 + _loc_10;
                    _loc_14++;
                }
                if (currentState == STATE_COLLAPSED && this.m_Location == ActionBarSet.LOCATION_TOP)
                {
                    var _loc_16:* = _loc_1.top;
                    measuredHeight = _loc_1.top;
                    measuredMinHeight = _loc_16;
                }
                else if (currentState == STATE_COLLAPSED && this.m_Location == ActionBarSet.LOCATION_BOTTOM)
                {
                    var _loc_16:* = _loc_1.bottom;
                    measuredHeight = _loc_1.bottom;
                    measuredMinHeight = _loc_16;
                }
                else
                {
                    var _loc_16:* = _loc_1.top + _loc_8 + _loc_1.bottom;
                    measuredHeight = _loc_1.top + _loc_8 + _loc_1.bottom;
                    measuredMinHeight = _loc_16;
                }
                measuredMinWidth = _loc_1.left + _loc_6 + _loc_11 + 2 * _loc_2 + _loc_1.right;
                measuredWidth = _loc_1.left + _loc_6 + _loc_12 + (numChildren + 1) * _loc_2 + _loc_1.right;
            }
            else
            {
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_7 = UIComponent(getChildAt(_loc_14));
                    _loc_13 = _loc_7.getExplicitOrMeasuredHeight();
                    _loc_10 = _loc_7.getExplicitOrMeasuredWidth();
                    _loc_11 = Math.max(_loc_11, _loc_10);
                    _loc_8 = Math.max(_loc_8, _loc_13);
                    _loc_9 = _loc_9 + _loc_13;
                    _loc_14++;
                }
                if (currentState == STATE_COLLAPSED && this.m_Location == ActionBarSet.LOCATION_LEFT)
                {
                    var _loc_16:* = _loc_1.left;
                    measuredWidth = _loc_1.left;
                    measuredMinWidth = _loc_16;
                }
                else if (currentState == STATE_COLLAPSED && this.m_Location == ActionBarSet.LOCATION_RIGHT)
                {
                    var _loc_16:* = _loc_1.right;
                    measuredWidth = _loc_1.right;
                    measuredMinWidth = _loc_16;
                }
                else
                {
                    var _loc_16:* = _loc_1.left + _loc_11 + _loc_1.right;
                    measuredWidth = _loc_1.left + _loc_11 + _loc_1.right;
                    measuredMinWidth = _loc_16;
                }
                measuredMinHeight = _loc_1.top + _loc_5 + _loc_8 + 2 * _loc_2 + _loc_1.bottom;
                measuredHeight = _loc_1.top + _loc_5 + _loc_9 + (numChildren + 1) * _loc_2 + _loc_1.bottom;
            }
            this.m_MaxChildHeight = _loc_8;
            this.m_MaxChildWidth = _loc_11;
            return;
        }// end function

        protected function updateActionBar() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = null;
            if (this.m_Options != null)
            {
                _loc_2 = this.m_Options.getActionBarSet(this.m_Options.generalInputSetID);
                if (_loc_2 != null)
                {
                    _loc_1 = _loc_2.getActionBar(this.m_Location);
                }
            }
            this.actionBar = _loc_1;
            return;
        }// end function

        private function updateButtonDragListeners(param1:IActionButton, param2:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = systemManager.getSandboxRoot();
            _loc_3 = systemManager.getSandboxRoot();
            if (param1 != null && systemManager != null && _loc_4 != null)
            {
                if (param2)
                {
                    param1.addEventListener(MouseEvent.MOUSE_MOVE, this.onButtonActionDragStart);
                    param1.addEventListener(MouseEvent.MOUSE_UP, this.onButtonActionDragStop);
                    _loc_3.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onButtonActionDragStop);
                }
                else
                {
                    param1.removeEventListener(MouseEvent.MOUSE_MOVE, this.onButtonActionDragStart);
                    param1.removeEventListener(MouseEvent.MOUSE_UP, this.onButtonActionDragStop);
                    _loc_3.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onButtonActionDragStop);
                }
            }
            return;
        }// end function

        public function set location(param1:int) : void
        {
            if (param1 != ActionBarSet.LOCATION_TOP && param1 != ActionBarSet.LOCATION_BOTTOM && param1 != ActionBarSet.LOCATION_LEFT && param1 != ActionBarSet.LOCATION_RIGHT)
            {
                throw new ArgumentError("ActionBarWidget.set location: Invalid value.");
            }
            if (this.m_Location != param1)
            {
                if (this.m_Direction == DIRECTION_HORIZONTAL && (param1 == ActionBarSet.LOCATION_TOP || param1 == ActionBarSet.LOCATION_BOTTOM))
                {
                    this.m_Location = param1;
                    this.m_UncommittedLocation = true;
                }
                if (this.m_Direction == DIRECTION_VERTICAL && (param1 == ActionBarSet.LOCATION_LEFT || param1 == ActionBarSet.LOCATION_RIGHT))
                {
                    this.m_Location = param1;
                    this.m_UncommittedLocation = true;
                }
                invalidateDisplayList();
                invalidateProperties();
                this.updateActionBar();
            }
            return;
        }// end function

        private function onButtonSpellDragEvent(event:DragEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = event.currentTarget as IActionButton;
            _loc_2 = event.currentTarget as IActionButton;
            var _loc_5:* = event.dragSource;
            _loc_3 = event.dragSource;
            var _loc_5:* = _loc_3.dataForFormat("dragSpell") as Spell;
            _loc_4 = _loc_3.dataForFormat("dragSpell") as Spell;
            if ((this.options == null || !this.options.generalActionBarsLock) && _loc_5 != null && _loc_5 != null && _loc_3.hasFormat("dragType") && _loc_3.dataForFormat("dragType") == DRAG_TYPE_SPELL && _loc_3.hasFormat("dragSpell") && _loc_5 != null && this.m_ActionBar != null)
            {
                if (event.type == DragEvent.DRAG_DROP)
                {
                    this.m_ActionBar.setAction(_loc_2.position, new SpellAction(_loc_4, null));
                }
                else if (event.type == DragEvent.DRAG_ENTER)
                {
                    DragManager.acceptDragDrop(_loc_2);
                }
            }
            return;
        }// end function

        public function set containerStorage(param1:ContainerStorage) : void
        {
            if (this.m_ContainerStorage != param1)
            {
                if (this.m_ContainerStorage != null)
                {
                    this.m_ContainerStorage.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChange);
                }
                this.m_ContainerStorage = param1;
                if (this.m_ContainerStorage != null)
                {
                    this.m_ContainerStorage.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onContainerChange);
                }
                this.m_UncommittedContainerStorage = true;
                invalidateDisplayList();
                invalidateProperties();
            }
            return;
        }// end function

        private function onMouseWheel(event:MouseEvent) : void
        {
            this.scrollPosition = this.scrollPosition + (-event.delta) / Math.abs(event.delta) * (event.shiftKey ? (10) : (1));
            return;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:* = mx_internal::border as IBorder;
            if (_loc_1 != null)
            {
                return _loc_1.borderMetrics;
            }
            return EdgeMetrics.EMPTY;
        }// end function

        private function onOptionsChange(event:PropertyChangeEvent) : void
        {
            if (event.property == "generalInputSetID" || event.property == "actionBarSet" || event.property == "*")
            {
                invalidateDisplayList();
                this.updateActionBar();
            }
            if (event.property == "generalActionBarsLock" || event.property == "*")
            {
                invalidateDisplayList();
            }
            return;
        }// end function

        public function get actionBar() : ActionBar
        {
            return this.m_ActionBar;
        }// end function

        public function set direction(param1:int) : void
        {
            if (param1 != DIRECTION_HORIZONTAL && param1 != DIRECTION_VERTICAL)
            {
                throw new ArgumentError("ActionBarWidget.set direction: Invalid value.");
            }
            if (this.m_Direction != param1)
            {
                this.m_Direction = param1;
                this.m_UncommittedDirection = true;
                if (this.m_Direction == DIRECTION_HORIZONTAL && (this.m_Location != ActionBarSet.LOCATION_TOP && this.m_Location != ActionBarSet.LOCATION_BOTTOM))
                {
                    this.m_UncommittedLocation = true;
                }
                if (this.m_Direction == DIRECTION_VERTICAL && (this.m_Location != ActionBarSet.LOCATION_RIGHT && this.m_Location != ActionBarSet.LOCATION_RIGHT))
                {
                    this.m_Location = ActionBarSet.LOCATION_LEFT;
                    this.m_UncommittedLocation = true;
                }
                invalidateProperties();
                this.updateActionBar();
            }
            return;
        }// end function

        public function get direction() : int
        {
            return this.m_Direction;
        }// end function

    }
}
