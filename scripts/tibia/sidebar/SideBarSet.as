package tibia.sidebar
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.core.*;
    import mx.events.*;

    public class SideBarSet extends EventDispatcher
    {
        protected var m_DefaultLocations:Vector.<int> = null;
        protected var m_SideBars:Vector.<SideBar> = null;
        protected var m_ID:int = -1;
        private var m_PoolFreeID:int = 0;
        protected var m_Widgets:Vector.<Widget> = null;
        public static const DEFAULT_SET:int = 0;
        public static const NUM_LOCATIONS:int = 4;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 1;
        public static const LOCATION_A:int = 2;
        public static const LOCATION_B:int = 0;
        public static const LOCATION_C:int = 1;
        public static const LOCATION_D:int = 3;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function SideBarSet(param1:int)
        {
            this.m_ID = param1;
            this.m_DefaultLocations = new Vector.<int>(Widget.TYPES_BEYONDLAST, true);
            var _loc_2:* = 0;
            _loc_2 = this.m_DefaultLocations.length - 1;
            while (_loc_2 >= 0)
            {
                
                this.m_DefaultLocations[_loc_2] = SideBarSet.LOCATION_C;
                _loc_2 = _loc_2 - 1;
            }
            this.m_SideBars = new Vector.<SideBar>(SideBarSet.NUM_LOCATIONS, true);
            _loc_2 = this.m_SideBars.length - 1;
            while (_loc_2 >= 0)
            {
                
                this.m_SideBars[_loc_2] = new SideBar(this, _loc_2);
                this.m_SideBars[_loc_2].addEventListener(CollectionEvent.COLLECTION_CHANGE, this.onSideBarEvent, false, EventPriority.DEFAULT_HANDLER, false);
                this.m_SideBars[_loc_2].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onSideBarEvent, false, EventPriority.DEFAULT_HANDLER, false);
                _loc_2 = _loc_2 - 1;
            }
            this.m_Widgets = new Vector.<Widget>;
            return;
        }// end function

        public function getWidgetLength() : int
        {
            return this.m_Widgets.length;
        }// end function

        public function showWidgetByID(param1:int, param2:int, param3:int) : Widget
        {
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (!SideBarSet.s_CheckLocation(param2))
            {
                return null;
            }
            var _loc_4:* = this.poolGetWidget(param1);
            if (this.poolGetWidget(param1) != null)
            {
                _loc_5 = false;
                _loc_6 = true;
                _loc_7 = this.m_SideBars.length - 1;
                while (_loc_6 && _loc_7 >= 0)
                {
                    
                    _loc_8 = this.m_SideBars[_loc_7].length - 1;
                    while (_loc_6 && _loc_8 >= 0)
                    {
                        
                        if (this.m_SideBars[_loc_7].getWidgetIDAt(_loc_8) == _loc_4.ID)
                        {
                            if (_loc_7 == param2)
                            {
                                _loc_5 = true;
                            }
                            else
                            {
                                this.m_SideBars[_loc_7].removeWidgetAt(_loc_8);
                                _loc_5 = false;
                            }
                            _loc_6 = false;
                        }
                        _loc_8 = _loc_8 - 1;
                    }
                    _loc_7 = _loc_7 - 1;
                }
                if (Widget.s_GetUnique(_loc_4.type))
                {
                    this.setDefaultLocation(_loc_4.type, param2);
                }
                if (_loc_5)
                {
                    this.m_SideBars[param2].setWidgetIndex(_loc_4, param3);
                }
                else
                {
                    this.m_SideBars[param2].addWidgetAt(_loc_4, param3);
                }
            }
            return _loc_4;
        }// end function

        private function poolFreeID() : int
        {
            if (this.m_Widgets.length >= int.MAX_VALUE)
            {
                return -1;
            }
            while (true)
            {
                
                if (this.poolGetIndex(this.m_PoolFreeID) < 0)
                {
                    break;
                    continue;
                }
                if (this.m_PoolFreeID < int.MAX_VALUE)
                {
                    var _loc_1:* = this;
                    var _loc_2:* = this.m_PoolFreeID + 1;
                    _loc_1.m_PoolFreeID = _loc_2;
                    continue;
                }
                this.m_PoolFreeID = 0;
            }
            return this.m_PoolFreeID;
        }// end function

        protected function onSideBarEvent(event:Event) : void
        {
            var _loc_2:* = null;
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                switch(event.type)
                {
                    case CollectionEvent.COLLECTION_CHANGE:
                    case PropertyChangeEvent.PROPERTY_CHANGE:
                    {
                        _loc_2 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                        _loc_2.kind = PropertyChangeEventKind.UPDATE;
                        _loc_2.property = "sideBarInstanceOptions";
                        _loc_2.source = event.currentTarget;
                        dispatchEvent(_loc_2);
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

        public function initialiseDefaultWidgets() : void
        {
            var _loc_1:* = this.m_DefaultLocations.length - 1;
            while (_loc_1 >= 0)
            {
                
                this.m_DefaultLocations[_loc_1] = SideBarSet.LOCATION_C;
                _loc_1 = _loc_1 - 1;
            }
            this.getSideBar(LOCATION_C).visible = true;
            this.showWidgetType(Widget.TYPE_GENERALBUTTONS, LOCATION_C, -1);
            this.showWidgetType(Widget.TYPE_MINIMAP, LOCATION_C, -1);
            return;
        }// end function

        public function getSideBar(param1:int) : SideBar
        {
            if (!SideBarSet.s_CheckLocation(param1))
            {
                return null;
            }
            return this.m_SideBars[param1];
        }// end function

        public function hideWidgetType(param1:int, param2:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (!Widget.s_CheckType(param1))
            {
                return;
            }
            if (param2 > -1 && !SideBarSet.s_CheckLocation(param2))
            {
                return;
            }
            var _loc_3:* = this.m_SideBars.length - 1;
            while (_loc_3 >= 0)
            {
                
                _loc_4 = this.m_SideBars[_loc_3].length - 1;
                while ((param2 < 0 || param2 == _loc_3) && _loc_4 >= 0)
                {
                    
                    _loc_5 = this.m_SideBars[_loc_3].getWidgetInstanceAt(_loc_4);
                    if (_loc_5.type == param1)
                    {
                        _loc_5.releaseViewInstance();
                        this.m_SideBars[_loc_3].removeWidgetAt(_loc_4);
                        if (!Widget.s_GetUnique(_loc_5.type) || !Widget.s_GetRestorable(_loc_5.type))
                        {
                            this.poolRemoveWidget(_loc_5.ID);
                        }
                    }
                    _loc_4 = _loc_4 - 1;
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        private function poolAddWidget(param1:Widget) : Widget
        {
            var _loc_2:* = 0;
            if (param1 == null)
            {
                return null;
            }
            if (Widget.s_GetUnique(param1.type))
            {
                _loc_2 = this.m_Widgets.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (this.m_Widgets[_loc_2].type == param1.type)
                    {
                        return null;
                    }
                    _loc_2 = _loc_2 - 1;
                }
            }
            _loc_2 = this.poolGetIndex(param1.ID);
            if (_loc_2 > -1)
            {
                return null;
            }
            this.m_Widgets.splice(-_loc_2 - 1, 0, param1);
            param1.addEventListener(Widget.EVENT_CLOSE, this.onWidgetEvent, false, EventPriority.DEFAULT_HANDLER, false);
            param1.addEventListener(Widget.EVENT_OPTIONS_CHANGE, this.onWidgetEvent, false, EventPriority.DEFAULT_HANDLER, false);
            return param1;
        }// end function

        public function getWidgetByType(param1:int) : Widget
        {
            if (!Widget.s_CheckType(param1))
            {
                return null;
            }
            var _loc_2:* = this.m_Widgets.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_Widgets[_loc_2].type == param1)
                {
                    return this.m_Widgets[_loc_2];
                }
                _loc_2 = _loc_2 - 1;
            }
            return null;
        }// end function

        public function getWidgetByID(param1:int) : Widget
        {
            return this.poolGetWidget(param1);
        }// end function

        public function countWidgetType(param1:int, param2:int) : int
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            if (!Widget.s_CheckType(param1))
            {
                return 0;
            }
            if (param2 > -1 && !SideBarSet.s_CheckLocation(param2))
            {
                return 0;
            }
            var _loc_3:* = 0;
            var _loc_4:* = this.m_SideBars.length - 1;
            while (_loc_4 >= 0)
            {
                
                if (param2 < 0 || param2 == _loc_4)
                {
                    _loc_5 = this.m_SideBars[_loc_4];
                    _loc_6 = _loc_5.length - 1;
                    while (_loc_6 >= 0)
                    {
                        
                        _loc_7 = _loc_5.getWidgetInstanceAt(_loc_6);
                        if (_loc_7.type == param1)
                        {
                            _loc_3++;
                        }
                        _loc_6 = _loc_6 - 1;
                    }
                }
                _loc_4 = _loc_4 - 1;
            }
            return _loc_3;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<sidebarset id=\"" + this.m_ID + "\" defaultLocation=\"" + this.m_DefaultLocations.join(",") + "\"/>");
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = <widgetset/>;
            _loc_2 = 0;
            _loc_4 = this.m_Widgets.length;
            while (_loc_2 < _loc_4)
            {
                
                if (Widget.s_GetRestorable(this.m_Widgets[_loc_2].type))
                {
                    _loc_6.appendChild(this.m_Widgets[_loc_2].marshall());
                }
                _loc_2++;
            }
            _loc_1.appendChild(_loc_6);
            var _loc_7:* = null;
            var _loc_8:* = 0;
            _loc_2 = 0;
            _loc_4 = this.m_SideBars.length;
            while (_loc_2 < _loc_4)
            {
                
                _loc_7 = new XML("<sidebar foldHeader=\"" + this.m_SideBars[_loc_2].foldHeader + "\" location=\"" + this.m_SideBars[_loc_2].location + "\" visible=\"" + this.m_SideBars[_loc_2].visible + "\"/>");
                _loc_3 = 0;
                _loc_5 = this.m_SideBars[_loc_2].length;
                while (_loc_3 < _loc_5)
                {
                    
                    _loc_8 = this.m_SideBars[_loc_2].getWidgetIDAt(_loc_3);
                    if (Widget.s_GetRestorable(this.poolGetWidget(_loc_8).type))
                    {
                        _loc_7.appendChild(new XML("<widgetref id=\"" + _loc_8 + "\"/>"));
                    }
                    _loc_3++;
                }
                _loc_1.appendChild(_loc_7);
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function getSideBarLength() : int
        {
            return this.m_SideBars.length;
        }// end function

        public function setDefaultLocation(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            if (!Widget.s_CheckType(param1))
            {
                return;
            }
            if (!SideBarSet.s_CheckLocation(param2))
            {
                return;
            }
            if (this.m_DefaultLocations[param1] != param2)
            {
                this.m_DefaultLocations[param1] = param2;
                _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_3.property = "defaultLocation";
                _loc_3.kind = PropertyChangeEventKind.UPDATE;
                dispatchEvent(_loc_3);
                if (param1 == Widget.TYPE_NPCTRADE)
                {
                    this.setDefaultLocation(Widget.TYPE_SAFETRADE, param2);
                }
                if (param1 == Widget.TYPE_SAFETRADE)
                {
                    this.setDefaultLocation(Widget.TYPE_NPCTRADE, param2);
                }
            }
            return;
        }// end function

        protected function onWidgetEvent(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null && (!event.cancelable || !event.isDefaultPrevented()))
            {
                _loc_2 = Widget(event.currentTarget);
                switch(event.type)
                {
                    case Widget.EVENT_CLOSE:
                    {
                        this.hideWidgetByID(_loc_2.ID);
                        break;
                    }
                    case Widget.EVENT_OPTIONS_CHANGE:
                    {
                        if (Widget.s_GetUnique(_loc_2.type) && Widget.s_GetRestorable(_loc_2.type))
                        {
                            _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                            _loc_3.kind = PropertyChangeEventKind.UPDATE;
                            _loc_3.property = "widgetInstanceOptions";
                            _loc_3.source = _loc_2;
                            dispatchEvent(_loc_3);
                        }
                        break;
                    }
                    default:
                    {
                        dispatchEvent(event);
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function poolGetIndex(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = this.m_Widgets.length - 1;
            while (_loc_3 <= _loc_4)
            {
                
                _loc_2 = _loc_3 + _loc_4 >>> 1;
                if (this.m_Widgets[_loc_2].ID < param1)
                {
                    _loc_3 = _loc_2 + 1;
                    continue;
                }
                if (this.m_Widgets[_loc_2].ID > param1)
                {
                    _loc_4 = _loc_2 - 1;
                    continue;
                }
                return _loc_2;
            }
            return -_loc_3 - 1;
        }// end function

        public function closeVolatileWidgets() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.m_Widgets.length - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = this.m_Widgets[_loc_1];
                if (_loc_2 != null && (!Widget.s_GetUnique(_loc_2.type) || !Widget.s_GetRestorable(_loc_2.type)))
                {
                    this.hideWidgetByID(_loc_2.ID);
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public function insertOrphanWidget(param1:Widget, param2:int, param3:int) : void
        {
            if (param1 == null)
            {
                return;
            }
            this.poolAddWidget(param1);
            this.showWidgetByID(param1.ID, param2, param3);
            return;
        }// end function

        public function getDefaultLocation(param1:int) : int
        {
            return this.m_DefaultLocations[param1];
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        private function poolRemoveWidget(param1:int) : Widget
        {
            var _loc_2:* = null;
            var _loc_3:* = this.poolGetIndex(param1);
            if (_loc_3 > -1)
            {
                _loc_2 = this.m_Widgets.splice(_loc_3, 1)[0];
                _loc_2.removeEventListener(Widget.EVENT_CLOSE, this.onWidgetEvent);
                _loc_2.removeEventListener(Widget.EVENT_OPTIONS_CHANGE, this.onWidgetEvent);
            }
            if (_loc_2 != null)
            {
                _loc_2.options = null;
                _loc_2.releaseViewInstance();
            }
            return _loc_2;
        }// end function

        public function hideAllWidgets() : void
        {
            var _loc_1:* = this.m_Widgets.length - 1;
            while (_loc_1 >= 0)
            {
                
                if (this.m_Widgets[_loc_1] != null)
                {
                    this.hideWidgetByID(this.m_Widgets[_loc_1].ID);
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public function hideWidgetByID(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this.m_SideBars.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this.m_SideBars[_loc_2].length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_4 = this.m_SideBars[_loc_2].getWidgetInstanceAt(_loc_3);
                    if (_loc_4.ID == param1)
                    {
                        _loc_4.releaseViewInstance();
                        this.m_SideBars[_loc_2].removeWidgetAt(_loc_3);
                        if (!Widget.s_GetUnique(_loc_4.type) || !Widget.s_GetRestorable(_loc_4.type))
                        {
                            this.poolRemoveWidget(param1);
                        }
                        return;
                    }
                    _loc_3 = _loc_3 - 1;
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function showWidgetType(param1:int, param2:int, param3:int) : Widget
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            if (!Widget.s_CheckType(param1))
            {
                return null;
            }
            if (param2 < 0)
            {
                param2 = this.getDefaultLocation(param1);
            }
            if (!SideBarSet.s_CheckLocation(param2))
            {
                return null;
            }
            var _loc_4:* = null;
            var _loc_5:* = false;
            if (Widget.s_GetUnique(param1))
            {
                _loc_6 = 0;
                _loc_7 = 0;
                _loc_6 = this.m_Widgets.length - 1;
                while (_loc_6 >= 0)
                {
                    
                    if (this.m_Widgets[_loc_6].type == param1)
                    {
                        _loc_4 = this.m_Widgets[_loc_6];
                        break;
                    }
                    _loc_6 = _loc_6 - 1;
                }
                _loc_8 = _loc_4 != null;
                _loc_6 = this.m_SideBars.length - 1;
                while (_loc_8 && _loc_6 >= 0)
                {
                    
                    _loc_7 = this.m_SideBars[_loc_6].length - 1;
                    while (_loc_8 && _loc_7 >= 0)
                    {
                        
                        if (this.m_SideBars[_loc_6].getWidgetIDAt(_loc_7) == _loc_4.ID)
                        {
                            if (_loc_6 == param2)
                            {
                                _loc_5 = true;
                            }
                            else
                            {
                                this.m_SideBars[_loc_6].removeWidgetAt(_loc_7);
                                _loc_5 = false;
                            }
                            _loc_8 = false;
                        }
                        _loc_7 = _loc_7 - 1;
                    }
                    _loc_6 = _loc_6 - 1;
                }
                this.setDefaultLocation(param1, param2);
            }
            if (_loc_4 == null)
            {
                _loc_4 = this.poolAddWidget(Widget.s_CreateInstance(param1, this.poolFreeID()));
            }
            if (_loc_5)
            {
                return this.m_SideBars[param2].setWidgetIndex(_loc_4, param3);
            }
            return this.m_SideBars[param2].addWidgetAt(_loc_4, param3);
        }// end function

        private function poolGetWidget(param1:int) : Widget
        {
            var _loc_2:* = this.poolGetIndex(param1);
            if (_loc_2 > -1)
            {
                return this.m_Widgets[_loc_2];
            }
            return null;
        }// end function

        public static function s_CheckLocation(param1:int) : Boolean
        {
            return param1 == SideBarSet.LOCATION_A || param1 == SideBarSet.LOCATION_B || param1 == SideBarSet.LOCATION_C || param1 == SideBarSet.LOCATION_D;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : SideBarSet
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            if (param1 == null || param1.localName() != "sidebarset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("SideBarSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_16:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_16 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_4 = parseInt(_loc_3[0].toString());
            var _loc_5:* = new SideBarSet(_loc_4);
            var _loc_16:* = param1.@defaultLocation;
            _loc_3 = param1.@defaultLocation;
            if (_loc_16 != null && _loc_3.length() == 1)
            {
                _loc_8 = _loc_3[0].toString().split(",");
                _loc_9 = _loc_8.length - 1;
                while (_loc_9 >= 0)
                {
                    
                    _loc_10 = parseInt(_loc_8[_loc_9]);
                    if (Widget.s_CheckType(_loc_9) && SideBarSet.s_CheckLocation(_loc_10))
                    {
                        _loc_5.setDefaultLocation(_loc_9, _loc_10);
                    }
                    _loc_9 = _loc_9 - 1;
                }
            }
            for each (_loc_6 in param1.elements("widgetset"))
            {
                
                for each (_loc_11 in _loc_6.elements("widget"))
                {
                    
                    _loc_12 = Widget.s_Unmarshall(_loc_11, param2);
                    if (_loc_12 != null)
                    {
                        _loc_5.poolAddWidget(_loc_12);
                    }
                }
            }
            for each (_loc_7 in param1.elements("sidebar"))
            {
                
                var _loc_18:* = _loc_7.@location;
                _loc_3 = _loc_7.@location;
                if (_loc_18 == null || _loc_3.length() != 1)
                {
                    continue;
                }
                _loc_13 = parseInt(_loc_3[0].toString());
                if (!SideBarSet.s_CheckLocation(_loc_13))
                {
                    continue;
                }
                var _loc_18:* = _loc_7.@visible;
                _loc_3 = _loc_7.@visible;
                if (_loc_18 != null && _loc_3.length() == 1)
                {
                    _loc_5.getSideBar(_loc_13).visible = _loc_3[0].toString() == "true";
                }
                var _loc_18:* = _loc_7.@foldHeader;
                _loc_3 = _loc_7.@foldHeader;
                if (_loc_18 != null && _loc_3.length() == 1)
                {
                    _loc_5.getSideBar(_loc_13).foldHeader = _loc_3[0].toString() == "true";
                }
                for each (_loc_14 in _loc_7.elements("widgetref"))
                {
                    
                    var _loc_20:* = _loc_14.@id;
                    _loc_3 = _loc_14.@id;
                    if (_loc_20 == null || _loc_3.length() != 1)
                    {
                        continue;
                    }
                    _loc_15 = parseInt(_loc_3[0].toString());
                    if (_loc_5.poolGetWidget(_loc_15) != null)
                    {
                        _loc_5.showWidgetByID(_loc_15, _loc_13, -1);
                    }
                }
            }
            return _loc_5;
        }// end function

    }
}
