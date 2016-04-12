package tibia.appearances
{
    import shared.utility.*;

    public class MissileInstance extends AppearanceInstance
    {
        protected var m_PatternX:int = 0;
        protected var m_Position:Vector3D = null;
        protected var m_Target:Vector3D = null;
        protected var m_AnimationEnd:Number = 0;
        protected var m_AnimationDirection:int = 0;
        protected var m_AnimationDelta:Vector3D = null;
        protected var m_PatternY:int = 0;
        protected var m_AnimationSpeed:Vector3D;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
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

        public function MissileInstance(param1:uint, param2:AppearanceType, param3:Vector3D, param4:Vector3D)
        {
            this.m_AnimationSpeed = new Vector3D();
            super(param1, param2);
            phase = AppearanceAnimator.PHASE_ASYNCHRONOUS;
            this.m_AnimationDelta = param4.sub(param3);
            if (this.m_AnimationDelta.x == 0)
            {
                if (this.m_AnimationDelta.y <= 0)
                {
                    this.m_AnimationDirection = 0;
                }
                else
                {
                    this.m_AnimationDirection = 4;
                }
            }
            else if (this.m_AnimationDelta.x > 0)
            {
                if (256 * this.m_AnimationDelta.y > 618 * this.m_AnimationDelta.x)
                {
                    this.m_AnimationDirection = 4;
                }
                else if (256 * this.m_AnimationDelta.y > 106 * this.m_AnimationDelta.x)
                {
                    this.m_AnimationDirection = 3;
                }
                else if (256 * this.m_AnimationDelta.y > -106 * this.m_AnimationDelta.x)
                {
                    this.m_AnimationDirection = 2;
                }
                else if (256 * this.m_AnimationDelta.y > -618 * this.m_AnimationDelta.x)
                {
                    this.m_AnimationDirection = 1;
                }
                else
                {
                    this.m_AnimationDirection = 0;
                }
            }
            else if (-256 * this.m_AnimationDelta.y < 618 * this.m_AnimationDelta.x)
            {
                this.m_AnimationDirection = 4;
            }
            else if (-256 * this.m_AnimationDelta.y < 106 * this.m_AnimationDelta.x)
            {
                this.m_AnimationDirection = 5;
            }
            else if (-256 * this.m_AnimationDelta.y < -106 * this.m_AnimationDelta.x)
            {
                this.m_AnimationDirection = 6;
            }
            else if (-256 * this.m_AnimationDelta.y < -618 * this.m_AnimationDelta.x)
            {
                this.m_AnimationDirection = 7;
            }
            else
            {
                this.m_AnimationDirection = 0;
            }
            switch(this.m_AnimationDirection)
            {
                case 0:
                {
                    this.m_PatternX = 1;
                    this.m_PatternY = 0;
                    break;
                }
                case 1:
                {
                    this.m_PatternX = 2;
                    this.m_PatternY = 0;
                    break;
                }
                case 2:
                {
                    this.m_PatternX = 2;
                    this.m_PatternY = 1;
                    break;
                }
                case 3:
                {
                    this.m_PatternX = 2;
                    this.m_PatternY = 2;
                    break;
                }
                case 4:
                {
                    this.m_PatternX = 1;
                    this.m_PatternY = 2;
                    break;
                }
                case 5:
                {
                    this.m_PatternX = 0;
                    this.m_PatternY = 2;
                    break;
                }
                case 6:
                {
                    this.m_PatternX = 0;
                    this.m_PatternY = 1;
                    break;
                }
                case 7:
                {
                    this.m_PatternX = 0;
                    this.m_PatternY = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_5:* = Math.sqrt(this.m_AnimationDelta.x * this.m_AnimationDelta.x + this.m_AnimationDelta.y * this.m_AnimationDelta.y);
            var _loc_6:* = Math.sqrt(_loc_5) * 150;
            this.m_AnimationDelta.x = this.m_AnimationDelta.x * (-FIELD_SIZE);
            this.m_AnimationDelta.y = this.m_AnimationDelta.y * (-FIELD_SIZE);
            this.m_AnimationDelta.z = 0;
            this.m_AnimationSpeed = new Vector3D(this.m_AnimationDelta.x, this.m_AnimationDelta.y, int(_loc_6));
            this.m_AnimationEnd = Tibia.s_FrameTibiaTimestamp + _loc_6;
            this.m_Target = param4;
            this.m_Position = param3;
            return;
        }// end function

        public function get animationDelta() : Vector3D
        {
            var _loc_1:* = this.m_AnimationDelta.clone();
            _loc_1.x = _loc_1.x + (this.m_Target.x - this.m_Position.x) * FIELD_SIZE;
            _loc_1.y = _loc_1.y + (this.m_Target.y - this.m_Position.y) * FIELD_SIZE;
            return _loc_1;
        }// end function

        public function get position() : Vector3D
        {
            return this.m_Position;
        }// end function

        public function get target() : Vector3D
        {
            return this.m_Target;
        }// end function

        override public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_5:* = param1 >= 0 ? (param1 % m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].phases) : (phase);
            _loc_6 = this.m_PatternY;
            _loc_7 = this.m_PatternX;
            var _loc_8:* = ((_loc_5 * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternDepth + 0) * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternHeight + _loc_6) * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternWidth + _loc_7;
            return ((_loc_5 * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternDepth + 0) * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternHeight + _loc_6) * m_Type.FrameGroups[FrameGroup.FRAME_GROUP_DEFAULT].patternWidth + _loc_7;
        }// end function

        override public function animate(param1:Number, param2:int = 0) : Boolean
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            super.animate(param1);
            var _loc_3:* = param1 - (this.m_AnimationEnd - this.m_AnimationSpeed.z);
            if (_loc_3 <= 0)
            {
                this.m_AnimationDelta.x = this.m_AnimationSpeed.x;
                this.m_AnimationDelta.y = this.m_AnimationSpeed.y;
            }
            else if (_loc_3 >= this.m_AnimationSpeed.z)
            {
                this.m_AnimationDelta.x = 0;
                this.m_AnimationDelta.y = 0;
            }
            else
            {
                this.m_AnimationDelta.x = this.m_AnimationSpeed.x - int(this.m_AnimationSpeed.x / this.m_AnimationSpeed.z * _loc_3 + 0.5);
                this.m_AnimationDelta.y = this.m_AnimationSpeed.y - int(this.m_AnimationSpeed.y / this.m_AnimationSpeed.z * _loc_3 + 0.5);
            }
            if (this.m_AnimationDelta.x == 0 && this.m_AnimationDelta.y == 0 || param1 >= this.m_AnimationEnd)
            {
                return false;
            }
            _loc_4 = (this.m_Target.x + 1) * FIELD_SIZE - m_Type.displacementX + this.m_AnimationDelta.x;
            _loc_5 = (this.m_Target.y + 1) * FIELD_SIZE - m_Type.displacementY + this.m_AnimationDelta.y;
            this.m_Position.x = int((_loc_4 - 1) / FIELD_SIZE);
            this.m_Position.y = int((_loc_5 - 1) / FIELD_SIZE);
            return true;
        }// end function

        public function get direction() : int
        {
            return this.m_AnimationDirection;
        }// end function

    }
}
