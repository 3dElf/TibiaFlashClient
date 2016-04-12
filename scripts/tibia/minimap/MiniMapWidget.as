package tibia.minimap
{
    import flash.events.*;
    import mx.events.*;
    import tibia.minimap.miniMapWidgetClasses.*;
    import tibia.sidebar.*;
    import tibia.sidebar.sideBarWidgetClasses.*;

    public class MiniMapWidget extends Widget
    {
        protected var m_HighlightEnd:Number = 0;
        protected var m_Zoom:int = 0;
        protected var m_PositionX:int = 0;
        protected var m_PositionY:int = 0;
        protected var m_MiniMapStorage:MiniMapStorage = null;
        protected var m_PositionZ:int = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const MM_SECTOR_SIZE:int = 256;
        static const MM_IE_TIMEOUT:Number = 50;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const MM_IO_TIMEOUT:Number = 500;
        static const MM_SIDEBAR_ZOOM_MIN:int = -1;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const MM_COLOUR_DEFAULT:uint = 0;
        static const MM_STORAGE_MIN_VERSION:int = 1;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const MM_SIDEBAR_ZOOM_MAX:int = 2;
        static const MM_SIDEBAR_HIGHLIGHT_DURATION:Number = 10000;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MM_CACHE_SIZE:int = 48;
        static const FIELD_CACHESIZE:int = 32;
        static const MAP_MIN_X:int = 24576;
        static const MM_STORAGE_MAX_VERSION:int = 1;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAPSIZE_Y:int = 14;
        static const MM_SIDEBAR_VIEW_HEIGHT:int = 106;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const MAPSIZE_Z:int = 8;
        static const MAP_WIDTH:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);

        public function MiniMapWidget()
        {
            return;
        }// end function

        override public function releaseViewInstance() : void
        {
            this.miniMapStorage = null;
            super.releaseViewInstance();
            return;
        }// end function

        public function get highlightEnd() : Number
        {
            return this.m_HighlightEnd;
        }// end function

        protected function onMiniMapStorageChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property)
                {
                    case "position":
                    {
                        this.centerPosition();
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

        public function set highlightEnd(param1:Number) : void
        {
            if (this.m_HighlightEnd != param1)
            {
                this.m_HighlightEnd = param1;
                if (m_ViewInstance is MiniMapWidgetView)
                {
                    MiniMapWidgetView(m_ViewInstance).highlightEnd = this.m_HighlightEnd;
                }
            }
            return;
        }// end function

        public function get positionX() : int
        {
            return this.m_PositionX;
        }// end function

        public function get positionZ() : int
        {
            return this.m_PositionZ;
        }// end function

        public function get zoom() : int
        {
            return this.m_Zoom;
        }// end function

        override public function marshall() : XML
        {
            var _loc_1:* = super.marshall();
            _loc_1.@zoom = this.m_Zoom;
            return _loc_1;
        }// end function

        public function translatePosition(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = 3 * Math.pow(2, MM_SIDEBAR_ZOOM_MAX - this.m_Zoom);
            this.setPosition(this.m_PositionX + _loc_4 * param1, this.m_PositionY + _loc_4 * param2, this.m_PositionZ + param3);
            return;
        }// end function

        public function centerPosition() : void
        {
            if (this.m_MiniMapStorage != null)
            {
                this.setPosition(this.m_MiniMapStorage.getPositionX(), this.m_MiniMapStorage.getPositionY(), this.m_MiniMapStorage.getPositionZ());
            }
            else
            {
                this.setPosition(0, 0, 0);
            }
            return;
        }// end function

        public function get positionY() : int
        {
            return this.m_PositionY;
        }// end function

        public function set zoom(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            param1 = Math.max(MM_SIDEBAR_ZOOM_MIN, Math.min(param1, MM_SIDEBAR_ZOOM_MAX));
            if (this.m_Zoom != param1)
            {
                _loc_2 = this.m_Zoom;
                this.m_Zoom = param1;
                _loc_3 = new Event(Widget.EVENT_OPTIONS_CHANGE);
                dispatchEvent(_loc_3);
                if (_loc_3.cancelable && _loc_3.isDefaultPrevented())
                {
                    this.m_Zoom = _loc_2;
                }
                if (m_ViewInstance is MiniMapWidgetView)
                {
                    MiniMapWidgetView(m_ViewInstance).zoom = this.m_Zoom;
                }
            }
            return;
        }// end function

        override public function unmarshall(param1:XML, param2:int) : void
        {
            super.unmarshall(param1, param2);
            var _loc_3:* = null;
            var _loc_4:* = param1.@zoom;
            _loc_3 = param1.@zoom;
            if (_loc_4 != null && _loc_3.length() == 1)
            {
                this.zoom = parseInt(_loc_3[0].toString());
            }
            return;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            param1 = Math.max(MAP_MIN_X, Math.min(param1, MAP_MAX_X));
            param2 = Math.max(MAP_MIN_Y, Math.min(param2, MAP_MAX_Y));
            param3 = Math.max(MAP_MIN_Z, Math.min(param3, MAP_MAX_Z));
            if (this.m_PositionX != param1 || this.m_PositionY != param2 || this.m_PositionZ != param3)
            {
                this.m_PositionX = param1;
                this.m_PositionY = param2;
                this.m_PositionZ = param3;
                if (m_ViewInstance is MiniMapWidgetView)
                {
                    MiniMapWidgetView(m_ViewInstance).setPosition(this.m_PositionX, this.m_PositionY, this.m_PositionZ);
                }
            }
            return;
        }// end function

        public function set miniMapStorage(param1:MiniMapStorage) : void
        {
            if (this.m_MiniMapStorage != param1)
            {
                if (this.m_MiniMapStorage != null)
                {
                    this.m_MiniMapStorage.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMiniMapStorageChange);
                    this.m_MiniMapStorage.removeEventListener(MiniMapStorage.EVENT_HIGHLIGHT_MARKS, this.onMiniMapStorageEvent);
                }
                this.m_MiniMapStorage = param1;
                if (this.m_MiniMapStorage != null)
                {
                    this.m_MiniMapStorage.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMiniMapStorageChange);
                    this.m_MiniMapStorage.addEventListener(MiniMapStorage.EVENT_HIGHLIGHT_MARKS, this.onMiniMapStorageEvent);
                }
                if (m_ViewInstance is MiniMapWidgetView)
                {
                    MiniMapWidgetView(m_ViewInstance).miniMapStorage = this.m_MiniMapStorage;
                }
                this.centerPosition();
            }
            return;
        }// end function

        public function startHighlight() : void
        {
            this.highlightEnd = Tibia.s_FrameTibiaTimestamp + MM_SIDEBAR_HIGHLIGHT_DURATION;
            return;
        }// end function

        protected function onMiniMapStorageEvent(event:Event) : void
        {
            if (event != null)
            {
                switch(event.type)
                {
                    case MiniMapStorage.EVENT_HIGHLIGHT_MARKS:
                    {
                        this.startHighlight();
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

        public function get miniMapStorage() : MiniMapStorage
        {
            return this.m_MiniMapStorage;
        }// end function

        override public function acquireViewInstance(param1:Boolean = true) : WidgetView
        {
            options = Tibia.s_GetOptions();
            this.miniMapStorage = Tibia.s_GetMiniMapStorage();
            var _loc_2:* = super.acquireViewInstance(param1) as MiniMapWidgetView;
            if (_loc_2 != null)
            {
                _loc_2.options = options;
                _loc_2.highlightEnd = this.m_HighlightEnd;
                _loc_2.miniMapStorage = this.m_MiniMapStorage;
                _loc_2.zoom = this.m_Zoom;
                _loc_2.setPosition(this.m_PositionX, this.m_PositionY, this.m_PositionZ);
            }
            return _loc_2;
        }// end function

    }
}
