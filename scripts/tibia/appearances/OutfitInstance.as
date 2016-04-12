package tibia.appearances
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import shared.utility.*;
    import tibia.appearances.widgetClasses.*;

    public class OutfitInstance extends AppearanceInstance
    {
        private var m_TempSpriteInformation:CachedSpriteInformation;
        protected var m_ColourLegs:int = 0;
        protected var m_AddOns:int = 0;
        var m_Phase:uint = 0;
        protected var m_ColourTorso:int = 0;
        private var m_InstanceCache:Object;
        protected var m_ColourDetail:int = 0;
        protected var m_ColourHead:int = 0;
        static const RENDERER_DEFAULT_HEIGHT:Number = 480;
        private static const s_GreyBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES, INSTANCE_CACHE_MAX_HEIGHT, true, 0);
        static const NUM_EFFECTS:int = 200;
        static const MAP_HEIGHT:int = 11;
        private static const REPLACE_BLUE_WIDTH_YELLOW:BitmapFilter = new ColorMatrixFilter([1, -1, 0, 0, 0, -1, 1, 0, 0, 0, 1, 1, 0, 0, -255, 0, 0, -1, 1, 0]);
        static const RENDERER_DEFAULT_WIDTH:Number = 480;
        static const ONSCREEN_MESSAGE_WIDTH:int = 295;
        static const FIELD_ENTER_POSSIBLE:uint = 0;
        private static const TIBIA_MASKS_SHADER_CLASS:Class = OutfitInstance_TIBIA_MASKS_SHADER_CLASS;
        private static const INSTANCE_CACHE_MAX_WIDTH:int = 64;
        public static const INVISIBLE_OUTFIT_ID:int = 0;
        static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
        private static const s_TibiaMasksShader:Shader = new Shader(new TIBIA_MASKS_SHADER_CLASS());
        static const UNDERGROUND_LAYER:int = 2;
        static const NUM_FIELDS:int = 2016;
        static const FIELD_HEIGHT:int = 24;
        public static const MAX_NAME_LENGTH:int = 30;
        static const FIELD_CACHESIZE:int = 32;
        private static const s_MaskBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES, INSTANCE_CACHE_MAX_HEIGHT, true, 0);
        private static const s_ColourBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES, INSTANCE_CACHE_MAX_HEIGHT, true, 0);
        static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
        private static const INSTANCE_CACHE_MAX_SPRITES:int = 72;
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
        private static const s_ColourTransform:ColorTransform = new ColorTransform();
        private static const INSTANCE_CACHE_MAX_HEIGHT:int = 64;
        private static const s_DestinationBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES, INSTANCE_CACHE_MAX_HEIGHT, true, 0);
        static const GROUND_LAYER:int = 7;

        public function OutfitInstance(param1:int, param2:AppearanceType, param3:int, param4:int, param5:int, param6:int, param7:int)
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            this.m_InstanceCache = {};
            this.m_TempSpriteInformation = new CachedSpriteInformation();
            super(param1, param2);
            for (_loc_8 in m_Type.FrameGroups)
            {
                
                _loc_9 = new SpriteCacheContainer();
                _loc_9.m_InstanceSpriteIDs = _loc_11[_loc_8].spriteIDs;
                _loc_9.m_SpriteProvider = _loc_11[_loc_8].spriteProvider;
                this.m_InstanceCache[_loc_8] = _loc_9;
            }
            this.updateProperties(param3, param4, param5, param6, param7);
            return;
        }// end function

        private function createInstanceBitmap(param1:uint) : void
        {
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            if (m_Type.FrameGroups[param1].layers != 2 || this.m_InstanceCache[param1].m_UncomittedCreateInstanceBitmap == false)
            {
                return;
            }
            this.m_InstanceCache[param1].m_UncomittedCreateInstanceBitmap = false;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = this.m_InstanceCache[param1].m_InstanceBitmap;
            if (this.m_InstanceCache[param1].m_InstanceBitmap == null)
            {
                _loc_10 = m_Type.FrameGroups[param1].width * FIELD_SIZE;
                _loc_11 = m_Type.FrameGroups[param1].height * FIELD_SIZE;
                _loc_9 = new BitmapData(_loc_10 * m_Type.FrameGroups[param1].phases * m_Type.FrameGroups[param1].patternDepth * m_Type.FrameGroups[param1].patternWidth, _loc_11, true, 0);
                _loc_9.lock();
                _loc_12 = new Vector.<Rectangle>(m_Type.FrameGroups[param1].numSprites, true);
                _loc_2 = 0;
                _loc_4 = m_Type.FrameGroups[param1].phases - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_8 = m_Type.FrameGroups[param1].patternDepth - 1;
                    while (_loc_8 >= 0)
                    {
                        
                        _loc_6 = m_Type.FrameGroups[param1].patternWidth - 1;
                        while (_loc_6 >= 0)
                        {
                            
                            _loc_3 = (((_loc_4 * m_Type.FrameGroups[param1].patternDepth + _loc_8) * m_Type.FrameGroups[param1].patternHeight + 0) * m_Type.FrameGroups[param1].patternWidth + _loc_6) * m_Type.FrameGroups[param1].layers + 0;
                            _loc_12[_loc_3] = new Rectangle(_loc_2 * _loc_10, 0, _loc_10, _loc_11);
                            _loc_2++;
                            _loc_6 = _loc_6 - 1;
                        }
                        _loc_8 = _loc_8 - 1;
                    }
                    _loc_4 = _loc_4 - 1;
                }
                this.m_InstanceCache[param1].m_InstanceSprite = _loc_12;
                this.m_InstanceCache[param1].m_InstanceBitmap = _loc_9;
            }
            return;
        }// end function

        override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : CachedSpriteInformation
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (m_Type.FrameGroups[m_ActiveFrameGroup].layers != 2)
            {
                return super.getSprite(param1, param2, param3, param4, param5);
            }
            for (_loc_6 in this.m_InstanceCache)
            {
                
                _loc_8 = parseInt(_loc_6);
                if (_loc_10[_loc_8].m_CacheDirty || _loc_10[_loc_8].m_UncomittedRebuildCache)
                {
                    this.rebuildCache(_loc_8);
                }
            }
            _loc_7 = this.getSpriteIndex(param1, param2, param3, param4);
            this.m_TempSpriteInformation.setCachedSpriteInformationTo(m_Type.FrameGroups[m_ActiveFrameGroup].spriteIDs[_loc_7], _loc_10[m_ActiveFrameGroup].m_InstanceBitmap, _loc_10[m_ActiveFrameGroup].m_InstanceSprite[_loc_7], _loc_10[_loc_8].m_CacheDirty);
            return this.m_TempSpriteInformation;
        }// end function

        private function colouriseChannel(param1:BitmapData, param2:BitmapData, param3:uint, param4:Colour) : void
        {
            s_ColourBitmap.copyPixels(param1, param1.rect, s_ColourBitmap.rect.topLeft);
            s_ColourBitmap.copyChannel(param2, param2.rect, s_ColourBitmap.rect.topLeft, param3, BitmapDataChannel.ALPHA);
            s_ColourTransform.redMultiplier = param4.redFloat;
            s_ColourTransform.greenMultiplier = param4.greenFloat;
            s_ColourTransform.blueMultiplier = param4.blueFloat;
            s_ColourBitmap.colorTransform(s_ColourBitmap.rect, s_ColourTransform);
            param1.copyPixels(s_ColourBitmap, s_ColourBitmap.rect, param1.rect.topLeft, null, null, true);
            return;
        }// end function

        private function colouriseOutfitWithInternalMethod(param1:BitmapData, param2:BitmapData, param3:BitmapData) : void
        {
            var _loc_4:* = Colour.s_FromHSI(this.m_ColourHead);
            var _loc_5:* = Colour.s_FromHSI(this.m_ColourTorso);
            var _loc_6:* = Colour.s_FromHSI(this.m_ColourLegs);
            var _loc_7:* = Colour.s_FromHSI(this.m_ColourDetail);
            this.colouriseChannel(param1, param2, BitmapDataChannel.BLUE, _loc_7);
            s_MaskBitmap.applyFilter(param2, param2.rect, param2.rect.topLeft, REPLACE_BLUE_WIDTH_YELLOW);
            this.colouriseChannel(param1, param2, BitmapDataChannel.BLUE, _loc_4);
            this.colouriseChannel(param1, param2, BitmapDataChannel.RED, _loc_5);
            this.colouriseChannel(param1, param2, BitmapDataChannel.GREEN, _loc_6);
            param3.copyPixels(s_GreyBitmap, s_GreyBitmap.rect, new Point(0, 0));
            return;
        }// end function

        override public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
        {
            var _loc_5:* = (param1 >= 0 ? (param1) : (this.m_Phase)) % m_Type.FrameGroups[m_ActiveFrameGroup].phases;
            var _loc_6:* = param2 >= 0 ? (param2 % m_Type.FrameGroups[m_ActiveFrameGroup].patternWidth) : (0);
            var _loc_7:* = param3 >= 0 ? (param3 % m_Type.FrameGroups[m_ActiveFrameGroup].patternHeight) : (0);
            var _loc_8:* = param4 >= 0 ? (param4 % m_Type.FrameGroups[m_ActiveFrameGroup].patternDepth) : (0);
            var _loc_9:* = (((_loc_5 * m_Type.FrameGroups[m_ActiveFrameGroup].patternDepth + _loc_8) * m_Type.FrameGroups[m_ActiveFrameGroup].patternHeight + _loc_7) * m_Type.FrameGroups[m_ActiveFrameGroup].patternWidth + _loc_6) * m_Type.FrameGroups[m_ActiveFrameGroup].layers + 0;
            return (((_loc_5 * m_Type.FrameGroups[m_ActiveFrameGroup].patternDepth + _loc_8) * m_Type.FrameGroups[m_ActiveFrameGroup].patternHeight + _loc_7) * m_Type.FrameGroups[m_ActiveFrameGroup].patternWidth + _loc_6) * m_Type.FrameGroups[m_ActiveFrameGroup].layers + 0;
        }// end function

        public function updateProperties(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = null;
            if (this.m_ColourHead != param1 || this.m_ColourTorso != param2 || this.m_ColourLegs != param3 || this.m_ColourDetail != param4 || this.m_AddOns != param5)
            {
                this.m_ColourHead = param1;
                this.m_ColourTorso = param2;
                this.m_ColourLegs = param3;
                this.m_ColourDetail = param4;
                this.m_AddOns = param5;
                for each (_loc_6 in this.m_InstanceCache)
                {
                    
                    _loc_6.m_UncomittedRebuildCache = true;
                }
            }
            return;
        }// end function

        override public function animate(param1:Number, param2:int = 0) : Boolean
        {
            if (m_Animators.hasOwnProperty(m_ActiveFrameGroup))
            {
                m_Animators[m_ActiveFrameGroup].animate(param1, param2);
                this.m_Phase = m_Animators[m_ActiveFrameGroup].phase;
                return !m_Animators[m_ActiveFrameGroup].finished;
            }
            return false;
        }// end function

        override public function switchFrameGroup(param1:uint) : void
        {
            if (param1 != m_ActiveFrameGroup)
            {
                m_ActiveFrameGroup = param1;
                if (m_Animators.hasOwnProperty(m_ActiveFrameGroup) && (m_Animators[m_ActiveFrameGroup].lastAnimationTick + AppearanceAnimator.ANIMATION_DELAY_BEFORE_RESET < Tibia.s_FrameTibiaTimestamp || param1 != FrameGroup.FRAME_GROUP_WALKING))
                {
                    m_Animators[m_ActiveFrameGroup].reset();
                }
            }
            return;
        }// end function

        private function rebuildCache(param1:uint) : void
        {
            var _TempSpriteInformation:CachedSpriteInformation;
            var a_FrameGroupID:* = param1;
            if (m_Type.FrameGroups[a_FrameGroupID].layers != 2 || this.m_InstanceCache[a_FrameGroupID].m_CacheDirty == false && this.m_InstanceCache[a_FrameGroupID].m_UncomittedRebuildCache == false)
            {
                return;
            }
            var i:int;
            var c:int;
            var p:int;
            var s:int;
            var x:int;
            var y:int;
            var z:int;
            var CacheDirty:Boolean;
            if (this.m_InstanceCache[a_FrameGroupID].m_UncomittedCreateInstanceBitmap)
            {
                this.createInstanceBitmap(a_FrameGroupID);
            }
            this.m_InstanceCache[a_FrameGroupID].m_UncomittedRebuildCache = false;
            var ZeroPoint:* = new Point(0, 0);
            var m_NumberOfAddOns:int;
            try
            {
                y;
                while (y < m_Type.FrameGroups[a_FrameGroupID].patternHeight)
                {
                    
                    if (y > 0 && (this.m_AddOns & 1 << (y - 1)) == 0)
                    {
                    }
                    else
                    {
                        m_NumberOfAddOns = (m_NumberOfAddOns + 1);
                        p = (m_Type.FrameGroups[a_FrameGroupID].phases - 1);
                        while (p >= 0)
                        {
                            
                            z = (m_Type.FrameGroups[a_FrameGroupID].patternDepth - 1);
                            while (z >= 0)
                            {
                                
                                x = (m_Type.FrameGroups[a_FrameGroupID].patternWidth - 1);
                                while (x >= 0)
                                {
                                    
                                    s = (((p * m_Type.FrameGroups[a_FrameGroupID].patternDepth + z) * m_Type.FrameGroups[a_FrameGroupID].patternHeight + y) * m_Type.FrameGroups[a_FrameGroupID].patternWidth + x) * m_Type.FrameGroups[a_FrameGroupID].layers + 0;
                                    c = (((p * m_Type.FrameGroups[a_FrameGroupID].patternDepth + z) * m_Type.FrameGroups[a_FrameGroupID].patternHeight + 0) * m_Type.FrameGroups[a_FrameGroupID].patternWidth + x) * m_Type.FrameGroups[a_FrameGroupID].layers + 0;
                                    _TempSpriteInformation = m_Type.FrameGroups[a_FrameGroupID].cachedSpriteInformations[s];
                                    _TempSpriteInformation = m_Type.FrameGroups[a_FrameGroupID].spriteProvider.getSprite(m_Type.FrameGroups[a_FrameGroupID].spriteIDs[s], _TempSpriteInformation, this.m_Type);
                                    CacheDirty = CacheDirty || _TempSpriteInformation.cacheMiss;
                                    if (CacheDirty)
                                    {
                                        break;
                                        
                                        
                                        return;
                                    }
                                    s_GreyBitmap.copyPixels(_TempSpriteInformation.bitmapData, _TempSpriteInformation.rectangle, this.m_InstanceCache[a_FrameGroupID].m_InstanceSprite[c].topLeft);
                                    s = (s + 1);
                                    _TempSpriteInformation = m_Type.FrameGroups[a_FrameGroupID].cachedSpriteInformations[s];
                                    _TempSpriteInformation = m_Type.FrameGroups[a_FrameGroupID].spriteProvider.getSprite(m_Type.FrameGroups[a_FrameGroupID].spriteIDs[s], _TempSpriteInformation, this.m_Type);
                                    CacheDirty = CacheDirty || _TempSpriteInformation.cacheMiss;
                                    if (CacheDirty)
                                    {
                                        break;
                                        
                                        
                                        return;
                                    }
                                    s_MaskBitmap.copyPixels(_TempSpriteInformation.bitmapData, _TempSpriteInformation.rectangle, this.m_InstanceCache[a_FrameGroupID].m_InstanceSprite[c].topLeft);
                                    x = (x - 1);
                                }
                                z = (z - 1);
                            }
                            p = (p - 1);
                        }
                        this.colouriseOutfitWithInternalMethod(s_GreyBitmap, s_MaskBitmap, s_DestinationBitmap);
                        this.m_InstanceCache[a_FrameGroupID].m_InstanceBitmap.copyPixels(s_DestinationBitmap, s_DestinationBitmap.rect, ZeroPoint, null, null, y > 0);
                    }
                    y = (y + 1);
                }
            }
            catch (e:Error)
            {
                throw null;
            }
            finally
            {
                if (CacheDirty == false)
                {
                    this.m_InstanceCache[a_FrameGroupID].m_CacheDirty = false;
                }
                else
                {
                    this.m_InstanceCache[a_FrameGroupID].m_CacheDirty = true;
                }
            }
            return;
        }// end function

        private function colouriseOutfitWithPixelBender(param1:BitmapData, param2:BitmapData, param3:BitmapData) : void
        {
            var _loc_4:* = Colour.s_FromHSI(this.m_ColourHead);
            var _loc_5:* = Colour.s_FromHSI(this.m_ColourTorso);
            var _loc_6:* = Colour.s_FromHSI(this.m_ColourLegs);
            var _loc_7:* = Colour.s_FromHSI(this.m_ColourDetail);
            s_TibiaMasksShader.data.red.value = [_loc_5.redFloat, _loc_5.greenFloat, _loc_5.blueFloat, 1];
            s_TibiaMasksShader.data.green.value = [_loc_6.redFloat, _loc_6.greenFloat, _loc_6.blueFloat, 1];
            s_TibiaMasksShader.data.blue.value = [_loc_7.redFloat, _loc_7.greenFloat, _loc_7.blueFloat, 1];
            s_TibiaMasksShader.data.yellow.value = [_loc_4.redFloat, _loc_4.greenFloat, _loc_4.blueFloat, 1];
            s_TibiaMasksShader.data.greyscale.input = param1;
            s_TibiaMasksShader.data.mask.input = param2;
            var _loc_8:* = new ShaderJob();
            _loc_8.shader = s_TibiaMasksShader;
            _loc_8.target = param3;
            _loc_8.start(true);
            return;
        }// end function

        override public function get phase() : int
        {
            return this.m_Phase;
        }// end function

        override public function set phase(param1:int) : void
        {
            super.phase = param1;
            this.m_Phase = param1;
            return;
        }// end function

        s_GreyBitmap.lock();
        s_MaskBitmap.lock();
        s_DestinationBitmap.lock();
    }
}

import __AS3__.vec.*;

import flash.display.*;

import flash.filters.*;

import flash.geom.*;

import shared.utility.*;

import tibia.appearances.widgetClasses.*;

class SpriteCacheContainer extends Object
{
    public var m_UncomittedRebuildCache:Boolean = true;
    public var m_CacheDirty:Boolean = true;
    public var m_SpriteProvider:ISpriteProvider = null;
    public var m_InstanceSprite:Vector.<Rectangle> = null;
    public var m_UncomittedCreateInstanceBitmap:Boolean = true;
    public var m_InstanceBitmap:BitmapData = null;
    public var m_InstanceSpriteIDs:Vector.<uint> = null;

    function SpriteCacheContainer()
    {
        return;
    }// end function

}

