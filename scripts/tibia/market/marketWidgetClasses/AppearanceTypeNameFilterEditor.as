package tibia.market.marketWidgetClasses
{
    import flash.events.*;
    import flash.utils.*;
    import mx.containers.*;
    import mx.controls.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.input.*;
    import tibia.market.marketWidgetClasses.*;
    import tibia.options.*;

    class AppearanceTypeNameFilterEditor extends VBox implements IAppearanceTypeFilterEditor
    {
        private var m_FilterFunction:Function = null;
        private var m_UIConstructed:Boolean = false;
        private var m_UIName:TextInput = null;
        private var m_NameTrigger:Timer = null;
        private var m_UncommittedName:Boolean = true;
        private var m_Name:String = "";
        private static const BUNDLE:String = "MarketWidget";
        private static const NAME_LENGTH:int = 28;

        function AppearanceTypeNameFilterEditor()
        {
            label = resourceManager.getString(BUNDLE, "NAME_FILTER_EDITOR_LABEL");
            this.m_NameTrigger = new Timer(300, 1);
            this.m_NameTrigger.addEventListener(TimerEvent.TIMER_COMPLETE, this.onNameTrigger);
            var _loc_1:* = Tibia.s_GetOptions();
            if (_loc_1 != null)
            {
                this.filterName = _loc_1.marketBrowserName;
            }
            return;
        }// end function

        private function get filterName() : String
        {
            return this.m_Name;
        }// end function

        public function adjustFilterFunction(param1:AppearanceType) : void
        {
            if (param1 == null || !param1.isMarket)
            {
                return;
            }
            this.filterName = param1.marketName;
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (!this.m_UIConstructed)
            {
                super.createChildren();
                this.m_UIName = new TextInput();
                this.m_UIName.maxChars = NAME_LENGTH;
                this.m_UIName.percentHeight = NaN;
                this.m_UIName.percentWidth = 100;
                this.m_UIName.addEventListener(Event.CHANGE, function (event:Event) : void
            {
                if (!m_NameTrigger.running)
                {
                    m_NameTrigger.start();
                }
                return;
            }// end function
            );
                this.m_UIName.addEventListener(KeyboardEvent.KEY_DOWN, PreventWhitespaceInput);
                this.m_UIName.addEventListener(TextEvent.TEXT_INPUT, PreventWhitespaceInput);
                addChild(this.m_UIName);
                this.m_UIConstructed = true;
            }
            return;
        }// end function

        override protected function commitProperties() : void
        {
            super.commitProperties();
            var _loc_1:* = Tibia.s_GetOptions();
            if (this.m_UncommittedName)
            {
                if (_loc_1 != null)
                {
                    _loc_1.marketBrowserName = this.filterName;
                }
                this.m_UIName.text = this.filterName;
                this.m_UncommittedName = false;
            }
            return;
        }// end function

        public function invalidateFilterFunction() : void
        {
            this.m_FilterFunction = null;
            dispatchEvent(new Event(AppearanceTypeBrowser.FILTER_CHANGE));
            return;
        }// end function

        private function set filterName(param1:String) : void
        {
            if (param1 == null)
            {
                param1 = "";
            }
            else if (param1.length > NAME_LENGTH)
            {
                param1 = param1.substr(0, NAME_LENGTH);
            }
            if (this.m_Name != param1)
            {
                this.m_Name = param1;
                this.m_UncommittedName = true;
                invalidateProperties();
                this.invalidateFilterFunction();
            }
            return;
        }// end function

        private function onNameTrigger(event:TimerEvent) : void
        {
            if (event != null)
            {
                this.m_NameTrigger.stop();
                this.filterName = this.m_UIName.text;
            }
            return;
        }// end function

        public function get filterFunction() : Function
        {
            var _Name:String;
            if (this.m_FilterFunction == null)
            {
                _Name = StringHelper.s_Trim(this.filterName).toLowerCase();
                if (_Name.length < 3)
                {
                    _Name;
                }
                this.m_FilterFunction = closure({name:_Name}, function (param1:AppearanceType) : Boolean
            {
                return param1 != null && param1.isMarket && (this["name"] != null && param1.marketNameLowerCase.indexOf(this["name"]) > -1);
            }// end function
            );
            }
            return this.m_FilterFunction;
        }// end function

    }
}
