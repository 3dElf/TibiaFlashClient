package tibia.minimap
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import mx.core.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.worldmap.*;

    public class MiniMapStorage extends EventDispatcher
    {
        private var m_IEQueue:Array = null;
        protected var m_SaveQueue:Vector.<MiniMapSector> = null;
        private var m_IETimer:Timer = null;
        protected var m_PathDirty:Vector.<PathItem> = null;
        protected var m_SectorX:int = -1;
        protected var m_SectorY:int = -1;
        protected var m_SectorZ:int = -1;
        protected var m_ChangedSector:Boolean = false;
        protected var m_SectorCache:Vector.<MiniMapSector> = null;
        protected var m_LoadQueue:Vector.<MiniMapSector> = null;
        protected var m_PositionX:int = -1;
        protected var m_PositionY:int = -1;
        protected var m_PositionZ:int = -1;
        protected var m_PathHeap:Heap = null;
        private var m_IEBytesTotal:uint = 0;
        protected var m_IOTimer:Timer = null;
        private var m_IEBytesProcessed:uint = 0;
        private var m_PerformanceCounterCalculatePath:IPerformanceCounter;
        protected var m_PathMatrix:Vector.<PathItem> = null;
        protected var m_FlashEnd:Number = 0;
        private var m_IEData:ByteArray = null;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const PATH_SOUTH:int = 7;
        public static const MARK_ICON_SIZE:int = 11;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const MM_SECTOR_SIZE:int = 256;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const PATH_ERROR_GO_DOWNSTAIRS:int = -1;
        static const PATH_NORTH_WEST:int = 4;
        static const MM_IE_TIMEOUT:Number = 50;
        static const MM_IO_TIMEOUT:Number = 500;
        static const MM_SIDEBAR_ZOOM_MIN:int = -1;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const FIELD_HEIGHT:int = 24;
        static const MM_COLOUR_DEFAULT:uint = 0;
        static const PATH_COST_OBSTACLE:int = 255;
        static const UNDERGROUND_LAYER:int = 2;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MM_SIDEBAR_ZOOM_MAX:int = 2;
        static const FIELD_CACHESIZE:int = 32;
        static const PATH_ERROR_UNREACHABLE:int = -4;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const PLAYER_OFFSET_X:int = 8;
        static const PLAYER_OFFSET_Y:int = 6;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const PATH_NORTH:int = 3;
        private static const MARK_ICON_BITMAP:BitmapData = (new MARK_ICON_CLASS() as BitmapAsset).bitmapData;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const PATH_MAX_DISTANCE:int = 110;
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const PATH_NORTH_EAST:int = 2;
        static const PATH_SOUTH_WEST:int = 6;
        static const MM_SIDEBAR_VIEW_HEIGHT:int = 106;
        static const GROUND_LAYER:int = 7;
        public static const MARK_ICON_COUNT:int = 20;
        private static const MARK_HIGHLIGHT_BITMAP:BitmapData = (new MARK_HIGHLIGHT_CLASS() as BitmapAsset).bitmapData;
        static const PATH_WEST:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const PATH_COST_UNDEFINED:int = 254;
        static const PATH_EMPTY:int = 0;
        static const PATH_ERROR_TOO_FAR:int = -3;
        private static const EXPORT_DEFAULT_NAME:String = "ExportedMiniMap.dat";
        static const PATH_MATRIX_SIZE:int = 221;
        static const MM_STORAGE_MIN_VERSION:int = 1;
        static const PATH_SOUTH_EAST:int = 8;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        static const NUM_FIELDS:int = 2016;
        static const PATH_COST_MAX:int = 250;
        static const PATH_MAX_STEPS:int = 128;
        static const MM_STORAGE_MAX_VERSION:int = 1;
        static const MM_CACHE_SIZE:int = 48;
        private static const MARK_ICON_CLASS:Class = MiniMapStorage_MARK_ICON_CLASS;
        static const PATH_EXISTS:int = 1;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        private static const MARK_HIGHLIGHT_CLASS:Class = MiniMapStorage_MARK_HIGHLIGHT_CLASS;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MM_SIDEBAR_HIGHLIGHT_DURATION:Number = 10000;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        static const PATH_EAST:int = 1;
        static const MAP_WIDTH:int = 15;
        static const PATH_MATRIX_CENTER:int = 110;
        public static const EVENT_HIGHLIGHT_MARKS:String = "highlightMarks";

        public function MiniMapStorage()
        {
            var _loc_2:* = 0;
            this.m_PerformanceCounterCalculatePath = new AccumulatingPerformanceCounter();
            this.m_SectorCache = new Vector.<MiniMapSector>;
            this.m_LoadQueue = new Vector.<MiniMapSector>;
            this.m_SaveQueue = new Vector.<MiniMapSector>;
            this.m_IOTimer = new Timer(MM_IO_TIMEOUT);
            this.m_IOTimer.addEventListener(TimerEvent.TIMER, this.onIOTimer);
            this.m_IOTimer.start();
            var _loc_3:* = -1;
            this.m_PositionZ = -1;
            this.m_PositionY = _loc_3;
            this.m_PositionX = _loc_3;
            var _loc_3:* = -1;
            this.m_SectorZ = -1;
            this.m_SectorY = _loc_3;
            this.m_SectorX = _loc_3;
            this.m_PathMatrix = new Vector.<PathItem>(PATH_MATRIX_SIZE * PATH_MATRIX_SIZE, true);
            var _loc_1:* = 0;
            while (_loc_1 < PATH_MATRIX_SIZE)
            {
                
                _loc_2 = 0;
                while (_loc_2 < PATH_MATRIX_SIZE)
                {
                    
                    this.m_PathMatrix[_loc_1 * PATH_MATRIX_SIZE + _loc_2] = new PathItem(_loc_2 - PATH_MATRIX_CENTER, _loc_1 - PATH_MATRIX_CENTER);
                    _loc_2++;
                }
                _loc_1++;
            }
            this.m_PathHeap = new Heap();
            this.m_PathDirty = new Vector.<PathItem>;
            return;
        }// end function

        private function onIOTimer(event:TimerEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event != null)
            {
                _loc_2 = null;
                var _loc_4:* = this.m_LoadQueue.shift();
                _loc_2 = this.m_LoadQueue.shift();
                if (this.m_LoadQueue != null && this.m_LoadQueue.length > 0 && _loc_4 != null)
                {
                    if (!BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                    {
                        _loc_2.loadSharedObject();
                        _loc_3 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                        _loc_3.kind = PropertyChangeEventKind.UPDATE;
                        _loc_3.property = "sector";
                        dispatchEvent(_loc_3);
                    }
                }
                else
                {
                    var _loc_4:* = this.m_SaveQueue.shift();
                    _loc_2 = this.m_SaveQueue.shift();
                    if (this.m_IOTimer.currentCount % 10 == 0 && this.m_SaveQueue != null && this.m_SaveQueue.length > 0 && _loc_4 != null)
                    {
                        if (!BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                        {
                            _loc_2.saveSharedObject(false);
                        }
                    }
                }
            }
            return;
        }// end function

        private function enqueue(param1:Vector.<MiniMapSector>, param2:MiniMapSector) : void
        {
            var _loc_3:* = param1.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (param2.equals(param1[_loc_3]))
                {
                    return;
                }
                _loc_3 = _loc_3 - 1;
            }
            param1.push(param2);
            return;
        }// end function

        public function removeMark(param1:int, param2:int, param3:int, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            this.acquireSector(param1, param2, param3, false).removeMark(param1, param2, param3);
            if (param4)
            {
                _loc_5 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_5.kind = PropertyChangeEventKind.UPDATE;
                _loc_5.property = "sector";
                dispatchEvent(_loc_5);
            }
            else
            {
                this.m_ChangedSector = true;
            }
            return;
        }// end function

        public function getSectorY() : int
        {
            return this.m_SectorY;
        }// end function

        private function getSectorListing() : Array
        {
            var Name:String;
            var Match:Array;
            var Listing:Array;
            var _SharedObjectManager:* = SharedObjectManager.s_GetInstance();
            var MatchSectorName:* = /^([0-9a-fA-F]{8})([0-9a-fA-F]{8})([0-9a-fA-F]{2})$/;
            if (SharedObjectManager.s_SharedObjectsAvailable() && _SharedObjectManager != null)
            {
                try
                {
                    var _loc_2:* = 0;
                    var _loc_3:* = _SharedObjectManager.getListing(true);
                    while (_loc_3 in _loc_2)
                    {
                        
                        Name = _loc_3[_loc_2];
                        Match = MatchSectorName.exec(Name);
                        if (Match != null && Match.length == 4)
                        {
                            Listing.push(Name);
                        }
                    }
                }
                catch (_Error)
                {
                }
            }
            return Listing;
        }// end function

        private function onExportTimer(event:TimerEvent) : void
        {
            var Name:String;
            var _SharedObjectManager:SharedObjectManager;
            var _SharedObject:SharedObject;
            var _MiniMapSector:MiniMapSector;
            var _ProgressEvent:ProgressEvent;
            var a_Event:* = event;
            if (a_Event != null)
            {
                if (this.m_IEQueue != null && this.m_IEQueue.length > 0)
                {
                    Name = String(this.m_IEQueue.shift());
                    try
                    {
                        _SharedObjectManager;
                        _SharedObject;
                        _MiniMapSector;
                        var _loc_3:* = SharedObjectManager.s_GetInstance();
                        _SharedObjectManager = SharedObjectManager.s_GetInstance();
                        var _loc_3:* = _SharedObjectManager.getLocal(Name, false, true);
                        _SharedObject = _SharedObjectManager.getLocal(Name, false, true);
                        var _loc_3:* = MiniMapSector.s_LoadSharedObject(_SharedObject);
                        _MiniMapSector = MiniMapSector.s_LoadSharedObject(_SharedObject);
                        if (SharedObjectManager.s_SharedObjectsAvailable() && _loc_3 != null && _loc_3 != null && _loc_3 != null)
                        {
                            _MiniMapSector.saveByteArray(this.m_IEData);
                            _ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
                            _ProgressEvent.bytesLoaded = this.m_IEData.position;
                            _ProgressEvent.bytesTotal = this.m_IEBytesTotal;
                            dispatchEvent(_ProgressEvent);
                        }
                    }
                    catch (_Error:Error)
                    {
                        cancelImportExport();
                        dispatchEvent(new ErrorEvent(ErrorEvent.ERROR));
                    }
                }
                else
                {
                    this.cancelImportExport();
                    dispatchEvent(new Event(Event.COMPLETE));
                }
            }
            return;
        }// end function

        public function saveSectors(param1:Boolean) : void
        {
            var _loc_2:* = this.m_SaveQueue.length - 1;
            while (_loc_2 >= 0)
            {
                
                if (!BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                {
                    this.m_SaveQueue[_loc_2].saveSharedObject(param1);
                }
                _loc_2 = _loc_2 - 1;
            }
            this.m_SaveQueue.length = 0;
            var _loc_3:* = this.m_SectorCache.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (!BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                {
                    this.m_SectorCache[_loc_3].saveSharedObject(param1);
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        public function getPositionX() : int
        {
            return this.m_PositionX;
        }// end function

        public function getPositionY() : int
        {
            return this.m_PositionY;
        }// end function

        public function getPositionZ() : int
        {
            return this.m_PositionZ;
        }// end function

        public function calculatePath(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:Boolean, param9:Array) : int
        {
            var _loc_10:* = param4 - param1;
            var _loc_11:* = param5 - param2;
            var _loc_12:* = 0;
            if (param9 == null)
            {
                return PATH_ERROR_INTERNAL;
            }
            param9.length = 0;
            if (param6 > param3)
            {
                return PATH_ERROR_GO_DOWNSTAIRS;
            }
            if (param6 < param3)
            {
                return PATH_ERROR_GO_UPSTAIRS;
            }
            if (param4 == param1 && param5 == param2)
            {
                return PATH_EMPTY;
            }
            if (Math.abs(_loc_10) >= PATH_MAX_DISTANCE || Math.abs(_loc_11) >= PATH_MAX_DISTANCE)
            {
                return PATH_ERROR_TOO_FAR;
            }
            if (Math.abs(_loc_10) + Math.abs(_loc_11) == 1)
            {
                _loc_12 = this.getFieldCost(param4, param5, param6);
                if (param8 || _loc_12 < PATH_COST_OBSTACLE)
                {
                    if (_loc_10 == 1 && _loc_11 == 0)
                    {
                        param9[0] = PATH_EAST;
                    }
                    if (_loc_10 == 0 && _loc_11 == -1)
                    {
                        param9[0] = PATH_NORTH;
                    }
                    if (_loc_10 == -1 && _loc_11 == 0)
                    {
                        param9[0] = PATH_WEST;
                    }
                    if (_loc_10 == 0 && _loc_11 == 1)
                    {
                        param9[0] = PATH_SOUTH;
                    }
                    param9[0] = param9[0] | _loc_12 << 16;
                    return PATH_EXISTS;
                }
                else
                {
                    return PATH_EMPTY;
                }
            }
            if (param7 && Math.abs(_loc_10) == 1 && Math.abs(_loc_11) == 1)
            {
                _loc_12 = this.getFieldCost(param4, param5, param6);
                if (param8 || _loc_12 < PATH_COST_OBSTACLE)
                {
                    if (_loc_10 == 1 && _loc_11 == -1)
                    {
                        param9[0] = PATH_NORTH_EAST;
                    }
                    if (_loc_10 == -1 && _loc_11 == -1)
                    {
                        param9[0] = PATH_NORTH_WEST;
                    }
                    if (_loc_10 == -1 && _loc_11 == 1)
                    {
                        param9[0] = PATH_SOUTH_WEST;
                    }
                    if (_loc_10 == 1 && _loc_11 == 1)
                    {
                        param9[0] = PATH_SOUTH_EAST;
                    }
                    param9[0] = param9[0] | _loc_12 << 16;
                    return PATH_EXISTS;
                }
                else
                {
                    return PATH_EMPTY;
                }
            }
            var _loc_13:* = new Vector.<MiniMapSector>(4, true);
            _loc_13[0] = this.acquireSector(param1 - PATH_MATRIX_CENTER, param2 - PATH_MATRIX_CENTER, param3, false);
            _loc_13[1] = this.acquireSector(param1 - PATH_MATRIX_CENTER, param2 + PATH_MATRIX_CENTER, param3, false);
            _loc_13[2] = this.acquireSector(param1 + PATH_MATRIX_CENTER, param2 + PATH_MATRIX_CENTER, param3, false);
            _loc_13[3] = this.acquireSector(param1 + PATH_MATRIX_CENTER, param2 - PATH_MATRIX_CENTER, param3, false);
            var _loc_14:* = 0;
            var _loc_15:* = int.MAX_VALUE;
            _loc_14 = 0;
            while (_loc_14 < 4)
            {
                
                _loc_15 = Math.min(_loc_15, _loc_13[_loc_14].minCost);
                _loc_14++;
            }
            var _loc_16:* = _loc_13[0].getSectorX() + MM_SECTOR_SIZE;
            var _loc_17:* = _loc_13[0].getSectorY() + MM_SECTOR_SIZE;
            var _loc_18:* = this.m_PathMatrix[PATH_MATRIX_CENTER * PATH_MATRIX_SIZE + PATH_MATRIX_CENTER];
            _loc_18.predecessor = null;
            _loc_18.cost = int.MAX_VALUE;
            _loc_18.pathCost = int.MAX_VALUE;
            _loc_18.pathHeuristic = 0;
            this.m_PathDirty.push(_loc_18);
            var _loc_19:* = this.m_PathMatrix[(PATH_MATRIX_CENTER + _loc_11) * PATH_MATRIX_SIZE + (PATH_MATRIX_CENTER + _loc_10)];
            _loc_19.predecessor = null;
            if (param4 < _loc_16)
            {
                if (param5 < _loc_17)
                {
                    _loc_14 = 0;
                }
                else
                {
                    _loc_14 = 1;
                }
            }
            else if (param5 < _loc_17)
            {
                _loc_14 = 3;
            }
            else
            {
                _loc_14 = 2;
            }
            _loc_19.cost = _loc_13[_loc_14].getCost(param4, param5, param6);
            _loc_19.pathCost = 0;
            _loc_19.pathHeuristic = _loc_19.cost + (_loc_19.distance - 1) * _loc_15;
            this.m_PathDirty.push(_loc_19);
            this.m_PathHeap.clear(false);
            this.m_PathHeap.addItem(_loc_19, _loc_19.pathHeuristic);
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = 0;
            var _loc_27:* = null;
            do
            {
                
                if (_loc_20.m_HeapKey < _loc_18.pathCost)
                {
                    _loc_10 = -1;
                    while (_loc_10 < 2)
                    {
                        
                        _loc_11 = -1;
                        while (_loc_11 < 2)
                        {
                            
                            if (_loc_10 != 0 || _loc_11 != 0)
                            {
                                _loc_23 = _loc_20.x + _loc_10;
                                _loc_24 = _loc_20.y + _loc_11;
                                if (_loc_23 < -PATH_MATRIX_CENTER || _loc_23 > PATH_MATRIX_CENTER || _loc_24 < -PATH_MATRIX_CENTER || _loc_24 > PATH_MATRIX_CENTER)
                                {
                                }
                                else
                                {
                                    if (_loc_10 * _loc_11 == 0)
                                    {
                                        _loc_22 = _loc_20.pathCost + _loc_20.cost;
                                    }
                                    else
                                    {
                                        _loc_22 = _loc_20.pathCost + 3 * _loc_20.cost;
                                    }
                                    _loc_21 = this.m_PathMatrix[(PATH_MATRIX_CENTER + _loc_24) * PATH_MATRIX_SIZE + PATH_MATRIX_CENTER + _loc_23];
                                    if (_loc_21.pathCost <= _loc_22)
                                    {
                                    }
                                    else
                                    {
                                        _loc_21.predecessor = _loc_20;
                                        _loc_21.pathCost = _loc_22;
                                        if (_loc_21.cost == int.MAX_VALUE)
                                        {
                                            _loc_25 = param1 + _loc_21.x;
                                            _loc_26 = param2 + _loc_21.y;
                                            if (_loc_25 < _loc_16)
                                            {
                                                if (_loc_26 < _loc_17)
                                                {
                                                    _loc_14 = 0;
                                                }
                                                else
                                                {
                                                    _loc_14 = 1;
                                                }
                                            }
                                            else if (_loc_26 < _loc_17)
                                            {
                                                _loc_14 = 3;
                                            }
                                            else
                                            {
                                                _loc_14 = 2;
                                            }
                                            _loc_21.cost = _loc_13[_loc_14].getCost(_loc_25, _loc_26, param3);
                                            _loc_21.pathHeuristic = _loc_21.cost + (_loc_21.distance - 1) * _loc_15;
                                            this.m_PathDirty.push(_loc_21);
                                        }
                                        if (_loc_21 == _loc_18 || _loc_21.cost >= PATH_COST_OBSTACLE)
                                        {
                                        }
                                        else if (_loc_21.m_HeapParent != null)
                                        {
                                            this.m_PathHeap.updateKey(_loc_21, _loc_22 + _loc_21.pathHeuristic);
                                        }
                                        else
                                        {
                                            this.m_PathHeap.addItem(_loc_21, _loc_22 + _loc_21.pathHeuristic);
                                        }
                                    }
                                }
                            }
                            _loc_11++;
                        }
                        _loc_10++;
                    }
                }
                var _loc_29:* = this.m_PathHeap.extractMinItem() as PathItem;
                _loc_20 = this.m_PathHeap.extractMinItem() as PathItem;
            }while (_loc_29 != null)
            var _loc_28:* = PATH_ERROR_INTERNAL;
            if (_loc_18.pathCost < int.MAX_VALUE)
            {
                _loc_20 = _loc_18;
                _loc_21 = null;
                _loc_14 = 0;
                while (_loc_20 != null)
                {
                    
                    if (!param8 && _loc_20.x == _loc_19.x && _loc_20.y == _loc_19.y && _loc_19.cost >= PATH_COST_OBSTACLE)
                    {
                        _loc_20 = null;
                        break;
                    }
                    if (_loc_20.cost == PATH_COST_UNDEFINED)
                    {
                        break;
                    }
                    if (_loc_21 != null)
                    {
                        _loc_10 = _loc_20.x - _loc_21.x;
                        _loc_11 = _loc_20.y - _loc_21.y;
                        if (_loc_10 == 1 && _loc_11 == 0)
                        {
                            param9[_loc_14] = PATH_EAST;
                        }
                        else if (_loc_10 == 1 && _loc_11 == -1)
                        {
                            param9[_loc_14] = PATH_NORTH_EAST;
                        }
                        else if (_loc_10 == 0 && _loc_11 == -1)
                        {
                            param9[_loc_14] = PATH_NORTH;
                        }
                        else if (_loc_10 == -1 && _loc_11 == -1)
                        {
                            param9[_loc_14] = PATH_NORTH_WEST;
                        }
                        else if (_loc_10 == -1 && _loc_11 == 0)
                        {
                            param9[_loc_14] = PATH_WEST;
                        }
                        else if (_loc_10 == -1 && _loc_11 == 1)
                        {
                            param9[_loc_14] = PATH_SOUTH_WEST;
                        }
                        else if (_loc_10 == 0 && _loc_11 == 1)
                        {
                            param9[_loc_14] = PATH_SOUTH;
                        }
                        else if (_loc_10 == 1 && _loc_11 == 1)
                        {
                            param9[_loc_14] = PATH_SOUTH_EAST;
                        }
                        param9[_loc_14] = param9[_loc_14] | _loc_20.cost << 16;
                        if (++_loc_14 >= PATH_MAX_STEPS)
                        {
                            break;
                        }
                    }
                    _loc_21 = _loc_20;
                    _loc_20 = _loc_20.predecessor;
                }
                if (++_loc_14 == 0)
                {
                    _loc_28 = PATH_EMPTY;
                }
                else
                {
                    _loc_28 = PATH_EXISTS;
                }
            }
            else
            {
                _loc_28 = PATH_ERROR_UNREACHABLE;
            }
            do
            {
                
                _loc_21.cost = int.MAX_VALUE;
                _loc_21.pathCost = int.MAX_VALUE;
                var _loc_29:* = this.m_PathDirty.pop();
                _loc_21 = this.m_PathDirty.pop();
            }while (_loc_29 != null)
            return _loc_28;
        }// end function

        private function refreshFromWorldMap() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_1:* = Tibia.s_GetWorldMapStorage();
            if (_loc_1 != null)
            {
                _loc_2 = _loc_1.getPosition();
                _loc_2.x = _loc_2.x - PLAYER_OFFSET_X;
                _loc_2.y = _loc_2.y - PLAYER_OFFSET_Y;
                _loc_3 = _loc_1.toMap(_loc_2);
                _loc_4 = 0;
                while (_loc_4 < MAPSIZE_X)
                {
                    
                    _loc_5 = 0;
                    while (_loc_5 < MAPSIZE_Y)
                    {
                        
                        _loc_6 = _loc_1.getMiniMapColour(_loc_4, _loc_5, _loc_3.z);
                        _loc_7 = _loc_1.getMiniMapCost(_loc_4, _loc_5, _loc_3.z);
                        this.updateField(_loc_2.x + _loc_4, _loc_2.y + _loc_5, _loc_2.z, _loc_6, _loc_7, false);
                        _loc_5++;
                    }
                    _loc_4++;
                }
                this.refreshSectors();
            }
            return;
        }// end function

        public function getFieldColour(param1:int, param2:int, param3:int) : uint
        {
            return this.acquireSector(param1, param2, param3, false).getColour(param1, param2, param3);
        }// end function

        public function getFieldCost(param1:int, param2:int, param3:int) : int
        {
            return this.acquireSector(param1, param2, param3, false).getCost(param1, param2, param3);
        }// end function

        public function exportMiniMap() : ByteArray
        {
            if (this.m_IEData != null || this.m_IEQueue != null || this.m_IETimer != null)
            {
                throw new Error("MiniMapStorage.exportMiniMap: Concurrent operation detected.");
            }
            this.saveSectors(true);
            this.m_IOTimer.stop();
            this.m_IEQueue = this.getSectorListing();
            this.m_IEBytesProcessed = 0;
            this.m_IEBytesTotal = this.m_IEQueue.length * MiniMapSector.MIN_BYTES;
            try
            {
                this.m_IEData = new ByteArray();
                this.m_IEData.endian = Endian.LITTLE_ENDIAN;
                this.m_IEData.position = this.m_IEBytesTotal;
                this.m_IEData.position = 0;
            }
            catch (_Error:MemoryError)
            {
                m_IEQueue = null;
                m_IEData = null;
                throw _Error;
            }
            this.m_IETimer = new Timer(MM_IE_TIMEOUT, 0);
            this.m_IETimer.addEventListener(TimerEvent.TIMER, this.onExportTimer);
            this.m_IETimer.start();
            return this.m_IEData;
        }// end function

        private function dequeue(param1:Vector.<MiniMapSector>, param2:MiniMapSector) : void
        {
            var _loc_3:* = param1.length - 1;
            while (_loc_3 >= 0)
            {
                
                if (param2.equals(param1[_loc_3]))
                {
                    param1.splice(_loc_3, 1);
                    return;
                }
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        public function getMark(param1:int, param2:int, param3:int) : Object
        {
            return this.acquireSector(param1, param2, param3, false).getMark(param1, param2, param3);
        }// end function

        public function updateField(param1:int, param2:int, param3:int, param4:uint, param5:int, param6:Boolean = true) : void
        {
            var _loc_8:* = null;
            var _loc_7:* = this.acquireSector(param1, param2, param3, false);
            _loc_7.updateField(param1, param2, param3, param4, param5);
            if (param6)
            {
                _loc_8 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_8.kind = PropertyChangeEventKind.UPDATE;
                _loc_8.property = "sector";
                dispatchEvent(_loc_8);
                this.enqueue(this.m_SaveQueue, _loc_7);
            }
            else
            {
                this.m_ChangedSector = true;
            }
            return;
        }// end function

        public function setPosition(param1:int, param2:int, param3:int) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (param1 < MAP_MIN_X)
            {
                param1 = MAP_MIN_X;
            }
            if (param1 > MAP_MAX_X)
            {
                param1 = MAP_MAX_X;
            }
            if (param2 < MAP_MIN_Y)
            {
                param2 = MAP_MIN_Y;
            }
            if (param2 > MAP_MAX_Y)
            {
                param2 = MAP_MAX_Y;
            }
            if (param3 < MAP_MIN_Z)
            {
                param3 = MAP_MIN_Z;
            }
            if (param3 > MAP_MAX_Z)
            {
                param3 = MAP_MAX_Z;
            }
            var _loc_4:* = int(param1 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            var _loc_5:* = int(param2 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            var _loc_6:* = param3;
            this.m_PositionX = param1;
            this.m_PositionY = param2;
            this.m_PositionZ = param3;
            if (_loc_4 != this.m_SectorX || _loc_5 != this.m_SectorY || _loc_6 != this.m_SectorZ)
            {
                _loc_8 = -1;
                while (_loc_8 < 2)
                {
                    
                    _loc_9 = -1;
                    while (_loc_9 < 2)
                    {
                        
                        this.acquireSector(_loc_4 + _loc_9 * MM_SECTOR_SIZE, _loc_5 + _loc_8 * MM_SECTOR_SIZE, _loc_6, _loc_8 == 0 && _loc_9 == 0);
                        _loc_9++;
                    }
                    _loc_8++;
                }
                this.m_SectorX = _loc_4;
                this.m_SectorY = _loc_5;
                this.m_SectorZ = _loc_6;
            }
            var _loc_7:* = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            _loc_7.kind = PropertyChangeEventKind.UPDATE;
            _loc_7.property = "position";
            dispatchEvent(_loc_7);
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = 0;
            this.cancelImportExport();
            if (this.m_LoadQueue != null)
            {
                this.m_LoadQueue.length = 0;
            }
            if (this.m_SaveQueue != null)
            {
                this.m_SaveQueue.length = 0;
            }
            if (this.m_SectorCache != null)
            {
                this.m_SectorCache.length = 0;
            }
            if (this.m_PathMatrix != null)
            {
            }
            if (this.m_PathHeap != null)
            {
                this.m_PathHeap.clear();
            }
            if (this.m_PathDirty != null)
            {
                _loc_1 = this.m_PathDirty.length - 1;
                while (_loc_1 >= 0)
                {
                    
                    this.m_PathDirty[_loc_1].cost = int.MAX_VALUE;
                    this.m_PathDirty[_loc_1].pathCost = int.MAX_VALUE;
                    this.m_PathDirty[_loc_1].pathHeuristic = int.MAX_VALUE;
                    this.m_PathDirty[_loc_1].predecessor = null;
                    _loc_1 = _loc_1 - 1;
                }
                this.m_PathDirty.length = 0;
            }
            var _loc_2:* = -1;
            this.m_PositionZ = -1;
            this.m_PositionY = _loc_2;
            this.m_PositionX = _loc_2;
            var _loc_2:* = -1;
            this.m_SectorZ = -1;
            this.m_SectorY = _loc_2;
            this.m_SectorX = _loc_2;
            return;
        }// end function

        public function cancelImportExport() : void
        {
            this.m_IEBytesProcessed = 0;
            this.m_IEBytesTotal = 0;
            this.m_IEData = null;
            this.m_IEQueue = null;
            if (this.m_IETimer != null)
            {
                this.m_IETimer.removeEventListener(TimerEvent.TIMER, this.onExportTimer);
                this.m_IETimer.stop();
                this.m_IETimer = null;
            }
            System.pauseForGCIfCollectionImminent(0.5);
            if (!this.m_IOTimer.running)
            {
                this.m_IOTimer.start();
            }
            return;
        }// end function

        public function setMark(param1:int, param2:int, param3:int, param4:int, param5:String, param6:Boolean = true) : void
        {
            var _loc_8:* = null;
            var _loc_7:* = this.acquireSector(param1, param2, param3, false);
            _loc_7.setMark(param1, param2, param3, param4, param5);
            if (param6)
            {
                _loc_8 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_8.kind = PropertyChangeEventKind.UPDATE;
                _loc_8.property = "sector";
                dispatchEvent(_loc_8);
                this.enqueue(this.m_SaveQueue, _loc_7);
            }
            else
            {
                this.m_ChangedSector = true;
            }
            return;
        }// end function

        public function acquireSector(param1:int, param2:int, param3:int, param4:Boolean) : MiniMapSector
        {
            var _loc_11:* = null;
            param1 = Math.max(MAP_MIN_X, Math.min(param1, MAP_MAX_X));
            param2 = Math.max(MAP_MIN_Y, Math.min(param2, MAP_MAX_Y));
            param3 = Math.max(MAP_MIN_Z, Math.min(param3, MAP_MAX_Z));
            var _loc_5:* = int(param1 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            var _loc_6:* = int(param2 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            var _loc_7:* = param3;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            _loc_9 = this.m_SectorCache.length - 1;
            while (_loc_9 >= 0)
            {
                
                if (this.m_SectorCache[_loc_9].equals(_loc_5, _loc_6, _loc_7))
                {
                    _loc_8 = this.m_SectorCache[_loc_9];
                    this.m_SectorCache.splice(_loc_9, 1);
                    break;
                }
                _loc_9 = _loc_9 - 1;
            }
            if (_loc_8 == null)
            {
                _loc_9 = this.m_SaveQueue.length - 1;
                while (_loc_9 >= 0)
                {
                    
                    if (this.m_SaveQueue[_loc_9].equals(_loc_5, _loc_6, _loc_7))
                    {
                        _loc_8 = this.m_SaveQueue[_loc_9];
                        break;
                    }
                    _loc_9 = _loc_9 - 1;
                }
            }
            if (_loc_8 == null)
            {
                _loc_8 = new MiniMapSector(_loc_5, _loc_6, _loc_7);
                if (BrowserHelper.s_CompareFlashPlayerVersion(Tibia.BUGGY_FLASH_PLAYER_VERSION))
                {
                    param4 = false;
                }
                if (param4)
                {
                    _loc_8.loadSharedObject();
                    this.dequeue(this.m_LoadQueue, _loc_8);
                }
                else
                {
                    this.enqueue(this.m_LoadQueue, _loc_8);
                }
            }
            if (this.m_SectorCache.length >= MM_CACHE_SIZE)
            {
                _loc_11 = null;
                _loc_9 = 0;
                _loc_10 = this.m_SectorCache.length;
                while (_loc_9 < _loc_10)
                {
                    
                    if (!this.m_SectorCache[_loc_9].dirty)
                    {
                        _loc_11 = this.m_SectorCache[_loc_9];
                        this.m_SectorCache.splice(_loc_9, 1);
                        break;
                    }
                    _loc_9++;
                }
                if (_loc_11 == null)
                {
                    _loc_11 = this.m_SectorCache[0];
                    this.m_SectorCache.splice(0, 1);
                }
                this.dequeue(this.m_LoadQueue, _loc_11);
                if (_loc_11.dirty)
                {
                    this.enqueue(this.m_SaveQueue, _loc_11);
                }
            }
            this.m_SectorCache.push(_loc_8);
            return _loc_8;
        }// end function

        public function highlightMarks() : void
        {
            var _loc_1:* = new Event(EVENT_HIGHLIGHT_MARKS);
            dispatchEvent(_loc_1);
            return;
        }// end function

        public function refreshSectors() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (this.m_ChangedSector)
            {
                _loc_1 = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
                _loc_1.kind = PropertyChangeEventKind.UPDATE;
                _loc_1.property = "sector";
                dispatchEvent(_loc_1);
                _loc_2 = this.m_SectorCache.length - 1;
                while (_loc_2 >= 0)
                {
                    
                    if (this.m_SectorCache[_loc_2].dirty)
                    {
                        this.enqueue(this.m_SaveQueue, this.m_SectorCache[_loc_2]);
                    }
                    _loc_2 = _loc_2 - 1;
                }
                this.m_ChangedSector = false;
            }
            return;
        }// end function

        public function getSectorX() : int
        {
            return this.m_SectorX;
        }// end function

        public function getSectorZ() : int
        {
            return this.m_SectorZ;
        }// end function

        public static function s_GetMarkIcon(param1:int, param2:Boolean, param3:Rectangle) : BitmapData
        {
            var _loc_4:* = null;
            if (param1 < 0 || param1 > MARK_ICON_COUNT)
            {
                throw new ArgumentError("MiniMapStorage.s_GetMarkIcon: Invalid icon ID: " + param1);
            }
            param3.x = param1 * MARK_ICON_SIZE;
            param3.y = 0;
            param3.width = MARK_ICON_SIZE;
            param3.height = MARK_ICON_SIZE;
            if (param2)
            {
                _loc_4 = MARK_HIGHLIGHT_BITMAP.clone();
                _loc_4.copyPixels(MARK_ICON_BITMAP, param3, new Point((_loc_4.width - param3.width) / 2, (_loc_4.height - param3.height) / 2), null, null, true);
                param3.x = 0;
                param3.y = 0;
                param3.width = _loc_4.width;
                param3.height = _loc_4.height;
                return _loc_4;
            }
            return MARK_ICON_BITMAP;
        }// end function

    }
}
