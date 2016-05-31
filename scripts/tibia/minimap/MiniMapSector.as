package tibia.minimap
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.utils.*;
    import shared.utility.*;

    public class MiniMapSector extends Object
    {
        protected var m_SectorX:int = 0;
        protected var m_SectorY:int = 0;
        protected var m_SectorZ:int = 0;
        var m_MinCost:int = 254;
        var m_Cost:Vector.<int> = null;
        var m_Marks:Array = null;
        protected var m_Dirty:Boolean = false;
        var m_BitmapData:BitmapData = null;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const PATH_SOUTH:int = 7;
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
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const PATH_MAX_DISTANCE:int = 110;
        static const MM_SIDEBAR_VIEW_WIDTH:int = 106;
        static const PATH_NORTH_EAST:int = 2;
        static const PATH_SOUTH_WEST:int = 6;
        static const MM_SIDEBAR_VIEW_HEIGHT:int = 106;
        static const GROUND_LAYER:int = 7;
        static const PATH_WEST:int = 5;
        static const MAP_HEIGHT:int = 11;
        static const PATH_ERROR_INTERNAL:int = -5;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const PATH_COST_UNDEFINED:int = 254;
        static const PATH_EMPTY:int = 0;
        static const PATH_ERROR_TOO_FAR:int = -3;
        static const PATH_MATRIX_SIZE:int = 221;
        static const MM_STORAGE_MIN_VERSION:int = 1;
        static const PATH_SOUTH_EAST:int = 8;
        static const PATH_ERROR_GO_UPSTAIRS:int = -2;
        static const NUM_FIELDS:int = 2016;
        static const PATH_COST_MAX:int = 250;
        static const PATH_MAX_STEPS:int = 128;
        static const MM_STORAGE_MAX_VERSION:int = 1;
        static const MM_CACHE_SIZE:int = 48;
        static const PATH_EXISTS:int = 1;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
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
        static const MIN_BYTES:uint = 131079;

        public function MiniMapSector(param1:int, param2:int, param3:int)
        {
            if (param1 < MAP_MIN_X || param1 > MAP_MAX_X || param1 % MM_SECTOR_SIZE != 0)
            {
                throw new ArgumentError("MiniMapSector.MiniMapSector: Invalid x co-ordinate: " + param1);
            }
            if (param2 < MAP_MIN_Y || param2 > MAP_MAX_Y || param2 % MM_SECTOR_SIZE != 0)
            {
                throw new ArgumentError("MiniMapSector.MiniMapSector: Invalid y co-ordinate: " + param2);
            }
            if (param3 < MAP_MIN_Z || param3 > MAP_MAX_Z)
            {
                throw new ArgumentError("MiniMapSector.MiniMapSector: Invalid z co-ordinate: " + param3);
            }
            this.m_SectorX = param1;
            this.m_SectorY = param2;
            this.m_SectorZ = param3;
            this.m_BitmapData = new BitmapData(MM_SECTOR_SIZE, MM_SECTOR_SIZE, true, MM_COLOUR_DEFAULT);
            this.m_Cost = new Vector.<int>(MM_SECTOR_SIZE * MM_SECTOR_SIZE, true);
            var _loc_4:* = this.m_Cost.length - 1;
            while (_loc_4 >= 0)
            {
                
                this.m_Cost[_loc_4] = PATH_COST_UNDEFINED;
                _loc_4 = _loc_4 - 1;
            }
            this.m_MinCost = PATH_COST_UNDEFINED;
            this.m_Marks = [];
            this.m_Dirty = false;
            return;
        }// end function

        public function getCost(param1:int, param2:int, param3:int) : int
        {
            return this.m_Cost[param2 % MM_SECTOR_SIZE * MM_SECTOR_SIZE + param1 % MM_SECTOR_SIZE];
        }// end function

        public function equals(param1:Object, param2:int = 0, param3:int = 0) : Boolean
        {
            var _loc_4:* = param1 as MiniMapSector;
            if (param1 as MiniMapSector != null)
            {
                return this.m_SectorX == _loc_4.m_SectorX && this.m_SectorY == _loc_4.m_SectorY && this.m_SectorZ == _loc_4.m_SectorZ;
            }
            return this.m_SectorX == int(param1) && this.m_SectorY == param2 && this.m_SectorZ == param3;
        }// end function

        function getMark(param1:int, param2:int, param3:int) : Object
        {
            var _loc_4:* = null;
            var _loc_5:* = this.m_Marks.length - 1;
            while (_loc_5 >= 0)
            {
                
                var _loc_6:* = this.m_Marks[_loc_5];
                _loc_4 = this.m_Marks[_loc_5];
                if (_loc_6 != null && _loc_4.x == param1 && _loc_4.y == param2)
                {
                    return _loc_4;
                }
                _loc_5 = _loc_5 - 1;
            }
            return null;
        }// end function

        public function getColour(param1:int, param2:int, param3:int) : uint
        {
            return 4278190080 | this.m_BitmapData.getPixel32(param1 % MM_SECTOR_SIZE, param2 % MM_SECTOR_SIZE);
        }// end function

        function get dirty() : Boolean
        {
            return this.m_Dirty;
        }// end function

        function get marks() : Array
        {
            return this.m_Marks;
        }// end function

        function loadSharedObject() : void
        {
            var Name:String;
            var _SharedObjectManager:SharedObjectManager;
            var _SharedObject:SharedObject;
            try
            {
                Name = s_GetSectorName(this.m_SectorX, this.m_SectorY, this.m_SectorZ);
                _SharedObjectManager;
                _SharedObject;
                var _loc_2:* = SharedObjectManager.s_GetInstance();
                _SharedObjectManager = SharedObjectManager.s_GetInstance();
                var _loc_2:* = _SharedObjectManager.getLocal(Name, true, true);
                _SharedObject = _SharedObjectManager.getLocal(Name, true, true);
                if (SharedObjectManager.s_SharedObjectsAvailable() && _loc_2 != null && _loc_2 != null)
                {
                    s_LoadSharedObjectInternal(_SharedObject, this);
                }
            }
            catch (_Error)
            {
            }
            return;
        }// end function

        function setMark(param1:int, param2:int, param3:int, param4:int, param5:String) : void
        {
            var _loc_6:* = param5.substr(0, 65535);
            this.removeMark(param1, param2, param3);
            this.m_Marks.push({x:param1, y:param2, z:param3, icon:param4, text:_loc_6});
            this.m_Dirty = true;
            return;
        }// end function

        function saveSharedObject(param1:Boolean) : void
        {
            var Name:String;
            var _SharedObjectManager:SharedObjectManager;
            var _SharedObject:SharedObject;
            var BitmapDataBytes:ByteArray;
            var Cost:Vector.<int>;
            var Data:Object;
            var a_Flush:* = param1;
            try
            {
                Name = s_GetSectorName(this.m_SectorX, this.m_SectorY, this.m_SectorZ);
                _SharedObjectManager;
                _SharedObject;
                var _loc_3:* = SharedObjectManager.s_GetInstance();
                _SharedObjectManager = SharedObjectManager.s_GetInstance();
                var _loc_3:* = _SharedObjectManager.getLocal(Name, true, true);
                _SharedObject = _SharedObjectManager.getLocal(Name, true, true);
                if (this.m_Dirty && SharedObjectManager.s_SharedObjectsAvailable() && _loc_3 != null && _loc_3 != null)
                {
                    BitmapDataBytes = this.m_BitmapData.getPixels(new Rectangle(0, 0, MM_SECTOR_SIZE, MM_SECTOR_SIZE));
                    Cost = this.m_Cost.slice();
                    Data = _SharedObject.data;
                    Data.version = MM_STORAGE_MAX_VERSION;
                    Data.sectorX = this.m_SectorX;
                    Data.sectorY = this.m_SectorY;
                    Data.sectorZ = this.m_SectorZ;
                    Data.bitmapDataBytes = BitmapDataBytes;
                    Data.cost = Cost;
                    Data.minCost = this.m_MinCost;
                    Data.mark = this.m_Marks;
                    if (a_Flush)
                    {
                        _SharedObject.flush();
                    }
                }
                this.m_Dirty = false;
            }
            catch (_Error)
            {
            }
            return;
        }// end function

        function set dirty(param1:Boolean) : void
        {
            this.m_Dirty = param1;
            return;
        }// end function

        function updateField(param1:int, param2:int, param3:int, param4:uint, param5:int) : void
        {
            var _loc_6:* = param1 % MM_SECTOR_SIZE;
            var _loc_7:* = param2 % MM_SECTOR_SIZE;
            this.m_BitmapData.setPixel32(_loc_6, _loc_7, param4);
            param5 = s_GetWaypointsSafe(param5);
            this.m_Cost[_loc_7 * MM_SECTOR_SIZE + _loc_6] = param5;
            this.m_MinCost = Math.min(this.m_MinCost, param5);
            this.m_Dirty = true;
            return;
        }// end function

        function saveByteArray(param1:ByteArray) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            param1.writeShort(this.m_SectorX & 65535);
            param1.writeShort(this.m_SectorY & 65535);
            param1.writeByte(this.m_SectorZ & 255);
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_3 = 0;
            while (_loc_3 < MM_SECTOR_SIZE)
            {
                
                _loc_2 = 0;
                while (_loc_2 < MM_SECTOR_SIZE)
                {
                    
                    _loc_5 = this.m_BitmapData.getPixel32(_loc_2, _loc_3) & 16777215;
                    _loc_6 = Colour.s_EightBitFromARGB(_loc_5);
                    param1.writeByte(_loc_6 & 255);
                    _loc_2++;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            while (_loc_3 < MM_SECTOR_SIZE)
            {
                
                _loc_2 = 0;
                while (_loc_2 < MM_SECTOR_SIZE)
                {
                    
                    param1.writeByte(this.m_Cost[_loc_3 * MM_SECTOR_SIZE + _loc_2] & 255);
                    _loc_2++;
                }
                _loc_3++;
            }
            param1.writeShort(this.m_Marks.length & 65535);
            for each (_loc_4 in this.m_Marks)
            {
                
                param1.writeShort(_loc_4.x & 65535);
                param1.writeShort(_loc_4.y & 65535);
                param1.writeByte(_loc_4.z & 255);
                param1.writeByte(_loc_4.icon);
                StringHelper.s_WriteToByteArray(param1, _loc_4.text, 65535);
            }
            return;
        }// end function

        function removeMark(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = this.m_Marks.length - 1;
            while (_loc_5 >= 0)
            {
                
                var _loc_6:* = this.m_Marks[_loc_5];
                _loc_4 = this.m_Marks[_loc_5];
                if (_loc_6 != null && _loc_4.x == param1 && _loc_4.y == param2)
                {
                    this.m_Marks.splice(_loc_5, 1);
                }
                _loc_5 = _loc_5 - 1;
            }
            this.m_Dirty = true;
            return;
        }// end function

        function get bitmapData() : BitmapData
        {
            return this.m_BitmapData;
        }// end function

        public function getSectorX() : int
        {
            return this.m_SectorX;
        }// end function

        public function getSectorY() : int
        {
            return this.m_SectorY;
        }// end function

        public function getSectorZ() : int
        {
            return this.m_SectorZ;
        }// end function

        public function get minCost() : int
        {
            return this.m_MinCost;
        }// end function

        static function s_GetSectorName(param1:Object, param2:int = 0, param3:int = 0) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = param1 as MiniMapSector;
            if (param1 as MiniMapSector != null)
            {
                _loc_4 = _loc_5.getSectorX();
                param2 = _loc_5.getSectorY();
                param3 = _loc_5.getSectorZ();
            }
            else
            {
                _loc_4 = int(param1);
            }
            _loc_4 = Math.floor(_loc_4 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            param2 = Math.floor(param2 / MM_SECTOR_SIZE) * MM_SECTOR_SIZE;
            return ("00000000" + _loc_4.toString(16)).substr(-8) + ("00000000" + param2.toString(16)).substr(-8) + ("00" + param3.toString(16)).substr(-2);
        }// end function

        private static function s_LoadSharedObjectInternal(param1:SharedObject, param2:MiniMapSector) : MiniMapSector
        {
            var Colours:ByteArray;
            var Waypoints:Vector.<int>;
            var Marks:Array;
            var BitmapRect:Rectangle;
            var BitmapOrigin:Point;
            var CurrentColours:BitmapData;
            var i:int;
            var CurrentMarks:Array;
            var Mark:Object;
            var j:int;
            var a_SharedObject:* = param1;
            var a_MiniMapSector:* = param2;
            var Data:Object;
            var _loc_4:* = a_SharedObject.data;
            Data = a_SharedObject.data;
            if (a_SharedObject != null && _loc_4 != null && Data.hasOwnProperty("version") && Data.hasOwnProperty("sectorX") && Data.hasOwnProperty("sectorY") && Data.hasOwnProperty("sectorZ") && Data.hasOwnProperty("bitmapDataBytes") && Data.hasOwnProperty("cost") && Data.hasOwnProperty("minCost") && Data.hasOwnProperty("mark"))
            {
                if (Data.version < MM_STORAGE_MIN_VERSION || Data.version > MM_STORAGE_MAX_VERSION)
                {
                    return null;
                }
                if (a_MiniMapSector != null && (a_MiniMapSector.m_SectorX != Data.sectorX || a_MiniMapSector.m_SectorY != Data.sectorY || a_MiniMapSector.m_SectorZ != Data.sectorZ))
                {
                    return null;
                }
                Colours = Data.bitmapDataBytes as ByteArray;
                if (Colours == null || Colours.bytesAvailable != MM_SECTOR_SIZE * MM_SECTOR_SIZE * 4)
                {
                    return null;
                }
                Waypoints = Data.cost as Vector.<int>;
                if (Waypoints == null || Waypoints.length != MM_SECTOR_SIZE * MM_SECTOR_SIZE)
                {
                    return null;
                }
                Marks = Data.mark as Array;
                if (Marks == null)
                {
                    return null;
                }
                try
                {
                    if (a_MiniMapSector == null)
                    {
                        a_MiniMapSector = new MiniMapSector(Data.sectorX, Data.sectorY, Data.sectorZ);
                    }
                }
                catch (_Error)
                {
                    return null;
                }
                BitmapRect = new Rectangle(0, 0, MM_SECTOR_SIZE, MM_SECTOR_SIZE);
                BitmapOrigin = new Point(0, 0);
                if (a_MiniMapSector.m_Dirty)
                {
                    CurrentColours = a_MiniMapSector.m_BitmapData.clone();
                    a_MiniMapSector.m_BitmapData.setPixels(BitmapRect, Colours);
                    a_MiniMapSector.m_BitmapData.copyPixels(CurrentColours, BitmapRect, BitmapOrigin, null, null, true);
                    i = (Waypoints.length - 1);
                    while (i >= 0)
                    {
                        
                        if (a_MiniMapSector.m_Cost[i] == PATH_COST_UNDEFINED)
                        {
                            a_MiniMapSector.m_Cost[i] = s_GetWaypointsSafe(Waypoints[i]);
                        }
                        i = (i - 1);
                    }
                    a_MiniMapSector.m_MinCost = Math.min(a_MiniMapSector.m_MinCost, s_GetWaypointsSafe(Data.minCost));
                    CurrentMarks = a_MiniMapSector.m_Marks;
                    a_MiniMapSector.m_Marks = Marks;
                    var _loc_4:* = 0;
                    var _loc_5:* = CurrentMarks;
                    while (_loc_5 in _loc_4)
                    {
                        
                        Mark = _loc_5[_loc_4];
                        a_MiniMapSector.setMark(Mark.x, Mark.y, Mark.z, Mark.icon, Mark.text);
                    }
                }
                else
                {
                    a_MiniMapSector.m_BitmapData.setPixels(BitmapRect, Colours);
                    j = (Waypoints.length - 1);
                    while (j >= 0)
                    {
                        
                        a_MiniMapSector.m_Cost[j] = s_GetWaypointsSafe(Waypoints[j]);
                        j = (j - 1);
                    }
                    a_MiniMapSector.m_MinCost = s_GetWaypointsSafe(Data.minCost);
                    a_MiniMapSector.m_Marks = Marks;
                }
                return a_MiniMapSector;
            }
            else
            {
                return null;
            }
        }// end function

        static function s_LoadSharedObject(param1:SharedObject) : MiniMapSector
        {
            return s_LoadSharedObjectInternal(param1, null);
        }// end function

        static function s_GetWaypointsSafe(param1:int) : int
        {
            if (param1 >= 0 && param1 <= PATH_COST_MAX || param1 == PATH_COST_OBSTACLE)
            {
                return param1;
            }
            return PATH_COST_UNDEFINED;
        }// end function

    }
}
