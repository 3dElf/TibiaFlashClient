package tibia.worldmap.widgetClasses
{
    import flash.display.*;
    import flash.geom.*;
    import tibia.appearances.*;
    import tibia.creatures.*;

    public class ObjectCursor extends TileCursor
    {
        private var m_MaskRect:Rectangle;
        private var m_MaskBitmapData:BitmapData = null;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        static const s_TempPoint2:Point = new Point(0, 0);
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        static const FIELD_CACHESIZE:int = 32;
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        static const MAP_MIN_X:int = 24576;
        static const MAP_MIN_Y:int = 24576;
        static const MAP_MIN_Z:int = 0;
        static const PLAYER_OFFSET_Y:int = 6;
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
        static const MAP_WIDTH:int = 15;
        static const NUM_ONSCREEN_MESSAGES:int = 16;
        static const GROUND_LAYER:int = 7;

        public function ObjectCursor()
        {
            this.m_MaskRect = new Rectangle(0, 0, 0, 0);
            return;
        }// end function

        public function get maskBitmapData() : BitmapData
        {
            return this.m_MaskBitmapData;
        }// end function

        public function copyMaskFromCreature(param1:Creature) : void
        {
            s_TempPoint.setTo(0, 0);
            this.m_MaskRect.setTo(0, 0, 0, 0);
            var _loc_2:* = null;
            var _loc_3:* = param1.outfit.type;
            _loc_2 = param1.outfit.type;
            if (param1.outfit != null && _loc_3 != null)
            {
                this.m_MaskRect.width = Math.max(this.m_MaskRect.width, _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].width * FIELD_SIZE + _loc_2.displacementX);
                this.m_MaskRect.height = Math.max(this.m_MaskRect.height, _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].height * FIELD_SIZE + _loc_2.displacementY);
                s_TempPoint.setTo(_loc_2.displacementX, _loc_2.displacementY);
            }
            var _loc_3:* = param1.mountOutfit.type;
            _loc_2 = param1.mountOutfit.type;
            if (param1.mountOutfit != null && _loc_3 != null)
            {
                this.m_MaskRect.width = Math.max(this.m_MaskRect.width, _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].width * FIELD_SIZE + _loc_2.displacementX) + s_TempPoint.x;
                this.m_MaskRect.height = Math.max(this.m_MaskRect.height, _loc_2.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].height * FIELD_SIZE + _loc_2.displacementY) + s_TempPoint.y;
            }
            if (this.m_MaskBitmapData == null || this.m_MaskBitmapData.width < this.m_MaskRect.width || this.m_MaskBitmapData.height < this.m_MaskRect.height)
            {
                this.m_MaskBitmapData = new BitmapData(this.m_MaskRect.width, this.m_MaskRect.height, true, 0);
            }
            else
            {
                this.m_MaskBitmapData.fillRect(this.m_MaskRect, 0);
            }
            if (param1.mountOutfit != null)
            {
                param1.mountOutfit.drawTo(this.m_MaskBitmapData, this.m_MaskRect.width - s_TempPoint.x, this.m_MaskRect.height - s_TempPoint.y, param1.direction, 0, 0);
            }
            if (param1.outfit != null)
            {
                param1.outfit.drawTo(this.m_MaskBitmapData, this.m_MaskRect.width, this.m_MaskRect.height, param1.direction, 0, param1.mountOutfit != null ? (1) : (0));
            }
            return;
        }// end function

        public function copyMaskFromAppearance(param1:AppearanceInstance, param2:int = -1, param3:int = -1, param4:int = -1) : void
        {
            var _loc_5:* = param1.type;
            this.m_MaskRect.setTo(0, 0, _loc_5.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].width * FIELD_SIZE + _loc_5.displacementX, _loc_5.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].height * FIELD_SIZE + _loc_5.displacementY);
            if (this.m_MaskBitmapData == null || this.m_MaskBitmapData.width < this.m_MaskRect.width || this.m_MaskBitmapData.height < this.m_MaskRect.height)
            {
                this.m_MaskBitmapData = new BitmapData(this.m_MaskRect.width, this.m_MaskRect.height, true, 0);
            }
            else
            {
                this.m_MaskBitmapData.fillRect(this.m_MaskRect, 0);
            }
            param1.drawTo(this.m_MaskBitmapData, this.m_MaskRect.width, this.m_MaskRect.height, param2, param3, param4);
            return;
        }// end function

        public function set maskBitmapData(param1:BitmapData) : void
        {
            if (this.m_MaskBitmapData != param1)
            {
                this.m_MaskBitmapData = param1;
                if (this.m_MaskBitmapData != null)
                {
                    this.m_MaskRect.setTo(0, 0, this.m_MaskBitmapData.width, this.m_MaskBitmapData.height);
                }
                else
                {
                    this.m_MaskRect.setTo(0, 0, 0, 0);
                }
            }
            return;
        }// end function

        public function clearMask() : void
        {
            if (this.m_MaskBitmapData != null)
            {
                this.m_MaskBitmapData.fillRect(this.m_MaskRect, 0);
            }
            return;
        }// end function

        public function copyMaskFromBitmap(param1:BitmapData, param2:Rectangle) : void
        {
            this.m_MaskRect.setTo(0, 0, param2.width, param2.height);
            if (this.m_MaskBitmapData == null || this.m_MaskBitmapData.width < this.m_MaskRect.width || this.m_MaskBitmapData.height < this.m_MaskRect.height)
            {
                this.m_MaskBitmapData = new BitmapData(this.m_MaskRect.width, this.m_MaskRect.height, true, 0);
            }
            else
            {
                this.m_MaskBitmapData.fillRect(this.m_MaskRect, 0);
            }
            this.m_MaskBitmapData.copyPixels(param1, this.m_MaskRect, s_TempPoint2);
            return;
        }// end function

        override public function drawTo(param1:BitmapData, param2:Number, param3:Number, param4:Number = NaN) : void
        {
            commitProperties();
            s_TempRect.setTo((getFrameIndex(param4) + 1) * m_CachedFrameSize.width - this.m_MaskRect.width, m_CachedFrameSize.height - this.m_MaskRect.height, this.m_MaskRect.width, this.m_MaskRect.height);
            s_TempPoint.setTo(param2 - this.m_MaskRect.width, param3 - this.m_MaskRect.height);
            param1.copyPixels(m_CachedBitmapData, s_TempRect, s_TempPoint, this.m_MaskBitmapData, s_TempPoint2, true);
            return;
        }// end function

        public static function createFromColor(param1:uint, param2:Number, param3:Number, param4:int, param5:Number, param6:Number) : ObjectCursor
        {
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            if (param2 < 0 || param3 > 1)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Invalid minimum opacity.");
            }
            if (param3 < 0 || param3 > 1)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Invalid maximum opacity.");
            }
            if (param2 > param3)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Minimum opacity must not exceed maximum opacity.");
            }
            if (param4 < 1)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Invalid frame count.");
            }
            if (param5 < 1)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Invalid frame size.");
            }
            if (param6 < 0)
            {
                throw new ArgumentError("ObjectCursor.createFromColor: Invalid frame duration.");
            }
            var _loc_7:* = new BitmapData(param4 * param5, param5);
            var _loc_8:* = int(param4 / 2);
            var _loc_9:* = 0;
            while (_loc_9 < param4)
            {
                
                _loc_11 = 0;
                if (_loc_9 < _loc_8)
                {
                    _loc_11 = 1 - _loc_9 / _loc_8;
                }
                else if (_loc_9 > param4 - _loc_8)
                {
                    _loc_11 = (_loc_9 - (param4 - _loc_8)) / _loc_8;
                }
                _loc_11 = _loc_11 * param3 + (1 - _loc_11) * param2;
                _loc_11 = _loc_11 * 255;
                _loc_12 = uint(_loc_11) << 24 | param1 & 16777215;
                s_TempRect.setTo(_loc_9 * param5, 0, param5, param5);
                _loc_7.fillRect(s_TempRect, _loc_12);
                _loc_9++;
            }
            var _loc_10:* = new ObjectCursor;
            _loc_10.bitmapData = _loc_7;
            _loc_10.frameDuration = param6;
            return _loc_10;
        }// end function

    }
}
