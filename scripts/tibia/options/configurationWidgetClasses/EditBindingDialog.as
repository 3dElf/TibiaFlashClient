package tibia.options.configurationWidgetClasses
{
    import flash.events.*;
    import mx.containers.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import shared.controls.*;
    import tibia.input.mapping.*;

    public class EditBindingDialog extends EmbeddedDialog
    {
        private var m_LastKeyCode:uint = 0;
        private var m_LastCharCode:uint = 0;
        private var m_LastModifierCode:uint = 0;
        private var m_OldBinding:Binding = null;
        private var m_LastText:String = null;
        private var m_UIFooter:Text = null;
        private var m_Mapping:Array = null;
        private var m_NewBinding:Binding = null;
        private var m_UIBinding:Text = null;
        private static const BUNDLE:String = "OptionsConfigurationWidget";

        public function EditBindingDialog()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.onAddRemove);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onAddRemove);
            addEventListener(CloseEvent.CLOSE, this.onClose);
            return;
        }// end function

        public function get binding() : Binding
        {
            return this.m_OldBinding;
        }// end function

        private function onKeyDown(event:KeyboardEvent) : void
        {
            event.preventDefault();
            event.stopImmediatePropagation();
            this.m_LastCharCode = 0;
            this.m_LastKeyCode = 0;
            this.m_LastModifierCode = 0;
            this.m_LastText = null;
            if (Binding.isBindable(event.keyCode, event.altKey, event.ctrlKey, event.shiftKey))
            {
                this.m_LastCharCode = event.charCode;
                this.m_LastKeyCode = event.keyCode;
                this.m_LastModifierCode = Binding.toModifierCode(event.altKey, event.ctrlKey, event.shiftKey);
                this.m_LastText = "";
            }
            return;
        }// end function

        public function set binding(param1:Binding) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("EditBindingDialog.set binding: Invalid binding.");
            }
            if (this.m_OldBinding != param1)
            {
                this.m_OldBinding = param1;
                this.m_NewBinding = this.m_OldBinding.clone();
                invalidateProperties();
            }
            return;
        }// end function

        private function onTextInput(event:TextEvent) : void
        {
            this.m_LastText = event.text;
            return;
        }// end function

        public function get mapping() : Array
        {
            return this.m_Mapping;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = undefined;
            var _loc_3:* = false;
            var _loc_4:* = null;
            if (this.m_OldBinding != null && this.m_NewBinding != null && this.m_Mapping != null)
            {
                _loc_1 = false;
                _loc_2 = null;
                for each (_loc_2 in this.m_Mapping)
                {
                    
                    if (this.m_OldBinding == _loc_2.firstBinding || this.m_OldBinding == _loc_2.secondBinding)
                    {
                        _loc_1 = true;
                        break;
                    }
                }
                _loc_3 = this.m_NewBinding.keyCode != 0;
                _loc_4 = null;
                if (_loc_3)
                {
                    for each (_loc_2 in this.m_Mapping)
                    {
                        
                        if (this.m_OldBinding != _loc_2.firstBinding && this.m_NewBinding.conflicts(_loc_2.firstBinding))
                        {
                            _loc_4 = Binding(_loc_2.firstBinding);
                            break;
                        }
                        if (this.m_OldBinding != _loc_2.secondBinding && this.m_NewBinding.conflicts(_loc_2.secondBinding))
                        {
                            _loc_4 = Binding(_loc_2.secondBinding);
                            break;
                        }
                    }
                    if (_loc_4 != null)
                    {
                        _loc_3 = _loc_4.editable && !_loc_4.action.equals(this.m_NewBinding.action);
                    }
                }
                buttonFlags = EmbeddedDialog.CANCEL | (_loc_1 ? (EmbeddedDialog.CLEAR) : (0)) | (_loc_3 ? (EmbeddedDialog.OKAY) : (0));
                title = resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_TITLE", [this.m_NewBinding.action]);
                this.m_UIBinding.text = this.m_NewBinding.toString();
                if (this.m_NewBinding.keyCode == 0)
                {
                    this.m_UIBinding.setStyle("color", undefined);
                    this.m_UIFooter.text = null;
                }
                else if (_loc_4 != null && _loc_4.action.equals(this.m_NewBinding.action))
                {
                    this.m_UIBinding.setStyle("color", 16711680);
                    this.m_UIFooter.text = resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_SELF", [_loc_4.action]);
                }
                else if (_loc_4 != null && !_loc_4.editable)
                {
                    this.m_UIBinding.setStyle("color", 16711680);
                    this.m_UIFooter.text = resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_STATIC", [_loc_4.action]);
                }
                else if (_loc_4 != null)
                {
                    this.m_UIBinding.setStyle("color", 16776960);
                    this.m_UIFooter.text = resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_DYNAMIC", [_loc_4.action, this.m_NewBinding.action]);
                }
                else
                {
                    this.m_UIBinding.setStyle("color", undefined);
                    this.m_UIFooter.text = resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_DEFAULT");
                }
                if (_loc_1)
                {
                    this.m_UIFooter.text = this.m_UIFooter.text + resourceManager.getString(BUNDLE, "HOTKEY_DLG_EDIT_CLEAR", [this.m_NewBinding.action]);
                }
            }
            else
            {
                buttonFlags = EmbeddedDialog.CANCEL;
                title = null;
                this.m_UIBinding.text = null;
                this.m_UIFooter.text = null;
            }
            super.commitProperties();
            return;
        }// end function

        private function onClose(event:CloseEvent) : void
        {
            removeEventListener(CloseEvent.CLOSE, this.onClose);
            if (event.detail == EmbeddedDialog.CLEAR)
            {
                this.updateBinding(this.m_Mapping, this.m_OldBinding, null);
            }
            else if (event.detail == EmbeddedDialog.OKAY)
            {
                this.updateBinding(this.m_Mapping, this.m_OldBinding, this.m_NewBinding);
            }
            return;
        }// end function

        public function set mapping(param1:Array) : void
        {
            if (param1 == null)
            {
                throw new ArgumentError("EditBindingDialog.set mapping: Invalid mapping.");
            }
            if (this.m_Mapping != param1)
            {
                this.m_Mapping = param1;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function createContent(param1:Box) : void
        {
            this.m_UIBinding = new Text();
            this.m_UIBinding.styleName = getStyle("textStyle");
            this.m_UIBinding.setStyle("fontSize", 16);
            this.m_UIBinding.setStyle("fontWeight", "bold");
            var _loc_2:* = new HBox();
            _loc_2.percentWidth = 100;
            _loc_2.setStyle("horizontalAlign", "center");
            _loc_2.addChild(this.m_UIBinding);
            param1.addChild(_loc_2);
            this.m_UIFooter = new Text();
            this.m_UIFooter.percentWidth = 100;
            this.m_UIFooter.styleName = getStyle("textStyle");
            param1.addChild(this.m_UIFooter);
            param1.minHeight = 77;
            param1.setStyle("verticalAlign", "top");
            return;
        }// end function

        private function onFocusOut(event:FocusEvent) : void
        {
            event.preventDefault();
            event.stopImmediatePropagation();
            setFocus();
            return;
        }// end function

        private function onAddRemove(event:Event) : void
        {
            if (event.type == Event.ADDED_TO_STAGE)
            {
                addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
                addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, (EventPriority.DEFAULT + 1), false);
                addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
                addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            }
            else
            {
                removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
                removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
                removeEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            }
            return;
        }// end function

        private function onKeyUp(event:KeyboardEvent) : void
        {
            if (this.m_LastKeyCode != 0)
            {
                this.m_NewBinding.update(this.m_LastCharCode, this.m_LastKeyCode, this.m_LastModifierCode, this.m_LastText);
                invalidateProperties();
            }
            this.m_LastCharCode = 0;
            this.m_LastKeyCode = 0;
            this.m_LastModifierCode = 0;
            this.m_LastText = null;
            return;
        }// end function

        private function updateBinding(param1:Array, param2:Binding, param3:Binding) : void
        {
            var _loc_5:* = false;
            var _loc_4:* = null;
            for each (_loc_4 in param1)
            {
                
                if (param2 != _loc_4.firstBinding && param3 != null && param3.conflicts(_loc_4.firstBinding) || param2 == _loc_4.firstBinding && param3 == null)
                {
                    _loc_4.firstBinding = _loc_4.secondBinding;
                    _loc_4.secondBinding = null;
                }
                if (param2 != _loc_4.secondBinding && param3 != null && param3.conflicts(_loc_4.secondBinding) || param2 == _loc_4.secondBinding && param3 == null)
                {
                    _loc_4.secondBinding = null;
                }
            }
            if (param3 == null)
            {
                return;
            }
            param2.update(param3);
            for each (_loc_4 in param1)
            {
                
                _loc_5 = param2.action.equals(_loc_4.action);
                if (param2 == _loc_4.firstBinding || _loc_5 && _loc_4.firstBinding == null)
                {
                    _loc_4.firstBinding = param2;
                    break;
                }
                if (param2 == _loc_4.secondBinding || _loc_5 && _loc_4.secondBinding == null)
                {
                    _loc_4.secondBinding = param2;
                    break;
                }
            }
            return;
        }// end function

    }
}
