package tibia.game
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.ui.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.controls.*;
    import shared.utility.*;

    public class PopUpBase extends VBox
    {
        private var m_ButtonFlags:uint = 0;
        private var m_UncommittedButtonFlags:Boolean = true;
        private var m_UIEmbeddedDialog:EmbeddedDialog = null;
        private var m_DragStartX:Number = NaN;
        private var m_DragStartY:Number = NaN;
        private var m_UncommittedTitle:Boolean = false;
        private var m_UITitleLabel:Label = null;
        private var m_EnqueuedEmbeddedDialogs:Vector.<EmbeddedDialog>;
        private var m_Priority:int = 0;
        private var m_InvalidFocus:Boolean = false;
        private var m_UIHeader:Container = null;
        private var m_StretchEmbeddedDialog:Boolean = true;
        private var m_Title:String = null;
        private var m_UIFooter:Container = null;
        private var m_KeyboardFlags:uint = 0;
        private var m_UIEmbeddedMouseShield:Sprite;
        public static const BUTTON_OKAY:uint = 4;
        public static const DEFAULT_PRIORITY:int = 0;
        public static const BUTTON_ABORT:uint = 32;
        public static const KEY_ESCAPE:uint = 2;
        public static const BUTTON_CLOSE:uint = 16;
        private static var s_Current:PopUpBase = null;
        private static const BUTTON_MASK:uint = DISABLE_BUTTONS | ENABLE_BUTTONS | BUTTON_YES | BUTTON_NO | BUTTON_OKAY | BUTTON_CANCEL | BUTTON_CLOSE | BUTTON_ABORT;
        private static const BUTTON_FLAGS:Array = [{data:BUTTON_OKAY, label:"BTN_OKAY"}, {data:BUTTON_YES, label:"BTN_YES"}, {data:BUTTON_CLOSE, label:"BTN_CLOSE"}, {data:BUTTON_ABORT, label:"BTN_ABORT"}, {data:BUTTON_NO, label:"BTN_NO"}, {data:BUTTON_CANCEL, label:"BTN_CANCEL"}];
        private static const BUNDLE:String = "Global";
        public static const BUTTON_NONE:uint = 0;
        public static const BUTTON_CANCEL:uint = 8;
        public static const DISABLE_BUTTONS:uint = 2.14748e+009;
        public static const ENABLE_BUTTONS:uint = 0;
        public static const BUTTON_NO:uint = 2;
        private static const KEY_MASK:uint = KEY_ENTER | KEY_ESCAPE;
        public static const KEY_NONE:uint = 0;
        public static const BUTTON_YES:uint = 1;
        public static const KEY_ENTER:uint = 1;

        public function PopUpBase()
        {
            this.m_EnqueuedEmbeddedDialogs = new Vector.<EmbeddedDialog>;
            this.m_UIEmbeddedMouseShield = new Sprite();
            horizontalScrollPolicy = ScrollPolicy.OFF;
            verticalScrollPolicy = ScrollPolicy.OFF;
            this.buttonFlags = BUTTON_CANCEL | BUTTON_OKAY;
            this.keyboardFlags = KEY_ENTER | KEY_ESCAPE;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        protected function get header() : Container
        {
            return this.m_UIHeader;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var a_UnscaledWidth:* = param1;
            var a_UnscaledHeight:* = param2;
            super.updateDisplayList(a_UnscaledWidth, a_UnscaledHeight);
            var v:* = this.borderMetrics;
            var h:Number;
            var w:* = a_UnscaledWidth - v.left - v.right;
            h = this.m_UIHeader.getExplicitOrMeasuredHeight();
            this.m_UIHeader.move(v.left, (v.top - h) / 2);
            this.m_UIHeader.setActualSize(w, h);
            h = this.m_UIFooter.getExplicitOrMeasuredHeight();
            this.m_UIFooter.move(v.left, a_UnscaledHeight - (v.bottom + h) / 2);
            this.m_UIFooter.setActualSize(w, h);
            if (this.m_UIEmbeddedDialog != null)
            {
                if (this.m_UIEmbeddedMouseShield != null)
                {
                    this.m_UIEmbeddedMouseShield.x = 0;
                    this.m_UIEmbeddedMouseShield.y = 0;
                    var _loc_4:* = this.m_UIEmbeddedMouseShield.graphics;
                    with (this.m_UIEmbeddedMouseShield.graphics)
                    {
                        clear();
                        beginFill(0, 0.5);
                        drawRect(0, 0, a_UnscaledWidth, a_UnscaledHeight);
                        endFill();
                    }
                }
                h = this.m_UIEmbeddedDialog.getExplicitOrMeasuredHeight();
                if (this.m_StretchEmbeddedDialog)
                {
                    this.m_UIEmbeddedDialog.move(v.left, v.top + (a_UnscaledHeight - v.top - v.bottom - h) / 2);
                }
                else
                {
                    w = Math.min(w, this.m_UIEmbeddedDialog.getExplicitOrMeasuredWidth());
                    this.m_UIEmbeddedDialog.move(v.left + (a_UnscaledWidth - v.left - v.right - w) / 2, v.top + (a_UnscaledHeight - v.top - v.bottom - h) / 2);
                }
                this.m_UIEmbeddedDialog.setActualSize(w, h);
                rawChildren.setChildIndex(this.m_UIEmbeddedDialog, (rawChildren.numChildren - 1));
            }
            return;
        }// end function

        public function enqueueEmbeddedDialog(param1:EmbeddedDialog) : void
        {
            if (this.embeddedDialog != null)
            {
                this.m_EnqueuedEmbeddedDialogs.push(param1);
            }
            else
            {
                this.embeddedDialog = param1;
            }
            return;
        }// end function

        protected function get footer() : Container
        {
            return this.m_UIFooter;
        }// end function

        override protected function createChildren() : void
        {
            super.createChildren();
            this.m_UIFooter = new HBox();
            this.m_UIFooter.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.m_UIFooter.verticalScrollPolicy = ScrollPolicy.OFF;
            this.m_UIFooter.percentHeight = NaN;
            this.m_UIFooter.percentWidth = 100;
            this.m_UIFooter.styleName = getStyle("footerStyle");
            rawChildren.addChild(this.m_UIFooter);
            this.m_UIHeader = new HBox();
            this.m_UIHeader.horizontalScrollPolicy = ScrollPolicy.OFF;
            this.m_UIHeader.verticalScrollPolicy = ScrollPolicy.OFF;
            this.m_UIHeader.percentHeight = NaN;
            this.m_UIHeader.percentWidth = 100;
            this.m_UIHeader.styleName = getStyle("headerStyle");
            this.m_UIHeader.addEventListener(MouseEvent.MOUSE_DOWN, this.onDrag);
            rawChildren.addChild(this.m_UIHeader);
            this.m_UITitleLabel = new Label();
            this.m_UITitleLabel.styleName = getStyle("titleStyle");
            this.m_UIHeader.addChild(this.m_UITitleLabel);
            return;
        }// end function

        public function get priority() : int
        {
            return this.m_Priority;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            s_Current = this;
            addEventListener(KeyboardEvent.KEY_DOWN, this.onClose, false, EventPriority.DEFAULT_HANDLER, false);
            callLater(this.invalidateFocus);
            return;
        }// end function

        public function set stretchEmbeddedDialog(param1:Boolean) : void
        {
            if (param1 != this.m_StretchEmbeddedDialog)
            {
                this.m_StretchEmbeddedDialog = param1;
                invalidateDisplayList();
            }
            return;
        }// end function

        public function set title(param1:String) : void
        {
            if (this.m_Title != param1)
            {
                this.m_Title = param1;
                this.m_UncommittedTitle = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function onDrag(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null)
            {
                _loc_2 = systemManager.getSandboxRoot();
                switch(event.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                    {
                        if (isPopUp && isNaN(this.m_DragStartX) && isNaN(this.m_DragStartY))
                        {
                            _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.onDrag);
                            _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.onDrag);
                            _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDrag);
                            systemManager.deployMouseShields(true);
                            this.m_DragStartX = MouseEvent(event).stageX - x;
                            this.m_DragStartY = MouseEvent(event).stageY - y;
                        }
                        break;
                    }
                    case MouseEvent.MOUSE_MOVE:
                    {
                        event.preventDefault();
                        event.stopImmediatePropagation();
                        if (!isNaN(this.m_DragStartX) && !isNaN(this.m_DragStartY))
                        {
                            move(MouseEvent(event).stageX - this.m_DragStartX, MouseEvent(event).stageY - this.m_DragStartY);
                        }
                        break;
                    }
                    case MouseEvent.MOUSE_UP:
                    case SandboxMouseEvent.MOUSE_UP_SOMEWHERE:
                    {
                        _loc_2.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDrag);
                        _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.onDrag);
                        _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onDrag);
                        systemManager.deployMouseShields(false);
                        this.m_DragStartX = NaN;
                        this.m_DragStartY = NaN;
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

        public function set keyboardFlags(param1:uint) : void
        {
            param1 = param1 & KEY_MASK;
            if (this.m_KeyboardFlags != param1)
            {
                this.m_KeyboardFlags = param1;
            }
            return;
        }// end function

        public function set priority(param1:int) : void
        {
            this.m_Priority = param1;
            return;
        }// end function

        private function onEmbeddedDialogClose(event:CloseEvent) : void
        {
            if (!event.cancelable || !event.isDefaultPrevented())
            {
                this.embeddedDialog = null;
            }
            return;
        }// end function

        public function hide(param1:Boolean = false) : void
        {
            PopUpQueue.getInstance().hide(this);
            return;
        }// end function

        public function get stretchEmbeddedDialog() : Boolean
        {
            return this.m_StretchEmbeddedDialog;
        }// end function

        public function get title() : String
        {
            return this.m_Title;
        }// end function

        override protected function commitProperties() : void
        {
            var _Button:Button;
            var i:int;
            var Candidates:Array;
            super.commitProperties();
            if (this.m_UncommittedTitle)
            {
                this.m_UITitleLabel.text = this.m_Title;
                this.m_UncommittedTitle = false;
            }
            if (this.m_UncommittedButtonFlags)
            {
                _Button;
                i;
                i = (this.m_UIFooter.numChildren - 1);
                while (i >= 0)
                {
                    
                    _Button = Button(this.m_UIFooter.removeChildAt(i));
                    _Button.removeEventListener(MouseEvent.CLICK, this.onClose);
                    i = (i - 1);
                }
                i;
                while (i < BUTTON_FLAGS.length)
                {
                    
                    if ((this.buttonFlags & BUTTON_FLAGS[i].data) != 0)
                    {
                        _Button = new CustomButton();
                        _Button.data = BUTTON_FLAGS[i].data;
                        _Button.enabled = (this.buttonFlags & DISABLE_BUTTONS) == 0;
                        _Button.label = resourceManager.getString(BUNDLE, BUTTON_FLAGS[i].label);
                        _Button.addEventListener(MouseEvent.CLICK, this.onClose);
                        this.m_UIFooter.addChild(_Button);
                    }
                    i = (i + 1);
                }
                this.m_UncommittedButtonFlags = false;
            }
            if (this.m_InvalidFocus)
            {
                Candidates;
                loopDisplayList(this.focusRoot, null, function (param1) : void
            {
                if (param1 is IFocusManagerComponent && (!param1.hasOwnProperty("editable") || param1.editable) && (!param1.hasOwnProperty("enabled") || param1.enabled))
                {
                    Candidates.push(param1);
                }
                return;
            }// end function
            );
                if (Candidates.length > 0)
                {
                    Candidates = Candidates.sortOn("tabIndex", Array.NUMERIC);
                    Candidates[0].setFocus();
                }
                else
                {
                    setFocus();
                }
                this.m_InvalidFocus = false;
            }
            return;
        }// end function

        protected function invalidateFocus() : void
        {
            this.m_InvalidFocus = true;
            invalidateProperties();
            return;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            if (!isNaN(this.m_UIHeader.measuredWidth))
            {
                measuredWidth = Math.max(measuredWidth, this.m_UIHeader.measuredWidth);
            }
            if (!isNaN(this.m_UIHeader.measuredMinWidth))
            {
                measuredMinWidth = Math.max(measuredMinWidth, this.m_UIHeader.measuredMinWidth);
            }
            if (!isNaN(this.m_UIFooter.measuredWidth))
            {
                measuredWidth = Math.max(measuredWidth, this.m_UIFooter.measuredWidth);
            }
            if (!isNaN(this.m_UIFooter.measuredMinWidth))
            {
                measuredMinWidth = Math.max(measuredMinWidth, this.m_UIFooter.measuredMinWidth);
            }
            return;
        }// end function

        public function get keyboardFlags() : uint
        {
            return this.m_KeyboardFlags;
        }// end function

        protected function get focusRoot() : DisplayObjectContainer
        {
            return this;
        }// end function

        public function set embeddedDialog(param1:EmbeddedDialog) : void
        {
            if (this.m_UIEmbeddedDialog != param1)
            {
                if (this.m_UIEmbeddedDialog != null)
                {
                    this.m_UIEmbeddedDialog.removeEventListener(CloseEvent.CLOSE, this.onEmbeddedDialogClose);
                    if (rawChildren.contains(this.m_UIEmbeddedMouseShield))
                    {
                        rawChildren.removeChild(this.m_UIEmbeddedMouseShield);
                    }
                    if (rawChildren.contains(this.m_UIEmbeddedDialog))
                    {
                        rawChildren.removeChild(this.m_UIEmbeddedDialog);
                    }
                    setFocus();
                }
                this.m_UIEmbeddedDialog = param1;
                if (this.m_UIEmbeddedDialog != null)
                {
                    this.m_UIEmbeddedDialog.addEventListener(CloseEvent.CLOSE, this.onEmbeddedDialogClose, false, EventPriority.DEFAULT_HANDLER, false);
                    rawChildren.addChild(this.m_UIEmbeddedMouseShield);
                    rawChildren.addChild(this.m_UIEmbeddedDialog);
                    this.m_UIEmbeddedDialog.setFocus();
                }
                else
                {
                    this.showNextEmbeddedDialogInQueue();
                }
            }
            return;
        }// end function

        public function set buttonFlags(param1:uint) : void
        {
            param1 = param1 & BUTTON_MASK;
            if (this.m_ButtonFlags != param1)
            {
                this.m_ButtonFlags = param1;
                this.m_UncommittedButtonFlags = true;
                invalidateProperties();
                invalidateSize();
            }
            return;
        }// end function

        private function onClose(event:Event) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = null;
            if (event is KeyboardEvent && KeyboardEvent(event).keyCode == Keyboard.ENTER && (this.m_KeyboardFlags & PopUpBase.KEY_ENTER) != 0)
            {
                _loc_2 = new CloseEvent(CloseEvent.CLOSE, false, true);
                _loc_2.detail = PopUpBase.BUTTON_OKAY;
                dispatchEvent(_loc_2);
            }
            else if (event is KeyboardEvent && KeyboardEvent(event).keyCode == Keyboard.ESCAPE && (this.m_KeyboardFlags & PopUpBase.KEY_ESCAPE) != 0)
            {
                _loc_2 = new CloseEvent(CloseEvent.CLOSE, false, true);
                _loc_2.detail = PopUpBase.BUTTON_CANCEL;
                dispatchEvent(_loc_2);
            }
            else if (event is MouseEvent && event.type == MouseEvent.CLICK)
            {
                _loc_3 = event.currentTarget as IDataRenderer;
                if (_loc_3 != null)
                {
                    _loc_2 = new CloseEvent(CloseEvent.CLOSE, false, true);
                    _loc_2.detail = uint(_loc_3.data);
                    dispatchEvent(_loc_2);
                }
            }
            if (_loc_2 != null && (!_loc_2.cancelable || !_loc_2.isDefaultPrevented()))
            {
                this.hide(_loc_2.detail == PopUpBase.BUTTON_OKAY || _loc_2.detail == PopUpBase.BUTTON_YES);
            }
            return;
        }// end function

        public function get embeddedDialog() : EmbeddedDialog
        {
            return this.m_UIEmbeddedDialog;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            s_Current = null;
            removeEventListener(KeyboardEvent.KEY_DOWN, this.onClose);
            var _loc_2:* = this.m_UIFooter.numChildren - 1;
            while (_loc_2 >= 0)
            {
                
                this.m_UIFooter.getChildAt(_loc_2).removeEventListener(MouseEvent.CLICK, this.onClose);
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function get buttonFlags() : uint
        {
            return this.m_ButtonFlags;
        }// end function

        override public function get borderMetrics() : EdgeMetrics
        {
            var _loc_1:* = super.borderMetrics.clone();
            if (getStyle("borderBottom"))
            {
                _loc_1.bottom = _loc_1.bottom + getStyle("borderBottom");
            }
            else
            {
                _loc_1.bottom = _loc_1.bottom + this.m_UIFooter.getExplicitOrMeasuredHeight();
            }
            if (getStyle("borderLeft"))
            {
                _loc_1.left = _loc_1.left + getStyle("borderLeft");
            }
            if (getStyle("borderRight"))
            {
                _loc_1.right = _loc_1.right + getStyle("borderRight");
            }
            if (getStyle("borderTop"))
            {
                _loc_1.top = _loc_1.top + getStyle("borderTop");
            }
            else
            {
                _loc_1.top = _loc_1.top + this.m_UIHeader.getExplicitOrMeasuredHeight();
            }
            return _loc_1;
        }// end function

        private function showNextEmbeddedDialogInQueue() : void
        {
            if (this.m_EnqueuedEmbeddedDialogs.length > 0)
            {
                this.embeddedDialog = this.m_EnqueuedEmbeddedDialogs.shift();
            }
            return;
        }// end function

        public function show() : void
        {
            PopUpQueue.getInstance().show(this);
            return;
        }// end function

        public static function getParentPopUp(param1:DisplayObject) : PopUpBase
        {
            while (param1 != null && !(param1 is Stage) && !(param1 is PopUpBase))
            {
                
                param1 = param1.parent as DisplayObject;
            }
            return param1 as PopUpBase;
        }// end function

        public static function getCurrent() : PopUpBase
        {
            return s_Current;
        }// end function

    }
}
