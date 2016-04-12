package tibia.appearances
{
    import __AS3__.vec.*;

    public class AppearanceAnimator extends Object
    {
        private var m_PhaseCount:uint;
        private var m_LastAnimationTick:Number = 0;
        private var m_NextFrameStrategy:NextFrameStrategy;
        private var m_FrameDurations:Vector.<FrameDuration>;
        private var m_CurrentPhaseDuration:uint;
        private var m_HasFinishedAnimation:Boolean = false;
        private var m_StartPhase:int;
        private var m_AnimationType:int;
        private var m_CurrentPhase:uint;
        private static const ENVIRONMENTAL_EFFECTS:Array = [];
        public static const ANIMATION_DELAY_BEFORE_RESET:int = 1000;
        public static const FRAME_GROUP_WALKING:uint = 1;
        public static const PHASE_AUTOMATIC:int = -1;
        static const APPEARANCE_EFFECT:uint = 2;
        public static const SPRITE_CACHE_PAGE_DIMENSION:uint = 512;
        public static const FRAME_GROUP_DEFAULT:uint = 0;
        private static const MAX_SPEED_DELAY:int = 100;
        public static const FRAME_GROUP_IDLE:uint = 0;
        public static const COMPRESSED_IMAGES_CACHE_MEMORY:uint = 3.53894e+007;
        public static const ANIMATION_ASYNCHRON:int = 0;
        static const APPEARANCE_MISSILE:uint = 3;
        public static const PHASE_RANDOM:int = 254;
        private static const MINIMUM_SPEED_FRAME_DURATION:int = 720;
        public static const PHASE_ASYNCHRONOUS:int = 255;
        public static const SPRITE_CACHE_PAGE_COUNT:uint = 25;
        private static const MIN_SPEED_DELAY:int = 550;
        static const APPEARANCE_OBJECT:uint = 0;
        private static const MAXIMUM_SPEED_FRAME_DURATION:int = 280;
        static const APPEARANCE_OUTFIT:uint = 1;
        public static const ANIMATION_SYNCHRON:int = 1;

        public function AppearanceAnimator(param1:uint, param2:int, param3:int, param4:int, param5:Vector.<FrameDuration>)
        {
            if (param4 != ANIMATION_ASYNCHRON && param4 != ANIMATION_SYNCHRON)
            {
                throw new ArgumentError("AppearanceAnimator: Unexpected animation type " + param4);
            }
            if (param5.length != param1)
            {
                throw new ArgumentError("AppearanceAnimator: Frameduration differs from phase count");
            }
            if (param2 < -1 || param2 >= param1)
            {
                throw new ArgumentError("AppearanceAnimator: Invalid start phase " + param2);
            }
            this.m_PhaseCount = param1;
            this.m_StartPhase = param2;
            this.m_AnimationType = param4;
            this.m_FrameDurations = param5;
            this.m_LastAnimationTick = Tibia.s_FrameTibiaTimestamp > 0 ? (Tibia.s_FrameTibiaTimestamp) : (Tibia.s_GetTibiaTimer());
            if (param3 < 0)
            {
                this.m_NextFrameStrategy = new PingPongFrameStrategy();
            }
            else
            {
                this.m_NextFrameStrategy = new LoopFrameStrategy(param3);
            }
            this.phase = PHASE_AUTOMATIC;
            return;
        }// end function

        public function get frameDurations() : Vector.<FrameDuration>
        {
            return this.m_FrameDurations;
        }// end function

        public function setEndless() : void
        {
            this.m_NextFrameStrategy = new LoopFrameStrategy(0);
            this.reset();
            return;
        }// end function

        public function get lastAnimationTick() : Number
        {
            return this.m_LastAnimationTick;
        }// end function

        public function reset() : void
        {
            this.phase = PHASE_AUTOMATIC;
            this.m_HasFinishedAnimation = false;
            this.m_NextFrameStrategy.reset();
            return;
        }// end function

        public function get phaseCount() : uint
        {
            return this.m_PhaseCount;
        }// end function

        public function clone() : AppearanceAnimator
        {
            var _loc_1:* = null;
            if (this.m_AnimationType == ANIMATION_SYNCHRON)
            {
                return this;
            }
            _loc_1 = new AppearanceAnimator(this.m_PhaseCount, this.m_StartPhase, 0, this.m_AnimationType, this.m_FrameDurations);
            _loc_1.m_NextFrameStrategy = this.m_NextFrameStrategy.clone();
            _loc_1.phase = PHASE_AUTOMATIC;
            return _loc_1;
        }// end function

        public function get animationType() : int
        {
            return this.m_AnimationType;
        }// end function

        public function get finished() : Boolean
        {
            return this.m_HasFinishedAnimation;
        }// end function

        public function animate(param1:Number, param2:int = 0) : void
        {
            var _loc_3:* = NaN;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 != this.m_LastAnimationTick && !this.m_HasFinishedAnimation)
            {
                _loc_3 = param1 - this.m_LastAnimationTick;
                if (_loc_3 >= this.m_CurrentPhaseDuration)
                {
                    _loc_4 = this.m_NextFrameStrategy.nextFrame(this.m_CurrentPhase, this.m_PhaseCount);
                    if (this.m_CurrentPhase != _loc_4)
                    {
                        _loc_5 = param2 == 0 ? (this.m_FrameDurations[_loc_4].duration - (_loc_3 - this.m_CurrentPhaseDuration)) : (this.calculateMovementPhaseDuration(param2));
                        if (_loc_5 < 0 && this.m_AnimationType == ANIMATION_SYNCHRON)
                        {
                            this.calculateSynchronousPhase();
                        }
                        else
                        {
                            this.m_CurrentPhase = _loc_4;
                            this.m_CurrentPhaseDuration = Math.max(0, _loc_5);
                        }
                    }
                    else
                    {
                        this.m_HasFinishedAnimation = true;
                    }
                }
                else
                {
                    this.m_CurrentPhaseDuration = this.m_CurrentPhaseDuration - _loc_3;
                }
                this.m_LastAnimationTick = param1;
            }
            return;
        }// end function

        public function set phase(param1:int) : void
        {
            if (this.m_AnimationType == ANIMATION_ASYNCHRON)
            {
                if (param1 == PHASE_ASYNCHRONOUS)
                {
                    this.m_CurrentPhase = 0;
                }
                else if (param1 == PHASE_RANDOM)
                {
                    this.m_CurrentPhase = Math.floor(Math.random() * this.m_PhaseCount);
                }
                else if (param1 >= 0 && param1 < this.m_PhaseCount)
                {
                    this.m_CurrentPhase = param1;
                }
                else
                {
                    this.m_CurrentPhase = this.startPhase;
                }
                this.m_HasFinishedAnimation = false;
                this.m_CurrentPhaseDuration = this.m_FrameDurations[this.m_CurrentPhase].duration;
            }
            else
            {
                this.calculateSynchronousPhase();
            }
            return;
        }// end function

        private function calculateSynchronousPhase() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.m_PhaseCount)
            {
                
                _loc_6 = this.m_FrameDurations[_loc_2];
                _loc_1 = _loc_1 + _loc_6.duration;
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = Tibia.s_FrameTibiaTimestamp > 0 ? (Tibia.s_FrameTibiaTimestamp) : (Tibia.s_GetTibiaTimer());
            var _loc_4:* = _loc_3 % _loc_1;
            var _loc_5:* = 0;
            _loc_2 = 0;
            while (_loc_2 < this.m_PhaseCount)
            {
                
                _loc_7 = _loc_6.duration;
                if (_loc_4 >= _loc_5 && _loc_4 < _loc_5 + _loc_7)
                {
                    this.m_CurrentPhase = _loc_2;
                    _loc_8 = _loc_4 - _loc_5;
                    this.m_CurrentPhaseDuration = _loc_7 - _loc_8;
                    break;
                }
                else
                {
                    _loc_5 = _loc_5 + _loc_7;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.m_LastAnimationTick = _loc_3;
            return;
        }// end function

        public function get startPhase() : uint
        {
            if (this.m_StartPhase > -1)
            {
                return this.m_StartPhase;
            }
            return Math.floor(Math.random() * this.m_PhaseCount);
        }// end function

        private function calculateMovementPhaseDuration(param1:int) : Number
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = MAX_SPEED_DELAY;
            _loc_3 = MIN_SPEED_DELAY;
            var _loc_4:* = Math.min(Math.max(_loc_2, param1), _loc_3);
            var _loc_5:* = Number(_loc_4 - _loc_2) / Number(_loc_3 - _loc_2);
            var _loc_6:* = MINIMUM_SPEED_FRAME_DURATION / this.m_PhaseCount;
            var _loc_7:* = MAXIMUM_SPEED_FRAME_DURATION / this.m_PhaseCount;
            return (_loc_6 - _loc_7) * _loc_5 + _loc_7;
        }// end function

        public function get phase() : int
        {
            return this.m_CurrentPhase;
        }// end function

        public function set finished(param1:Boolean) : void
        {
            this.m_HasFinishedAnimation = param1;
            return;
        }// end function

    }
}

