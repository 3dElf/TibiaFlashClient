package tibia.game
{
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.containers.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import tibia.game.contextMenuClasses.*;
    import tibia.input.*;

    public class ContextMenuBase extends VBox
    {
        private var m_UIEmbeddedMouseShield:Sprite;
        static var s_Current:ContextMenuBase = null;

        public function ContextMenuBase()
        {
            this.m_UIEmbeddedMouseShield = new Sprite();
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            maxWidth = 350;
            minWidth = 200;
            addEventListener(ChildExistenceChangedEvent.CHILD_ADD, this.onChildExistenceChanged);
            addEventListener(ChildExistenceChangedEvent.CHILD_REMOVE, this.onChildExistenceChanged);
            return;
        }// end function

        public function hide() : void
        {
            var _loc_1:* = null;
            var _loc_3:* = (owner as IUIComponent).systemManager;
            _loc_1 = (owner as IUIComponent).systemManager;
            if (owner is IUIComponent && _loc_3 != null)
            {
                _loc_1.popUpChildren.removeChild(this);
                if (_loc_1.popUpChildren.contains(this.m_UIEmbeddedMouseShield))
                {
                    _loc_1.popUpChildren.removeChild(this.m_UIEmbeddedMouseShield);
                    _loc_1.removeEventListener(Event.RESIZE, this.onResize);
                }
                _loc_1.deployMouseShields(false);
                _loc_1.removeEventListener(Event.ACTIVATE, this.onEventHide);
                _loc_1.removeEventListener(Event.DEACTIVATE, this.onEventHide);
                _loc_1.removeEventListener(Event.RESIZE, this.onEventHide);
                _loc_1.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyboardHide);
                _loc_1.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseHide);
                _loc_1.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseHide);
                _loc_1.removeEventListener(MouseEvent.CLICK, this.onMouseHide);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onMouseHide);
                _loc_1.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onMouseHide);
                _loc_1.removeEventListener(MouseEvent.RIGHT_CLICK, this.onMouseHide);
                owner = null;
            }
            var _loc_2:* = Tibia.s_GetInputHandler();
            if (_loc_2 != null)
            {
                _loc_2.captureKeyboard = true;
            }
            ToolTipManager.currentTarget = null;
            ToolTipManager.enabled = true;
            s_Current = null;
            return;
        }// end function

        protected function createSeparatorItem() : SeparatorItem
        {
            var _loc_1:* = new SeparatorItem();
            _loc_1.owner = owner;
            _loc_1.percentWidth = 100;
            addChild(_loc_1);
            return _loc_1;
        }// end function

        private function onMouseHide(event:MouseEvent) : void
        {
            if (!hitTestPoint(event.stageX, event.stageY))
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                if (event.type == MouseEvent.CLICK || event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.RIGHT_CLICK || event.type == MouseEvent.RIGHT_MOUSE_UP)
                {
                    this.hide();
                }
            }
            return;
        }// end function

        public function display(param1:IUIComponent, param2:Number, param3:Number) : void
        {
            var _loc_4:* = null;
            var _loc_7:* = param1.systemManager;
            _loc_4 = param1.systemManager;
            if (param1 != null && _loc_7 != null && _loc_4.stage != null)
            {
                if (_loc_4.popUpChildren.contains(this.m_UIEmbeddedMouseShield))
                {
                    _loc_4.popUpChildren.removeChild(this.m_UIEmbeddedMouseShield);
                }
                _loc_4.popUpChildren.addChild(this.m_UIEmbeddedMouseShield);
                _loc_4.addEventListener(Event.RESIZE, this.onResize);
                _loc_4.popUpChildren.addChild(this);
                _loc_4.deployMouseShields(true);
                _loc_4.addEventListener(Event.ACTIVATE, this.onEventHide);
                _loc_4.addEventListener(Event.DEACTIVATE, this.onEventHide);
                _loc_4.addEventListener(Event.RESIZE, this.onEventHide);
                _loc_4.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyboardHide);
                _loc_4.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseHide);
                _loc_4.addEventListener(MouseEvent.MOUSE_UP, this.onMouseHide);
                _loc_4.addEventListener(MouseEvent.CLICK, this.onMouseHide);
                _loc_4.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onMouseHide);
                _loc_4.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onMouseHide);
                _loc_4.addEventListener(MouseEvent.RIGHT_CLICK, this.onMouseHide);
                validateNow();
                move(Math.max(0, Math.min(param2, _loc_4.stage.stageWidth - measuredWidth)), Math.max(0, Math.min(param3, _loc_4.stage.stageHeight - measuredHeight)));
                owner = param1 as DisplayObjectContainer;
            }
            var _loc_5:* = Tibia.s_GetInputHandler();
            if (Tibia.s_GetInputHandler() != null)
            {
                _loc_5.captureKeyboard = false;
            }
            var _loc_6:* = ToolTipManager.currentToolTip;
            if (ToolTipManager.currentToolTip != null)
            {
                ToolTipManager.destroyToolTip(_loc_6);
                ToolTipManager.currentToolTip = null;
            }
            ToolTipManager.currentTarget = null;
            ToolTipManager.enabled = false;
            if (s_Current != null)
            {
                s_Current.hide();
            }
            s_Current = this;
            return;
        }// end function

        private function onKeyboardHide(event:KeyboardEvent) : void
        {
            if (event.keyCode == Keyboard.ESCAPE)
            {
                this.hide();
            }
            return;
        }// end function

        private function onChildExistenceChanged(event:ChildExistenceChangedEvent) : void
        {
            var _loc_2:* = event.relatedObject as IContextMenuItem;
            if (_loc_2 != null)
            {
                if (event.type == ChildExistenceChangedEvent.CHILD_ADD)
                {
                    _loc_2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onEventHide, false, int.MAX_VALUE, false);
                }
                else
                {
                    _loc_2.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.onEventHide);
                }
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var a_UnscaledWidth:* = param1;
            var a_UnscaledHeight:* = param2;
            super.updateDisplayList(a_UnscaledWidth, a_UnscaledHeight);
            var OuterContainer:* = Tibia.s_GetInstance();
            if (OuterContainer != null)
            {
                if (this.m_UIEmbeddedMouseShield != null)
                {
                    this.m_UIEmbeddedMouseShield.x = 0;
                    this.m_UIEmbeddedMouseShield.y = 0;
                    var _loc_4:* = this.m_UIEmbeddedMouseShield.graphics;
                    with (this.m_UIEmbeddedMouseShield.graphics)
                    {
                        clear();
                        beginFill(65280, 0);
                        drawRect(0, 0, OuterContainer.width, OuterContainer.height);
                        endFill();
                    }
                }
            }
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            invalidateDisplayList();
            invalidateSize();
            return;
        }// end function

        protected function createTextItem(param1:String, param2:Function) : TextItem
        {
            var _loc_3:* = new TextItem();
            _loc_3.caption = param1;
            _loc_3.owner = owner;
            _loc_3.percentWidth = 100;
            _loc_3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, param2);
            addChild(_loc_3);
            return _loc_3;
        }// end function

        private function onEventHide(event:Event) : void
        {
            this.hide();
            return;
        }// end function

        override protected function measure() : void
        {
            var _loc_5:* = false;
            var _loc_6:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_3);
                if (_loc_2 is SeparatorItem)
                {
                    _loc_5 = _loc_3 > 0 && _loc_3 < (numChildren - 1) && !(getChildAt((_loc_3 + 1)) is SeparatorItem);
                    SeparatorItem(_loc_2).includeInLayout = _loc_5;
                    SeparatorItem(_loc_2).visible = _loc_5;
                }
                else if (_loc_2 is TextItem)
                {
                    _loc_6 = !isNaN(TextItem(_loc_2).explicitIconWidth) ? (TextItem(_loc_2).explicitIconWidth) : (TextItem(_loc_2).measuredIconWidth);
                    _loc_1 = Math.max(_loc_1, _loc_6);
                }
                _loc_3++;
            }
            var _loc_4:* = 0;
            while (_loc_4 < numChildren)
            {
                
                _loc_2 = getChildAt(_loc_4);
                if (_loc_2 is TextItem)
                {
                    TextItem(_loc_2).iconWidth = _loc_1;
                }
                _loc_4++;
            }
            super.measure();
            return;
        }// end function

        public static function getCurrent() : ContextMenuBase
        {
            return s_Current;
        }// end function

    }
}
