package tibia.minimap.miniMapWidgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.controls.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.utility.*;
    import tibia.minimap.*;

    public class MiniMapRenderer extends UIComponent
    {
        private var m_UncommittedZoom:Boolean = false;
        protected var m_Zoom:int = -2.14748e+009;
        private var m_UncommittedMiniMapStorage:Boolean = false;
        protected var m_ToolTipInstance:ToolTip = null;
        protected var m_HighlightToggle:Boolean = false;
        private var m_UncommittedHighlightEnd:Boolean = false;
        protected var m_HighlightEnd:Number = 0;
        protected var m_ToolTipPosition:Point = null;
        protected var m_HighlightListenerRegistered:Boolean = false;
        protected var m_ZoomScale:Number = 1;
        protected var m_ToolTipTimer:Timer = null;
        private var m_UncommittedPosition:Boolean = false;
        protected var m_PositionX:int = -1;
        protected var m_PositionY:int = -1;
        protected var m_PositionRect:Rectangle = null;
        protected var m_PositionZ:int = -1;
        protected var m_MiniMapStorage:MiniMapStorage;
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
        static const CROSS_POINTS:Array = [-1, -1, -3, -1, -3, 1, -1, 1, -1, 3, 1, 3, 1, 1, 3, 1, 3, -1, 1, -1, 1, -3, -1, -3, -1, -1];
        static const MAP_WIDTH:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);

        public function MiniMapRenderer()
        {
            this.m_PositionRect = new Rectangle(0, 0, 0, 0);
            this.m_ToolTipPosition = new Point();
            this.m_ToolTipTimer = new Timer(0, 1);
            this.m_ToolTipTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onToolTip);
            addEventListener(MouseEvent.MOUSE_MOVE, this.onToolTip);
            addEventListener(MouseEvent.MOUSE_OUT, this.onToolTip);
            return;
        }// end function

        public function get highlightEnd() : Number
        {
            return this.m_HighlightEnd;
        }// end function

        protected function onToolTip(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (event != null)
            {
                this.hideToolTip();
                switch(event.type)
                {
                    case MouseEvent.MOUSE_MOVE:
                    {
                        this.m_ToolTipPosition.x = (event as MouseEvent).stageX;
                        this.m_ToolTipPosition.y = (event as MouseEvent).stageY;
                        this.m_ToolTipTimer.delay = ToolTipManager.showDelay;
                        this.m_ToolTipTimer.start();
                        break;
                    }
                    case MouseEvent.MOUSE_OUT:
                    {
                        this.m_ToolTipTimer.delay = 0;
                        this.m_ToolTipTimer.stop();
                        break;
                    }
                    case TimerEvent.TIMER_COMPLETE:
                    {
                        _loc_2 = globalToLocal(this.m_ToolTipPosition);
                        _loc_3 = this.pointToMark(_loc_2.x, _loc_2.y);
                        _loc_4 = null;
                        var _loc_5:* = _loc_3.text;
                        _loc_4 = _loc_3.text;
                        if (_loc_3 != null && _loc_5 != null && _loc_4.length > 0)
                        {
                            this.m_ToolTipInstance = ToolTipManager.createToolTip(_loc_4, this.m_ToolTipPosition.x + 10, this.m_ToolTipPosition.y + 10) as ToolTip;
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

        protected function onMiniMapStorageChange(event:PropertyChangeEvent) : void
        {
            if (event != null)
            {
                switch(event.property as String)
                {
                    case "sector":
                    {
                        invalidateDisplayList();
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
                this.m_UncommittedHighlightEnd = true;
                invalidateProperties();
            }
            return;
        }// end function

        public function pointToMark(param1:Number, param2:Number) : Object
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            if (this.m_PositionRect != null && !this.m_PositionRect.isEmpty() && this.m_ZoomScale > 0 && this.m_MiniMapStorage != null)
            {
                _loc_3 = Math.ceil(MiniMapStorage.MARK_ICON_SIZE / 2);
                _loc_4 = 0;
                _loc_5 = Number.POSITIVE_INFINITY;
                _loc_6 = null;
                _loc_7 = new Vector.<MiniMapSector>;
                _loc_8 = 0;
                while (_loc_8 < 4)
                {
                    
                    _loc_9 = this.m_PositionRect.x + _loc_8 % 2 * this.m_PositionRect.width;
                    _loc_10 = this.m_PositionRect.y + int(_loc_8 / 2) * this.m_PositionRect.height;
                    _loc_11 = this.m_MiniMapStorage.acquireSector(_loc_9, _loc_10, this.m_PositionZ, false);
                    if (_loc_11 == null || _loc_7.indexOf(_loc_11) > -1)
                    {
                    }
                    else
                    {
                        _loc_12 = _loc_11.marks;
                        _loc_13 = 0;
                        _loc_14 = _loc_12.length - 1;
                        while (_loc_14 >= 0)
                        {
                            
                            var _loc_15:* = _loc_12[_loc_14];
                            _loc_13 = _loc_12[_loc_14];
                            if (_loc_15 != null)
                            {
                                _loc_4 = Math.max(Math.abs((_loc_13.x - this.m_PositionRect.x) * this.m_ZoomScale - param1), Math.abs((_loc_13.y - this.m_PositionRect.y) * this.m_ZoomScale - param2));
                                if (_loc_4 < _loc_3 && _loc_4 < _loc_5)
                                {
                                    _loc_5 = _loc_4;
                                    _loc_6 = _loc_13;
                                }
                            }
                            _loc_14 = _loc_14 - 1;
                        }
                        _loc_7.push(_loc_11);
                    }
                    _loc_8++;
                }
                return _loc_6;
            }
            return null;
        }// end function

        protected function onTimer(event:TimerEvent) : void
        {
            if (event != null)
            {
                if (Tibia.s_FrameTibiaTimestamp >= this.m_HighlightEnd)
                {
                    this.m_HighlightEnd = 0;
                    this.m_UncommittedHighlightEnd = true;
                    invalidateProperties();
                    this.m_HighlightToggle = false;
                    invalidateDisplayList();
                }
                else if (this.m_HighlightToggle != Tibia.s_GetFrameFlash())
                {
                    this.m_HighlightToggle = Tibia.s_GetFrameFlash();
                    invalidateDisplayList();
                }
            }
            return;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            if (this.m_PositionX != param1 || this.m_PositionY != param2 || this.m_PositionZ != param3)
            {
                this.m_PositionX = param1;
                this.m_PositionY = param2;
                this.m_PositionZ = param3;
                this.m_UncommittedPosition = true;
                invalidateProperties();
                this.m_PositionRect.setEmpty();
            }
            return;
        }// end function

        public function set zoom(param1:int) : void
        {
            if (this.m_Zoom != param1)
            {
                this.m_Zoom = param1;
                this.m_UncommittedZoom = true;
                invalidateProperties();
                this.m_ZoomScale = Math.pow(2, this.m_Zoom);
                this.m_PositionRect.setEmpty();
            }
            return;
        }// end function

        public function get miniMapStorage() : MiniMapStorage
        {
            return this.m_MiniMapStorage;
        }// end function

        protected function hideToolTip() : void
        {
            if (this.m_ToolTipInstance != null)
            {
                ToolTipManager.destroyToolTip(this.m_ToolTipInstance);
                this.m_ToolTipInstance = null;
            }
            return;
        }// end function

        public function pointToAbsolute(param1:Number, param2:Number, param3:Vector3D = null) : Vector3D
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this.m_PositionRect != null && !this.m_PositionRect.isEmpty())
            {
                _loc_4 = this.m_PositionRect.x + param1 / this.m_ZoomScale;
                _loc_5 = this.m_PositionRect.y + param2 / this.m_ZoomScale;
                _loc_6 = this.m_PositionZ;
                if (param3 == null)
                {
                    param3 = new Vector3D(_loc_4, _loc_5, _loc_6);
                }
                else
                {
                    param3.x = _loc_4;
                    param3.y = _loc_5;
                    param3.z = _loc_6;
                }
                return param3;
            }
            return null;
        }// end function

        override protected function commitProperties() : void
        {
            var _loc_1:* = null;
            super.commitProperties();
            if (this.m_UncommittedMiniMapStorage)
            {
                this.hideToolTip();
                invalidateDisplayList();
                this.m_UncommittedMiniMapStorage = false;
            }
            if (this.m_UncommittedZoom)
            {
                this.hideToolTip();
                invalidateDisplayList();
                this.m_UncommittedZoom = false;
            }
            if (this.m_UncommittedPosition)
            {
                this.hideToolTip();
                invalidateDisplayList();
                this.m_UncommittedPosition = false;
            }
            if (this.m_UncommittedHighlightEnd)
            {
                _loc_1 = Tibia.s_GetSecondaryTimer();
                if (Tibia.s_FrameTibiaTimestamp < this.m_HighlightEnd)
                {
                    if (!this.m_HighlightListenerRegistered)
                    {
                        _loc_1.addEventListener(TimerEvent.TIMER, this.onTimer);
                        this.m_HighlightListenerRegistered = true;
                    }
                }
                else if (this.m_HighlightListenerRegistered)
                {
                    _loc_1.removeEventListener(TimerEvent.TIMER, this.onTimer);
                    this.m_HighlightListenerRegistered = false;
                }
                invalidateDisplayList();
                this.m_UncommittedHighlightEnd = false;
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

        public function get positionY() : int
        {
            return this.m_PositionY;
        }// end function

        override protected function measure() : void
        {
            super.measure();
            measuredMinWidth = MM_SIDEBAR_VIEW_WIDTH;
            measuredWidth = MM_SIDEBAR_VIEW_WIDTH;
            measuredMinHeight = MM_SIDEBAR_VIEW_HEIGHT;
            measuredHeight = MM_SIDEBAR_VIEW_HEIGHT;
            return;
        }// end function

        public function set miniMapStorage(param1:MiniMapStorage) : void
        {
            if (this.m_MiniMapStorage != param1)
            {
                if (this.m_MiniMapStorage != null)
                {
                    this.m_MiniMapStorage.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMiniMapStorageChange);
                }
                this.m_MiniMapStorage = param1;
                if (this.m_MiniMapStorage != null)
                {
                    this.m_MiniMapStorage.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.onMiniMapStorageChange);
                }
                this.m_UncommittedMiniMapStorage = true;
                invalidateProperties();
            }
            return;
        }// end function

        override protected function updateDisplayList(param1:Number, param2:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            this.m_PositionRect.setEmpty();
            graphics.clear();
            graphics.beginFill(MM_COLOUR_DEFAULT, 1);
            graphics.drawRect(0, 0, MM_SIDEBAR_VIEW_WIDTH, MM_SIDEBAR_VIEW_HEIGHT);
            if (this.m_MiniMapStorage != null && (this.m_PositionX >= MAP_MIN_X && this.m_PositionX <= MAP_MAX_X) && (this.m_PositionY >= MAP_MIN_Y && this.m_PositionY <= MAP_MAX_Y) && (this.m_PositionZ >= MAP_MIN_Z && this.m_PositionZ <= MAP_MAX_Z))
            {
                _loc_3 = MM_SIDEBAR_VIEW_WIDTH / this.m_ZoomScale;
                _loc_4 = MM_SIDEBAR_VIEW_HEIGHT / this.m_ZoomScale;
                this.m_PositionRect.x = this.m_PositionX - _loc_3 / 2;
                this.m_PositionRect.y = this.m_PositionY - _loc_4 / 2;
                this.m_PositionRect.width = _loc_3;
                this.m_PositionRect.height = _loc_4;
                _loc_5 = new Matrix(this.m_ZoomScale, 0, 0, this.m_ZoomScale, 0, 0);
                _loc_6 = new Vector.<MiniMapSector>;
                _loc_7 = null;
                _loc_8 = new Vector3D();
                _loc_9 = 0;
                _loc_10 = 0;
                _loc_11 = 0;
                _loc_9 = 0;
                while (_loc_9 < 4)
                {
                    
                    _loc_8.x = this.m_PositionRect.x + _loc_9 % 2 * this.m_PositionRect.width;
                    _loc_8.y = this.m_PositionRect.y + int(_loc_9 / 2) * this.m_PositionRect.height;
                    _loc_8.z = this.m_PositionZ;
                    _loc_7 = this.m_MiniMapStorage.acquireSector(_loc_8.x, _loc_8.y, _loc_8.z, false);
                    if (_loc_6.indexOf(_loc_7) > -1)
                    {
                    }
                    else
                    {
                        _loc_6.push(_loc_7);
                        _loc_16 = new Rectangle(_loc_7.getSectorX(), _loc_7.getSectorY(), MM_SECTOR_SIZE, MM_SECTOR_SIZE);
                        _loc_17 = this.m_PositionRect.intersection(_loc_16);
                        _loc_5.tx = (_loc_16.x - this.m_PositionRect.x) * this.m_ZoomScale;
                        _loc_5.ty = (_loc_16.y - this.m_PositionRect.y) * this.m_ZoomScale;
                        graphics.beginBitmapFill(_loc_7.bitmapData, _loc_5, false, false);
                        graphics.drawRect((_loc_17.x - this.m_PositionRect.x) * this.m_ZoomScale, (_loc_17.y - this.m_PositionRect.y) * this.m_ZoomScale, _loc_17.width * this.m_ZoomScale, _loc_17.height * this.m_ZoomScale);
                    }
                    _loc_9++;
                }
                _loc_12 = 0;
                _loc_13 = 0;
                _loc_8.setComponents(this.m_MiniMapStorage.getPositionX(), this.m_MiniMapStorage.getPositionY(), this.m_MiniMapStorage.getPositionZ());
                if (this.m_PositionRect.left <= _loc_8.x && _loc_8.x <= this.m_PositionRect.right && this.m_PositionRect.top <= _loc_8.y && _loc_8.y <= this.m_PositionRect.bottom && this.m_PositionZ == _loc_8.z)
                {
                    _loc_18 = this.m_MiniMapStorage.getFieldColour(_loc_8.x, _loc_8.y, _loc_8.z);
                    if ((_loc_18 & 65280) == 65280)
                    {
                        _loc_18 = 0;
                    }
                    else
                    {
                        _loc_18 = 16777215;
                    }
                    _loc_12 = (_loc_8.x - this.m_PositionRect.left) * this.m_ZoomScale;
                    _loc_13 = (_loc_8.y - this.m_PositionRect.top) * this.m_ZoomScale;
                    graphics.beginFill(_loc_18, 1);
                    graphics.moveTo(_loc_12 + CROSS_POINTS[0], _loc_13 + CROSS_POINTS[1]);
                    _loc_9 = 2;
                    _loc_10 = CROSS_POINTS.length;
                    while (_loc_9 < _loc_10)
                    {
                        
                        graphics.lineTo(Math.max(0, Math.min(_loc_12 + CROSS_POINTS[_loc_9 + 0])), Math.max(0, Math.min(_loc_13 + CROSS_POINTS[(_loc_9 + 1)])));
                        _loc_9 = _loc_9 + 2;
                    }
                }
                _loc_14 = null;
                _loc_15 = new Rectangle();
                _loc_5.a = 1;
                _loc_5.d = 1;
                _loc_9 = _loc_6.length - 1;
                while (_loc_9 >= 0)
                {
                    
                    _loc_19 = _loc_6[_loc_9].marks;
                    _loc_20 = null;
                    _loc_10 = 0;
                    _loc_11 = _loc_19.length;
                    while (_loc_10 < _loc_11)
                    {
                        
                        var _loc_21:* = _loc_19[_loc_10];
                        _loc_20 = _loc_19[_loc_10];
                        if (_loc_21 != null && this.m_PositionRect.left <= _loc_20.x && _loc_20.x <= this.m_PositionRect.right && this.m_PositionRect.top <= _loc_20.y && _loc_20.y <= this.m_PositionRect.bottom && _loc_20.icon >= 0 && _loc_20.icon < MiniMapStorage.MARK_ICON_COUNT)
                        {
                            _loc_14 = MiniMapStorage.s_GetMarkIcon(_loc_20.icon, this.m_HighlightToggle, _loc_15);
                            _loc_12 = (_loc_20.x - this.m_PositionRect.left) * this.m_ZoomScale - int(_loc_15.width / 2);
                            _loc_13 = (_loc_20.y - this.m_PositionRect.top) * this.m_ZoomScale - int(_loc_15.height / 2);
                            _loc_5.tx = -_loc_15.x + _loc_12;
                            _loc_5.ty = -_loc_15.y + _loc_13;
                            if (_loc_12 < 0)
                            {
                                _loc_15.width = _loc_15.width + _loc_12;
                                _loc_12 = 0;
                            }
                            else
                            {
                                _loc_15.width = Math.min(MM_SIDEBAR_VIEW_WIDTH - _loc_12, _loc_15.width);
                            }
                            if (_loc_13 < 0)
                            {
                                _loc_15.height = _loc_15.height + _loc_13;
                                _loc_13 = 0;
                            }
                            else
                            {
                                _loc_15.height = Math.min(MM_SIDEBAR_VIEW_HEIGHT - _loc_13, _loc_15.height);
                            }
                            graphics.beginBitmapFill(_loc_14, _loc_5, false, false);
                            graphics.drawRect(_loc_12, _loc_13, _loc_15.width, _loc_15.height);
                        }
                        _loc_10++;
                    }
                    _loc_9 = _loc_9 - 1;
                }
            }
            graphics.endFill();
            return;
        }// end function

    }
}
