package tibia.appearances
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import tibia.appearances.widgetClasses.*;

    public class AppearanceInstance extends Object
    {
        protected var m_LastPhase:int = -2.14748e+009;
        protected var m_LastInternalPhase:int = -2.14748e+009;
        protected var m_CacheDirty:Boolean = false;
        protected var m_LastCachedSpriteIndex:uint = 4.29497e+009;
        var mapData:int = -1;
        protected var m_ActiveFrameGroup:uint = 0;
        var m_Type:AppearanceType = null;
        var m_ID:int = 0;
        protected var m_LastPatternX:int = -2.14748e+009;
        protected var m_LastPatternY:int = -2.14748e+009;
        protected var m_LastPatternZ:int = -2.14748e+009;
        protected var m_Animators:Object;
        var mapField:int = -1;
        protected var m_TempAlternativePhases:Vector.<uint> = null;
        static const s_TempRect:Rectangle = new Rectangle(0, 0, 0, 0);
        public static const CREATURE:int = 99;
        public static const OUTDATEDCREATURE:int = 98;
        public static const UNKNOWNCREATURE:int = 97;
        static const s_TempPoint:Point = new Point(0, 0);
        public static const PURSE:int = 16087;

        public function AppearanceInstance(param1:int, param2:AppearanceType)
        {
            var _loc_3:* = null;
            this.m_Animators = {};
            this.m_ID = param1;
            this.m_Type = param2;
            if (this.m_Type != null && this.m_Type.FrameGroups[this.m_ActiveFrameGroup].isAnimation)
            {
                this.m_TempAlternativePhases = new Vector.<uint>(this.m_Type.FrameGroups[this.m_ActiveFrameGroup].phases, true);
            }
            if (param2 != null)
            {
                for (_loc_3 in param2.FrameGroups)
                {
                    
                    if (_loc_5[_loc_3].animator != null)
                    {
                        this.m_Animators[parseInt(_loc_3)] = _loc_5[_loc_3].animator.clone();
                    }
                }
            }
            return;
        }// end function

        public function get type() : AppearanceType
        {
            return this.m_Type;
        }// end function

        public function switchFrameGroup(param1:uint) : void
        {
            return;
        }// end function

        public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : CachedSpriteInformation
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_6:* = this.getSpriteIndex(param1, param2, param3, param4);
            var _loc_7:* = this.m_Type.FrameGroups[this.m_ActiveFrameGroup].cachedSpriteInformations[_loc_6];
            _loc_7 = this.m_Type.FrameGroups[this.m_ActiveFrameGroup].spriteProvider.getSprite(_loc_7.spriteID, _loc_7, this.m_Type);
            if (_loc_7.cacheMiss == false || param5 == false)
            {
                return _loc_7;
            }
            _loc_8 = 0;
            while (_loc_8 < this.m_Type.FrameGroups[this.m_ActiveFrameGroup].phases)
            {
                
                _loc_9 = this.getSpriteIndex(_loc_8, param2, param3, param4);
                _loc_7 = this.m_Type.FrameGroups[this.m_ActiveFrameGroup].cachedSpriteInformations[_loc_9];
                _loc_7 = this.m_Type.FrameGroups[this.m_ActiveFrameGroup].spriteProvider.getSprite(_loc_7.spriteID, _loc_7, this.m_Type);
                if (_loc_7.cacheMiss == false)
                {
                    break;
                }
                _loc_8 = _loc_8 + 1;
            }
            return _loc_7;
        }// end function

        public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
        {
            if (this.phase == this.m_LastInternalPhase && param2 == this.m_LastPatternX && param4 >= 0 && param3 == this.m_LastPatternY && param3 >= 0 && param4 == this.m_LastPatternZ && param2 >= 0)
            {
                return this.m_LastCachedSpriteIndex;
            }
            var _loc_5:* = this.phase;
            var _loc_6:* = param4 >= 0 ? (param4 % this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternDepth) : (0);
            var _loc_7:* = param3 >= 0 ? (param3 % this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternHeight) : (0);
            var _loc_8:* = param2 >= 0 ? (param2 % this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternWidth) : (0);
            var _loc_9:* = ((_loc_5 * this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternDepth + _loc_6) * this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternHeight + _loc_7) * this.m_Type.FrameGroups[this.m_ActiveFrameGroup].patternWidth + _loc_8;
            this.m_LastInternalPhase = this.phase;
            this.m_LastPatternX = param2;
            this.m_LastPatternY = param3;
            this.m_LastPatternZ = param4;
            this.m_LastCachedSpriteIndex = _loc_9;
            return _loc_9;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
        {
            var _loc_7:* = null;
            _loc_7 = this.getSprite(-1, param4, param5, param6, this.m_Type.FrameGroups[this.m_ActiveFrameGroup].isAnimation);
            this.m_CacheDirty = _loc_7.cacheMiss;
            var _loc_8:* = _loc_7.rectangle;
            s_TempPoint.setTo(param2 - _loc_8.width - this.m_Type.displacementX, param3 - _loc_8.height - this.m_Type.displacementY);
            param1.copyPixels(_loc_7.bitmapData, _loc_8, s_TempPoint, null, null, true);
            return;
        }// end function

        public function animate(param1:Number, param2:int = 0) : Boolean
        {
            if (this.m_Animators.hasOwnProperty(this.m_ActiveFrameGroup))
            {
                this.m_Animators[this.m_ActiveFrameGroup].animate(param1, 0);
                return !this.m_Animators[this.m_ActiveFrameGroup].finished;
            }
            return false;
        }// end function

        public function set phase(param1:int) : void
        {
            if (this.m_Animators.hasOwnProperty(this.m_ActiveFrameGroup))
            {
                this.m_Animators[this.m_ActiveFrameGroup].phase = param1;
            }
            return;
        }// end function

        public function get cacheDirty() : Boolean
        {
            return this.m_CacheDirty;
        }// end function

        public function get phase() : int
        {
            if (this.m_Animators.hasOwnProperty(this.m_ActiveFrameGroup))
            {
                return this.m_Animators[this.m_ActiveFrameGroup].phase;
            }
            return 0;
        }// end function

    }
}
