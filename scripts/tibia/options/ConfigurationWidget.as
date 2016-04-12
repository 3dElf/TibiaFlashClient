package tibia.options
{
    import __AS3__.vec.*;
    import flash.display.*;
    import mx.containers.*;
    import mx.core.*;
    import shared.controls.*;
    import tibia.game.*;
    import tibia.options.configurationWidgetClasses.*;

    public class ConfigurationWidget extends PopUpBase
    {
        protected var m_SelectedIndex:int = 0;
        private var m_UncommittedOptions:Boolean = false;
        protected var m_UINavigator:TabNavigator = null;
        protected var m_UIOptionsEditor:Vector.<IOptionsEditor> = null;
        private var m_UncommittedSelectedIndex:Boolean = false;
        protected var m_EventHandlerActive:Boolean = false;
        protected var m_Options:OptionsStorage = null;
        private var m_UIConstructed:Boolean = false;
        public static const RENDERER:int = 1;
        public static const MOUSE:int = 4;
        public static const MESSAGE:int = 3;
        public static const GENERAL:int = 0;
        static const BUNDLE:String = "OptionsConfigurationWidget";
        public static const NAME_FILTER:int = 6;
        public static const HOTKEY:int = 5;
        public static const STATUS:int = 2;

        public function ConfigurationWidget()
        {
            title = resourceManager.getString(BUNDLE, "TITLE");
            width = 512;
            height = 532;
            this.m_UIOptionsEditor = new Vector.<IOptionsEditor>;
            this.m_UIOptionsEditor[GENERAL] = new GeneralOptions();
            this.m_UIOptionsEditor[RENDERER] = new RendererOptions();
            this.m_UIOptionsEditor[STATUS] = new StatusOptions();
            this.m_UIOptionsEditor[MESSAGE] = new MessageOptions();
            this.m_UIOptionsEditor[MOUSE] = new MouseControlOptions();
            this.m_UIOptionsEditor[HOTKEY] = new HotkeyOptions();
            this.m_UIOptionsEditor[NAME_FILTER] = new NameFilterOptions();
            return;
        }// end function

        override public function hide(param1:Boolean = false) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = 0;
                while (_loc_2 < this.m_UIOptionsEditor.length)
                {
                    
                    this.m_UIOptionsEditor[_loc_2].close(param1);
                    _loc_2++;
                }
                Tibia.s_SetOptions(this.options);
            }
            super.hide(param1);
            return;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = 0;
            if (this.m_UncommittedOptions)
            {
                _loc_1 = 0;
                while (_loc_1 < this.m_UIOptionsEditor.length)
                {
                    
                    this.m_UIOptionsEditor[_loc_1].options = this.m_Options;
                    _loc_1++;
                }
                this.m_UncommittedOptions = false;
            }
            if (this.m_UncommittedSelectedIndex)
            {
                if (this.m_UINavigator != null)
                {
                    this.m_UINavigator.selectedIndex = this.m_SelectedIndex;
                }
                this.m_UncommittedSelectedIndex = false;
            }
            super.commitProperties();
            return;
        }// end function

        override protected function get focusRoot() : DisplayObjectContainer
        {
            return this.m_UINavigator.selectedChild;
        }// end function

        override protected function createChildren() : void
        {
            var _loc_1:* = 0;
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UINavigator = new SimpleTabNavigator();
                this.m_UINavigator.percentHeight = 100;
                this.m_UINavigator.percentWidth = 100;
                this.m_UINavigator.styleName = "optionsConfigurationWidgetTabNavigator";
                addChild(this.m_UINavigator);
                _loc_1 = 0;
                while (_loc_1 < this.m_UIOptionsEditor.length)
                {
                    
                    this.m_UIOptionsEditor[_loc_1].creationPolicy = ContainerCreationPolicy.NONE;
                    this.m_UIOptionsEditor[_loc_1].options = this.m_Options;
                    this.m_UIOptionsEditor[_loc_1].percentHeight = 100;
                    this.m_UIOptionsEditor[_loc_1].percentWidth = 100;
                    this.m_UIOptionsEditor[_loc_1].styleName = "optionsConfigurationWidgetTabContainer";
                    this.m_UIOptionsEditor[_loc_1].addEventListener(OptionsEditorEvent.VALUE_CHANGE, this.onValueChange);
                    this.m_UINavigator.addChild(this.m_UIOptionsEditor[_loc_1] as DisplayObject);
                    _loc_1++;
                }
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function getEditor(param1:int) : IOptionsEditor
        {
            return this.m_UIOptionsEditor[param1];
        }// end function

        protected function onValueChange(event:OptionsEditorEvent) : void
        {
            if (this.m_EventHandlerActive)
            {
                return;
            }
            this.m_EventHandlerActive = true;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_UIOptionsEditor.length)
            {
                
                if (event != null && event.currentTarget != this.m_UIOptionsEditor[_loc_2])
                {
                    this.m_UIOptionsEditor[_loc_2].dispatchEvent(event.clone());
                }
                _loc_2++;
            }
            this.m_EventHandlerActive = false;
            return;
        }// end function

        public function set selectedIndex(param1:int) : void
        {
            param1 = Math.max(0, Math.min(param1, (this.m_UIOptionsEditor.length - 1)));
            if (this.m_SelectedIndex != param1)
            {
                this.m_SelectedIndex = param1;
                this.m_UncommittedSelectedIndex = true;
                invalidateProperties();
                invalidateFocus();
            }
            return;
        }// end function

        public function get selectedIndex() : int
        {
            return this.m_SelectedIndex;
        }// end function

        public function set options(param1:OptionsStorage) : void
        {
            this.m_Options = param1;
            this.m_UncommittedOptions = true;
            invalidateProperties();
            return;
        }// end function

        override public function show() : void
        {
            this.options = Tibia.s_GetOptions().clone();
            super.show();
            return;
        }// end function

    }
}