import __AS3__.vec.*;

class PingPongFrameStrategy extends NextFrameStrategy
{
    private var m_CurrentDirection:int = 0;
    private static const PHASE_FORWARD:int = 0;
    private static const PHASE_BACKWARD:int = 1;

    function PingPongFrameStrategy()
    {
        return;
    }// end function

    override public function nextFrame(param1:uint, param2:uint) : uint
    {
        var _loc_3:* = this.m_CurrentDirection == PHASE_FORWARD ? (1) : (-1);
        var _loc_4:* = param1 + _loc_3;
        if (param1 + _loc_3 < 0 || _loc_4 >= param2)
        {
            this.m_CurrentDirection = this.m_CurrentDirection == PHASE_FORWARD ? (PHASE_BACKWARD) : (PHASE_FORWARD);
            _loc_3 = _loc_3 * -1;
        }
        return param1 + _loc_3;
    }// end function

    override public function clone() : NextFrameStrategy
    {
        var _loc_1:* = new PingPongFrameStrategy();
        _loc_1.m_CurrentDirection = this.m_CurrentDirection;
        return _loc_1;
    }// end function

    override public function reset() : void
    {
        this.m_CurrentDirection = PHASE_FORWARD;
        return;
    }// end function

}


import __AS3__.vec.*;

class LoopFrameStrategy extends NextFrameStrategy
{
    private var m_LoopCount:uint;
    private var m_CurrentLoop:uint = 0;

    function LoopFrameStrategy(param1:uint)
    {
        this.m_LoopCount = param1;
        return;
    }// end function

    override public function nextFrame(param1:uint, param2:uint) : uint
    {
        var _loc_3:* = param1 + 1;
        if (_loc_3 < param2)
        {
            return _loc_3;
        }
        if (this.m_CurrentLoop < (this.m_LoopCount - 1) || this.m_LoopCount == 0)
        {
            var _loc_4:* = this;
            var _loc_5:* = this.m_CurrentLoop + 1;
            _loc_4.m_CurrentLoop = _loc_5;
            return 0;
        }
        return param1;
    }// end function

    override public function clone() : NextFrameStrategy
    {
        var _loc_1:* = new LoopFrameStrategy(this.m_LoopCount);
        _loc_1.m_CurrentLoop = this.m_CurrentLoop;
        return _loc_1;
    }// end function

    override public function reset() : void
    {
        this.m_CurrentLoop = 0;
        return;
    }// end function

}

