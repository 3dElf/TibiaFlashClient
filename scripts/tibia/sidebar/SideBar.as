package tibia.sidebar
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.events.*;

    public class SideBar extends EventDispatcher
    {
        private var m_Visible:Boolean = false;
        private var m_WidgetID:Vector.<int> = null;
        private var m_FoldHeader:Boolean = false;
        private var m_Location:int = -1;
        private var m_SideBarSet:SideBarSet = null;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function SideBar(param1:SideBarSet, param2:int)
        {
            this.m_SideBarSet = param1;
            this.m_Location = param2;
            this.m_WidgetID = new Vector.<int>;
            return;
        }// end function

        public function getWidgetInstanceAt(param1:int) : Widget
        {
            return this.m_SideBarSet.getWidgetByID(this.m_WidgetID[param1]);
        }// end function

        function addWidget(param1:Widget) : Widget
        {
            return this.addWidgetAt(param1, this.m_WidgetID.length);
        }// end function

        public function get sideBarSet() : SideBarSet
        {
            return this.m_SideBarSet;
        }// end function

        public function getWidgetIndexByID(param1:int) : int
        {
            var _loc_2:* = this.m_WidgetID.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (this.m_WidgetID[_loc_2] == param1)
                {
                    return _loc_2;
                }
                _loc_2 = _loc_2 - 1;
            }
            return -1;
        }// end function

        private function set _1669917202foldHeader(param1:Boolean) : void
        {
            if (this.m_FoldHeader != param1)
            {
                this.m_FoldHeader = param1;
            }
            return;
        }// end function

        public function reset() : void
        {
            this.m_SideBarSet = null;
            this.removeAllWidgets();
            return;
        }// end function

        private function set _466743410visible(param1:Boolean) : void
        {
            if (this.m_Visible != param1)
            {
                this.m_Visible = param1;
            }
            return;
        }// end function

        public function set foldHeader(param1:Boolean) : void
        {
            var _loc_2:* = this.foldHeader;
            if (_loc_2 !== param1)
            {
                this._1669917202foldHeader = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foldHeader", _loc_2, param1));
            }
            return;
        }// end function

        function addWidgetAt(param1:Widget, param2:int) : Widget
        {
            if (param1 == null)
            {
                return null;
            }
            if (param2 >= 0 && param2 < this.m_WidgetID.length)
            {
                this.m_WidgetID.splice(param2, 0, param1.ID);
            }
            else
            {
                param2 = this.m_WidgetID.length;
                this.m_WidgetID.push(param1.ID);
            }
            var _loc_3:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_3.kind = CollectionEventKind.ADD;
            _loc_3.location = param2;
            _loc_3.items = [param1];
            dispatchEvent(_loc_3);
            return param1;
        }// end function

        public function getWidgetInstanceIndex(param1:Widget) : int
        {
            if (param1 != null)
            {
                return this.getWidgetIndexByID(param1.ID);
            }
            return -1;
        }// end function

        public function set visible(param1:Boolean) : void
        {
            var _loc_2:* = this.visible;
            if (_loc_2 !== param1)
            {
                this._466743410visible = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "visible", _loc_2, param1));
            }
            return;
        }// end function

        public function get length() : int
        {
            return this.m_WidgetID.length;
        }// end function

        public function getWidgetIDAt(param1:int) : int
        {
            return this.m_WidgetID[param1];
        }// end function

        function setWidgetIndex(param1:Widget, param2:int) : Widget
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 == null)
            {
                return null;
            }
            var _loc_3:* = this.getWidgetInstanceIndex(param1);
            if (_loc_3 < 0)
            {
                return null;
            }
            if (param2 < 0 || param2 > (this.m_WidgetID.length - 1))
            {
                param2 = this.m_WidgetID.length - 1;
            }
            if (_loc_3 != param2)
            {
                _loc_4 = 0;
                if (_loc_3 > param2)
                {
                    _loc_4 = _loc_3;
                    while (_loc_4 > param2)
                    {
                        
                        this.m_WidgetID[_loc_4] = this.m_WidgetID[(_loc_4 - 1)];
                        _loc_4 = _loc_4 - 1;
                    }
                }
                if (_loc_3 < param2)
                {
                    _loc_4 = _loc_3;
                    while (_loc_4 < param2)
                    {
                        
                        this.m_WidgetID[_loc_4] = this.m_WidgetID[(_loc_4 + 1)];
                        _loc_4++;
                    }
                }
                this.m_WidgetID[param2] = param1.ID;
                _loc_5 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_5.kind = CollectionEventKind.MOVE;
                _loc_5.oldLocation = _loc_3;
                _loc_5.location = param2;
                _loc_5.items = [param1];
                dispatchEvent(_loc_5);
            }
            return param1;
        }// end function

        public function get foldHeader() : Boolean
        {
            return this.m_FoldHeader;
        }// end function

        function removeWidget(param1:Widget) : Widget
        {
            return this.removeWidgetAt(this.getWidgetInstanceIndex(param1));
        }// end function

        public function get visible() : Boolean
        {
            return this.m_Visible;
        }// end function

        public function get location() : int
        {
            return this.m_Location;
        }// end function

        function removeAllWidgets() : void
        {
            this.m_WidgetID.length = 0;
            var _loc_1:* = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            _loc_1.kind = CollectionEventKind.RESET;
            dispatchEvent(_loc_1);
            return;
        }// end function

        function removeWidgetAt(param1:int) : Widget
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1 >= 0 && param1 < this.m_WidgetID.length)
            {
                _loc_2 = this.m_SideBarSet.getWidgetByID(this.m_WidgetID.splice(param1, 1)[0]);
                _loc_3 = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
                _loc_3.kind = CollectionEventKind.REMOVE;
                _loc_3.location = param1;
                _loc_3.items = [_loc_2];
                dispatchEvent(_loc_3);
                return _loc_2;
            }
            return null;
        }// end function

    }
}
