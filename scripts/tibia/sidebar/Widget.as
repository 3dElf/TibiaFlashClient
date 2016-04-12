package tibia.sidebar
{
    import flash.events.*;
    import mx.events.*;
    import tibia.container.*;
    import tibia.container.bodyContainerViewWigdetClasses.*;
    import tibia.container.containerViewWidgetClasses.*;
    import tibia.creatures.*;
    import tibia.creatures.battlelistWidgetClasses.*;
    import tibia.creatures.buddylistWidgetClasses.*;
    import tibia.creatures.unjustPointsWidgetClasses.*;
    import tibia.magic.*;
    import tibia.magic.spellListWidgetClasses.*;
    import tibia.minimap.*;
    import tibia.minimap.miniMapWidgetClasses.*;
    import tibia.options.*;
    import tibia.premium.*;
    import tibia.premium.premiumWidgetClasses.*;
    import tibia.sidebar.sideBarWidgetClasses.*;
    import tibia.trade.*;
    import tibia.trade.npcTradeWidgetClasses.*;
    import tibia.trade.safeTradeWidgetClasses.*;

    public class Widget extends EventDispatcher
    {
        protected var m_ViewInstance:WidgetView = null;
        protected var m_Height:Number = NaN;
        protected var m_Closed:Boolean = true;
        protected var m_Collapsed:Boolean = false;
        protected var m_ID:int = -1;
        protected var m_Type:int = -1;
        protected var m_Options:OptionsStorage = null;
        public static const TYPE_MINIMAP:int = 5;
        public static const TYPE_COMBATCONTROL:int = 6;
        public static const TYPE_GENERALBUTTONS:int = 3;
        public static const TYPE_BODY:int = 4;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const TYPES_BEYONDLAST:int = 12;
        public static const TYPE_UNJUSTPOINTS:int = 11;
        public static const EVENT_CLOSE:String = "close";
        public static const TYPE_NPCTRADE:int = 7;
        public static const EVENT_OPTIONS_CHANGE:String = "optionsChange";
        public static const TYPE_SAFETRADE:int = 8;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;
        public static const TYPE_CONTAINER:int = 2;
        private static const TYPE_DATA:Array = [{type:TYPE_BATTLELIST, unique:true, restorable:true, closable:true, collapsible:true, resizable:true, viewClass:BattlelistWidgetView}, {type:TYPE_BUDDYLIST, unique:true, restorable:true, closable:true, collapsible:true, resizable:true, viewClass:BuddylistWidgetView}, {type:TYPE_CONTAINER, unique:false, restorable:false, closable:true, collapsible:true, resizable:true, viewClass:ContainerViewWidgetView}, {type:TYPE_GENERALBUTTONS, unique:true, restorable:true, closable:true, collapsible:true, resizable:false, viewClass:GeneralButtonsWidgetView}, {type:TYPE_BODY, unique:true, restorable:true, closable:true, collapsible:true, resizable:false, viewClass:BodyContainerViewWidgetView}, {type:TYPE_MINIMAP, unique:true, restorable:true, closable:true, collapsible:true, resizable:false, viewClass:MiniMapWidgetView}, {type:TYPE_COMBATCONTROL, unique:true, restorable:true, closable:true, collapsible:true, resizable:false, viewClass:CombatControlWidgetView}, {type:TYPE_NPCTRADE, unique:false, restorable:false, closable:true, collapsible:true, resizable:true, viewClass:NPCTradeWidgetView}, {type:TYPE_SAFETRADE, unique:false, restorable:false, closable:true, collapsible:true, resizable:true, viewClass:SafeTradeWidgetView}, {type:TYPE_SPELLLIST, unique:true, restorable:true, closable:true, collapsible:true, resizable:true, viewClass:SpellListWidgetView}, {type:TYPE_PREMIUM, unique:true, restorable:false, closable:false, collapsible:true, resizable:false, viewClass:PremiumWidgetView}, {type:TYPE_UNJUSTPOINTS, unique:true, restorable:true, closable:true, collapsible:true, resizable:false, viewClass:UnjustPointsWidgetView}];
        public static const TYPE_SPELLLIST:int = 9;
        public static const TYPE_PREMIUM:int = 10;
        public static const TYPE_BATTLELIST:int = 0;
        public static const TYPE_BUDDYLIST:int = 1;

        public function Widget()
        {
            return;
        }// end function

        public function get options() : OptionsStorage
        {
            return this.m_Options;
        }// end function

        public function releaseViewInstance() : void
        {
            if (this.m_ViewInstance is WidgetView)
            {
                this.m_ViewInstance.options = null;
                this.m_ViewInstance.widgetInstance = null;
                this.m_ViewInstance.widgetClosable = false;
                this.m_ViewInstance.widgetClosed = false;
                this.m_ViewInstance.widgetCollapsed = false;
                this.m_ViewInstance.widgetCollapsible = false;
                this.m_ViewInstance.widgetHeight = NaN;
                this.m_ViewInstance.widgetResizable = false;
                this.m_ViewInstance.releaseInstance();
                this.m_ViewInstance = null;
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
                this.commitOptions();
                if (this.m_ViewInstance != null)
                {
                    this.m_ViewInstance.options = this.m_Options;
                }
            }
            return;
        }// end function

        protected function commitOptions() : void
        {
            return;
        }// end function

        public function get draggable() : Boolean
        {
            return true;
        }// end function

        public function set height(param1:Number) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            if (this.m_Height != param1)
            {
                _loc_2 = this.m_Height;
                this.m_Height = param1;
                _loc_3 = new Event(EVENT_OPTIONS_CHANGE, false, true);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_Height = _loc_2;
                }
                if (this.m_ViewInstance != null)
                {
                    this.m_ViewInstance.widgetHeight = this.m_Height;
                }
            }
            return;
        }// end function

        protected function onOptionsChange(event:PropertyChangeEvent) : void
        {
            return;
        }// end function

        public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            if (param1 && this.m_ViewInstance == null)
            {
                this.m_ViewInstance = WidgetView(new TYPE_DATA[this.m_Type].viewClass);
            }
            if (this.m_ViewInstance != null)
            {
                this.m_Closed = false;
                this.m_ViewInstance.options = this.options;
                this.m_ViewInstance.widgetClosable = this.closable;
                this.m_ViewInstance.widgetClosed = false;
                this.m_ViewInstance.widgetCollapsed = this.collapsed;
                this.m_ViewInstance.widgetCollapsible = this.collapsible;
                this.m_ViewInstance.widgetHeight = this.height;
                this.m_ViewInstance.widgetInstance = this;
                this.m_ViewInstance.widgetResizable = this.resizable;
            }
            return this.m_ViewInstance;
        }// end function

        public function get collapsible() : Boolean
        {
            return TYPE_DATA[this.m_Type].collapsible;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<widget id=\"" + this.m_ID + "\" type=\"" + this.m_Type + "\" collapsed=\"" + this.m_Collapsed + "\"/>");
            if (!isNaN(this.m_Height))
            {
                _loc_1.@height = this.m_Height;
            }
            return _loc_1;
        }// end function

        public function get collapsed() : Boolean
        {
            return this.m_Collapsed;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get closable() : Boolean
        {
            return TYPE_DATA[this.m_Type].closable;
        }// end function

        public function get resizable() : Boolean
        {
            return TYPE_DATA[this.m_Type].resizable;
        }// end function

        public function get closed() : Boolean
        {
            return this.m_Closed;
        }// end function

        public function set collapsed(param1:Boolean) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (this.m_Collapsed != param1)
            {
                _loc_2 = this.m_Collapsed;
                this.m_Collapsed = param1;
                _loc_3 = new Event(EVENT_OPTIONS_CHANGE, false, true);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_Collapsed = _loc_2;
                }
                if (this.m_ViewInstance != null)
                {
                    this.m_ViewInstance.widgetCollapsed = this.m_Collapsed;
                }
            }
            return;
        }// end function

        public function get height() : Number
        {
            return this.m_Height;
        }// end function

        private function initialise(param1:int, param2:int) : void
        {
            if (this.m_ID > -1)
            {
                throw new Error("Widget.initialise: Widget is already initialised.");
            }
            if (!Widget.s_CheckType(param1))
            {
                throw new ArgumentError("Widget.initialise: Invalid type.");
            }
            this.m_Type = param1;
            this.m_ID = param2;
            this.m_Collapsed = false;
            this.m_Height = NaN;
            this.m_ViewInstance = null;
            return;
        }// end function

        public function close(param1:Boolean = false) : void
        {
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (param1 || this.closable && !this.m_Closed)
            {
                _loc_2 = this.m_Closed;
                this.m_Closed = true;
                _loc_3 = new Event(EVENT_CLOSE, false, true);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_Closed = _loc_2;
                }
                if (this.m_ViewInstance != null)
                {
                    this.m_ViewInstance.widgetClosed = this.m_Closed;
                }
            }
            return;
        }// end function

        public function get type() : int
        {
            return this.m_Type;
        }// end function

        public function unmarshall(param1:XML, param2:int) : void
        {
            if (param1 == null || param1.localName() != "widget" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("Widget.unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_4:* = param1.@collapsed;
            _loc_3 = param1.@collapsed;
            if (this.collapsible && _loc_4 != null && _loc_3.length() == 1)
            {
                this.collapsed = _loc_3[0].toString() == "true";
            }
            var _loc_4:* = param1.@height;
            _loc_3 = param1.@height;
            if (this.resizable && _loc_4 != null && _loc_3.length() == 1)
            {
                this.height = parseFloat(_loc_3[0].toString());
            }
            return;
        }// end function

        static function s_CreateInstance(param1:int, param2:int) : Widget
        {
            if (!Widget.s_CheckType(param1))
            {
                throw new ArgumentError("Widget.s_CreateInstance: Invalid type.");
            }
            var _loc_3:* = null;
            switch(param1)
            {
                case TYPE_BATTLELIST:
                {
                    _loc_3 = new BattlelistWidget();
                    break;
                }
                case TYPE_BUDDYLIST:
                {
                    _loc_3 = new BuddylistWidget();
                    break;
                }
                case TYPE_CONTAINER:
                {
                    _loc_3 = new ContainerViewWidget();
                    break;
                }
                case TYPE_GENERALBUTTONS:
                {
                    _loc_3 = new Widget;
                    break;
                }
                case TYPE_BODY:
                {
                    _loc_3 = new BodyContainerViewWidget();
                    break;
                }
                case TYPE_MINIMAP:
                {
                    _loc_3 = new MiniMapWidget();
                    break;
                }
                case TYPE_COMBATCONTROL:
                {
                    _loc_3 = new CombatControlWidget();
                    break;
                }
                case TYPE_NPCTRADE:
                {
                    _loc_3 = new NPCTradeWidget();
                    break;
                }
                case TYPE_SAFETRADE:
                {
                    _loc_3 = new SafeTradeWidget();
                    break;
                }
                case TYPE_SPELLLIST:
                {
                    _loc_3 = new SpellListWidget();
                    break;
                }
                case TYPE_PREMIUM:
                {
                    _loc_3 = new PremiumWidget();
                    break;
                }
                case TYPE_UNJUSTPOINTS:
                {
                    _loc_3 = new UnjustPointsWidget();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            _loc_3.initialise(param1, param2);
            return _loc_3;
        }// end function

        public static function s_CheckType(param1:int) : Boolean
        {
            var _loc_2:* = 0;
            while (_loc_2 < TYPE_DATA.length)
            {
                
                if (TYPE_DATA[_loc_2].type == param1)
                {
                    return true;
                }
                _loc_2++;
            }
            return false;
        }// end function

        public static function s_GetUnique(param1:int) : Boolean
        {
            if (!Widget.s_CheckType(param1))
            {
                throw new ArgumentError("Widget.s_GetLimit: Invalid type.");
            }
            return TYPE_DATA[param1].unique;
        }// end function

        public static function s_GetRestorable(param1:int) : int
        {
            if (!Widget.s_CheckType(param1))
            {
                throw new ArgumentError("Widget.s_GetLimit: Invalid type.");
            }
            return TYPE_DATA[param1].restorable;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:int) : Widget
        {
            if (param1 == null || param1.localName() != "widget" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("Widget.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_7:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                throw new Error("Widget.s_Unmarshall: Missing attribute \"type\".");
            }
            var _loc_4:* = parseInt(_loc_3[0].toString());
            if (!s_CheckType(_loc_4))
            {
                throw new Error("Widget.s_Unmarshall: Invalid type: " + _loc_4);
            }
            var _loc_7:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_7 == null || _loc_3.length() != 1)
            {
                throw new Error("Widget.s_Unmarshall: Missing attribute \"id\".");
            }
            var _loc_5:* = parseInt(_loc_3[0].toString());
            var _loc_6:* = s_CreateInstance(_loc_4, _loc_5);
            _loc_6.unmarshall(param1, param2);
            return _loc_6;
        }// end function

    }
}
