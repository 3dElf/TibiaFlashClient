package tibia.appearances.widgetClasses
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import mx.core.*;
    import shared.utility.*;
    import tibia.appearances.*;

    public class MarksView extends Object
    {
        private var m_MarksViewInformations:Vector.<MarksViewInformation> = null;
        private var m_MarksStartSize:uint = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        public static var s_FrameCache:BitmapData = null;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        private static var s_TempMarkBitmap:BitmapData = null;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static var s_FrameMarks:BitmapData = null;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
        private static var s_FrameCacheRectangles:Vector.<Rectangle> = null;
        static const FIELD_SIZE:int = 32;
        static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
        static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
        static const PLAYER_OFFSET_X:int = 8;
        static const MAPSIZE_W:int = 10;
        static const MAPSIZE_X:int = 18;
        static const MAPSIZE_Y:int = 14;
        static const MAPSIZE_Z:int = 8;
        static const MAP_MAX_X:int = MAP_MIN_X + ((1 << 14) - 1);
        static const MAP_MAX_Y:int = MAP_MIN_Y + ((1 << 14) - 1);
        static const MAP_MAX_Z:int = 15;
        static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
        public static var s_NextFrameCacheIndex:uint = 0;
        static const MAP_WIDTH:int = 15;
        public static const MARK_THICKNESS_THIN:uint = 1;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        private static var s_FrameColors:Vector.<uint> = null;
        public static const MARK_THICKNESS_BOLD:uint = 2;
        public static const FRAME_SIZES_COUNT:uint = 15;
        private static var s_FrameCacheDictionary:Dictionary = null;
        static const GROUND_LAYER:int = 7;
        private static const CACHE_DIMENSION:uint = 10;

        public function MarksView(param1:uint = 0)
        {
            if (param1 >= FRAME_SIZES_COUNT)
            {
                throw new Error("MarksView.MarksView: Invalid marks start size.");
            }
            this.m_MarksStartSize = param1;
            this.m_MarksViewInformations = new Vector.<MarksViewInformation>;
            return;
        }// end function

        public function addMarkToView(param1:uint, param2:uint) : void
        {
            var _loc_4:* = null;
            if (param2 != MARK_THICKNESS_THIN && param2 != MARK_THICKNESS_BOLD)
            {
                throw new Error("MarksView.addMarkToView: Invalid marks thickness: " + param2);
            }
            var _loc_3:* = this.m_MarksStartSize;
            for each (_loc_4 in this.m_MarksViewInformations)
            {
                
                _loc_3 = _loc_3 + _loc_4.m_MarkThickness;
            }
            if (_loc_3 + param2 > FRAME_SIZES_COUNT)
            {
                throw new Error("MarksView.addMarkToView: Adding this mark will exceed the minimum frame size");
            }
            var _loc_5:* = new MarksViewInformation();
            _loc_5.m_MarkType = param1;
            _loc_5.m_MarkThickness = param2;
            _loc_7.push(_loc_5);
            return;
        }// end function

        public function getMarksBitmap(param1:Marks, param2:Rectangle) : BitmapData
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_3:* = new Vector.<uint>;
            var _loc_4:* = this.m_MarksStartSize;
            var _loc_5:* = 0;
            for each (_loc_6 in this.m_MarksViewInformations)
            {
                
                if (param1.isMarkSet(_loc_6.m_MarkType))
                {
                    _loc_3.push(_loc_4 + (_loc_6.m_MarkThickness - 1) * FRAME_SIZES_COUNT);
                    _loc_4 = _loc_4 + _loc_6.m_MarkThickness;
                    _loc_3.push(param1.getMarkColor(_loc_6.m_MarkType));
                }
            }
            _loc_7 = s_CreateCacheKey(_loc_3);
            _loc_8 = null;
            _loc_9 = 0;
            if (s_FrameCacheDictionary.hasOwnProperty(_loc_7))
            {
                _loc_9 = s_FrameCacheDictionary[_loc_7];
                _loc_8 = s_FrameCacheRectangles[_loc_9];
            }
            else
            {
                _loc_9 = s_NextFrameCacheIndex++ % s_FrameCacheRectangles.length;
                for (_loc_10 in s_FrameCacheDictionary)
                {
                    
                    if (uint(_loc_14[_loc_10]) == _loc_9)
                    {
                        delete _loc_14[_loc_10];
                        break;
                    }
                }
                _loc_8 = s_FrameCacheRectangles[_loc_9];
                s_FrameCache.fillRect(_loc_8, 0);
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    _loc_11 = _loc_3[_loc_5];
                    _loc_12 = _loc_3[(_loc_5 + 1)];
                    if (_loc_12 < Marks.MARK_NUM_TOTAL)
                    {
                        s_TempMarkBitmap.fillRect(s_TempMarkBitmap.rect, 4278190080 | s_FrameColors[_loc_12]);
                        s_FrameCache.copyPixels(s_TempMarkBitmap, s_TempMarkBitmap.rect, _loc_8.topLeft, s_FrameMarks, new Point(_loc_11 % FRAME_SIZES_COUNT * FIELD_SIZE, int(_loc_11 / FRAME_SIZES_COUNT) * FIELD_SIZE), true);
                    }
                    _loc_5 = _loc_5 + 2;
                }
                _loc_14[_loc_7] = _loc_9;
            }
            param2.copyFrom(_loc_8);
            return s_FrameCache;
        }// end function

        public function get marksStartSize() : uint
        {
            return this.m_MarksStartSize;
        }// end function

        private static function s_CreateCacheKey(param1:Vector.<uint>) : String
        {
            if (param1.length % 2 != 0)
            {
                throw new ArgumentError("Marks.s_CreateCacheKey: Invalid Frame Information");
            }
            return param1.join(",");
        }// end function

        public static function s_MarkThickness(param1:uint) : uint
        {
            return param1 / FRAME_SIZES_COUNT + 1;
        }// end function

        private static function s_InitialiseFrameMarks() : void
        {
            var _loc_9:* = 0;
            var _loc_1:* = 0;
            s_FrameColors = new Vector.<uint>(Marks.MARK_NUM_TOTAL, true);
            _loc_1 = 0;
            while (_loc_1 < Marks.MARK_NUM_COLOURS)
            {
                
                s_FrameColors[_loc_1] = Colour.s_RGBFromEightBit(_loc_1);
                _loc_1++;
            }
            s_FrameColors[Marks.MARK_AIM] = 248 << 16 | 248 << 8 | 248;
            s_FrameColors[Marks.MARK_AIM_ATTACK] = 248 << 16 | 164 << 8 | 164;
            s_FrameColors[Marks.MARK_AIM_FOLLOW] = 180 << 16 | 248 << 8 | 180;
            s_FrameColors[Marks.MARK_ATTACK] = 224 << 16 | 64 << 8 | 64;
            s_FrameColors[Marks.MARK_FOLLOW] = 64 << 16 | 224 << 8 | 64;
            var _loc_2:* = new FlexShape();
            var _loc_3:* = _loc_2.graphics;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            _loc_3.lineStyle(1, 4278190080, 1, true, LineScaleMode.NONE);
            var _loc_7:* = 0;
            _loc_7 = 0;
            while (_loc_7 < FRAME_SIZES_COUNT)
            {
                
                _loc_3.drawRect(_loc_7 * FIELD_SIZE + _loc_7, _loc_7, FIELD_SIZE - _loc_7 * 2 - 1, FIELD_SIZE - _loc_7 * 2 - 1);
                _loc_3.drawRect(_loc_7 * FIELD_SIZE + _loc_7, FIELD_SIZE + _loc_7, FIELD_SIZE - _loc_7 * 2 - 1, FIELD_SIZE - _loc_7 * 2 - 1);
                _loc_3.drawRect(_loc_7 * FIELD_SIZE + _loc_7 + 1, FIELD_SIZE + _loc_7 + 1, FIELD_SIZE - (_loc_7 + 1) * 2 - 1, FIELD_SIZE - (_loc_7 + 1) * 2 - 1);
                _loc_7 = _loc_7 + 1;
            }
            s_FrameMarks = new BitmapData(FRAME_SIZES_COUNT * FIELD_SIZE, FIELD_SIZE * 2, true, 0);
            s_FrameMarks.draw(_loc_2);
            s_TempMarkBitmap = new BitmapData(FIELD_SIZE, FIELD_SIZE, true, 0);
            s_FrameCache = new BitmapData(CACHE_DIMENSION * FIELD_SIZE, CACHE_DIMENSION * FIELD_SIZE, true, 16777215);
            s_FrameCacheRectangles = new Vector.<Rectangle>(CACHE_DIMENSION * CACHE_DIMENSION, true);
            var _loc_8:* = 0;
            while (_loc_8 < CACHE_DIMENSION)
            {
                
                _loc_9 = 0;
                while (_loc_9 < CACHE_DIMENSION)
                {
                    
                    s_FrameCacheRectangles[_loc_9 * CACHE_DIMENSION + _loc_8] = new Rectangle(_loc_8 * FIELD_SIZE, _loc_9 * FIELD_SIZE, FIELD_SIZE, FIELD_SIZE);
                    _loc_9 = _loc_9 + 1;
                }
                _loc_8 = _loc_8 + 1;
            }
            s_FrameCacheDictionary = new Dictionary();
            return;
        }// end function

        s_InitialiseFrameMarks();
    }
}

import __AS3__.vec.*;

import flash.display.*;

import flash.geom.*;

import flash.utils.*;

import mx.core.*;

import shared.utility.*;

import tibia.appearances.*;

class MarksViewInformation extends Object
{
    public var m_MarkType:uint = 255;
    public var m_MarkThickness:uint = 1;

    function MarksViewInformation()
    {
        return;
    }// end function

}

