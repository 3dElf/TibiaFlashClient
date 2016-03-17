package tibia.appearances
{
   import flash.display.BitmapData;
   import flash.display.Shader;
   import tibia.§appearances:ns_appearance_internal§.m_Type;
   import flash.geom.Rectangle;
   import tibia.appearances.widgetClasses.CachedSpriteInformation;
   import tibia.appearances.widgetClasses.ISpriteProvider;
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   import flash.geom.Point;
   import shared.utility.Colour;
   import flash.display.ShaderJob;
   
   public class OutfitInstance extends AppearanceInstance
   {
      
      protected static const RENDERER_DEFAULT_HEIGHT:Number = MAP_WIDTH * FIELD_SIZE;
      
      private static const s_GreyBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const RENDERER_DEFAULT_WIDTH:Number = MAP_WIDTH * FIELD_SIZE;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      protected static const FIELD_ENTER_POSSIBLE:uint = 0;
      
      private static const TIBIA_MASKS_SHADER_CLASS:Class = OutfitInstance_TIBIA_MASKS_SHADER_CLASS;
      
      private static const INSTANCE_CACHE_MAX_WIDTH:int = 2 * FIELD_SIZE;
      
      public static const INVISIBLE_OUTFIT_ID:int = 0;
      
      protected static const FIELD_ENTER_NOT_POSSIBLE:uint = 2;
      
      private static const s_TibiaMasksShader:Shader = new Shader(new TIBIA_MASKS_SHADER_CLASS());
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      public static const MAX_NAME_LENGTH:int = 30;
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      private static const s_MaskBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      private static const INSTANCE_CACHE_MAX_SPRITES:int = 2 * 9 * 4;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const FIELD_SIZE:int = 32;
      
      protected static const FIELD_ENTER_POSSIBLE_NO_ANIMATION:uint = 1;
      
      protected static const RENDERER_MIN_HEIGHT:Number = Math.round(MAP_HEIGHT * 2 / 3 * FIELD_SIZE);
      
      protected static const PLAYER_OFFSET_X:int = 8;
      
      protected static const MAPSIZE_W:int = 10;
      
      protected static const MAPSIZE_X:int = MAP_WIDTH + 3;
      
      protected static const MAPSIZE_Y:int = MAP_HEIGHT + 3;
      
      protected static const MAPSIZE_Z:int = 8;
      
      protected static const MAP_MAX_X:int = MAP_MIN_X + (1 << 14 - 1);
      
      protected static const MAP_MAX_Y:int = MAP_MIN_Y + (1 << 14 - 1);
      
      protected static const MAP_MAX_Z:int = 15;
      
      protected static const RENDERER_MIN_WIDTH:Number = Math.round(MAP_WIDTH * 2 / 3 * FIELD_SIZE);
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      private static const INSTANCE_CACHE_MAX_HEIGHT:int = 2 * FIELD_SIZE;
      
      private static const s_DestinationBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      protected static const GROUND_LAYER:int = 7;
      
      {
         s_GreyBitmap.lock();
         s_MaskBitmap.lock();
         s_DestinationBitmap.lock();
      }
      
      private var m_TempSpriteInformation:CachedSpriteInformation;
      
      protected var m_ColourLegs:int = 0;
      
      protected var m_AddOns:int = 0;
      
      private var m_SpriteProvider:ISpriteProvider = null;
      
      private var m_InstanceSpriteIDs:Vector.<uint> = null;
      
      private var m_UncomittedCreateInstanceBitmap:Boolean = false;
      
      protected var m_ColourTorso:int = 0;
      
      private var m_InstanceBitmap:BitmapData = null;
      
      protected var m_ColourDetail:int = 0;
      
      private var m_InstanceSprite:Vector.<Rectangle> = null;
      
      private var m_UncomittedRebuildCache:Boolean = false;
      
      protected var m_ColourHead:int = 0;
      
      public function OutfitInstance(param1:int, param2:AppearanceType, param3:int, param4:int, param5:int, param6:int, param7:int)
      {
         this.m_TempSpriteInformation = new CachedSpriteInformation();
         super(param1,param2);
         this.m_InstanceSpriteIDs = m_Type.spriteIDs;
         this.m_SpriteProvider = m_Type.spriteProvider;
         this.m_UncomittedCreateInstanceBitmap = true;
         this.m_UncomittedRebuildCache = true;
         this.updateProperties(param3,param4,param5,param6,param7);
      }
      
      private function createInstanceBitmap() : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(m_Type.layers != 2 || this.m_UncomittedCreateInstanceBitmap == false)
         {
            return;
         }
         this.m_UncomittedCreateInstanceBitmap = false;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.m_InstanceBitmap == null)
         {
            _loc8_ = m_Type.width * FIELD_SIZE;
            _loc9_ = m_Type.height * FIELD_SIZE;
            this.m_InstanceBitmap = new BitmapData(_loc8_ * m_Type.phases * m_Type.patternDepth * m_Type.patternWidth,_loc9_,true,0);
            this.m_InstanceBitmap.lock();
            this.m_InstanceSprite = new Vector.<Rectangle>(m_Type.numSprites,true);
            _loc1_ = 0;
            _loc3_ = m_Type.phases - 1;
            while(_loc3_ >= 0)
            {
               _loc7_ = m_Type.patternDepth - 1;
               while(_loc7_ >= 0)
               {
                  _loc5_ = m_Type.patternWidth - 1;
                  while(_loc5_ >= 0)
                  {
                     _loc2_ = (((_loc3_ * m_Type.patternDepth + _loc7_) * m_Type.patternHeight + 0) * m_Type.patternWidth + _loc5_) * m_Type.layers + 0;
                     this.m_InstanceSprite[_loc2_] = new Rectangle(_loc1_ * _loc8_,0,_loc8_,_loc9_);
                     _loc1_++;
                     _loc5_--;
                  }
                  _loc7_--;
               }
               _loc3_--;
            }
         }
      }
      
      override public function getSpriteIndex(param1:int, param2:int, param3:int, param4:int) : uint
      {
         var _loc5_:int = (param1 >= 0?param1:m_Phase) % m_Type.phases;
         var _loc6_:int = param2 >= 0?int(param2 % m_Type.patternWidth):0;
         var _loc7_:int = param3 >= 0?int(param3 % m_Type.patternHeight):0;
         var _loc8_:int = param4 >= 0?int(param4 % m_Type.patternDepth):0;
         var _loc9_:int = (((_loc5_ * m_Type.patternDepth + _loc8_) * m_Type.patternHeight + _loc7_) * m_Type.patternWidth + _loc6_) * m_Type.layers + 0;
         return _loc9_;
      }
      
      public function updateProperties(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(this.m_ColourHead != param1 || this.m_ColourTorso != param2 || this.m_ColourLegs != param3 || this.m_ColourDetail != param4 || this.m_AddOns != param5)
         {
            this.m_ColourHead = param1;
            this.m_ColourTorso = param2;
            this.m_ColourLegs = param3;
            this.m_ColourDetail = param4;
            this.m_AddOns = param5;
            this.m_UncomittedRebuildCache = true;
         }
      }
      
      override public function animate(param1:Number) : Boolean
      {
         if(m_Type.isAnimateAlways)
         {
            super.animate(param1);
         }
         return true;
      }
      
      private function rebuildCache() : void
      {
         var _TempSpriteInformation:CachedSpriteInformation = null;
         if(m_Type.layers != 2 || m_CacheDirty == false && this.m_UncomittedRebuildCache == false)
         {
            return;
         }
         var i:int = 0;
         var c:int = 0;
         var p:int = 0;
         var s:int = 0;
         var x:int = 0;
         var y:int = 0;
         var z:int = 0;
         var CacheDirty:Boolean = false;
         if(this.m_UncomittedCreateInstanceBitmap)
         {
            this.createInstanceBitmap();
         }
         this.m_UncomittedRebuildCache = false;
         var ZeroPoint:Point = new Point(0,0);
         var m_NumberOfAddOns:int = -1;
         try
         {
            y = 0;
            while(true)
            {
               if(y < m_Type.patternHeight)
               {
                  if(!(y > 0 && (this.m_AddOns & 1 << y - 1) == 0))
                  {
                     m_NumberOfAddOns++;
                     p = m_Type.phases - 1;
                     while(p >= 0)
                     {
                        z = m_Type.patternDepth - 1;
                        while(z >= 0)
                        {
                           x = m_Type.patternWidth - 1;
                           while(x >= 0)
                           {
                              s = (((p * m_Type.patternDepth + z) * m_Type.patternHeight + y) * m_Type.patternWidth + x) * m_Type.layers + 0;
                              c = (((p * m_Type.patternDepth + z) * m_Type.patternHeight + 0) * m_Type.patternWidth + x) * m_Type.layers + 0;
                              _TempSpriteInformation = m_Type.cachedSpriteInformations[s];
                              _TempSpriteInformation = m_Type.spriteProvider.getSprite(m_Type.spriteIDs[s],_TempSpriteInformation,this.m_Type);
                              CacheDirty = Boolean(CacheDirty) || Boolean(_TempSpriteInformation.cacheMiss);
                              if(CacheDirty)
                              {
                                 addr224:
                                 return;
                              }
                              s_GreyBitmap.copyPixels(_TempSpriteInformation.bitmapData,_TempSpriteInformation.rectangle,this.m_InstanceSprite[c].topLeft);
                              s++;
                              _TempSpriteInformation = m_Type.cachedSpriteInformations[s];
                              _TempSpriteInformation = m_Type.spriteProvider.getSprite(m_Type.spriteIDs[s],_TempSpriteInformation,this.m_Type);
                              CacheDirty = Boolean(CacheDirty) || Boolean(_TempSpriteInformation.cacheMiss);
                              if(CacheDirty)
                              {
                                 return;
                              }
                              s_MaskBitmap.copyPixels(_TempSpriteInformation.bitmapData,_TempSpriteInformation.rectangle,this.m_InstanceSprite[c].topLeft);
                              x--;
                           }
                           z--;
                        }
                        p--;
                     }
                     this.colouriseOutfitWithPixelBender(s_GreyBitmap,s_MaskBitmap,s_DestinationBitmap);
                     this.m_InstanceBitmap.copyPixels(s_DestinationBitmap,s_DestinationBitmap.rect,ZeroPoint,null,null,y > 0);
                  }
                  y++;
                  continue;
               }
            }
            §§goto(addr224);
            return;
         }
         finally
         {
            while(true)
            {
               if(CacheDirty == false)
               {
                  m_CacheDirty = false;
               }
               else
               {
                  m_CacheDirty = true;
               }
            }
         }
      }
      
      private function colouriseOutfitWithPixelBender(param1:BitmapData, param2:BitmapData, param3:BitmapData) : void
      {
         var _loc4_:Colour = Colour.s_FromHSI(this.m_ColourHead);
         var _loc5_:Colour = Colour.s_FromHSI(this.m_ColourTorso);
         var _loc6_:Colour = Colour.s_FromHSI(this.m_ColourLegs);
         var _loc7_:Colour = Colour.s_FromHSI(this.m_ColourDetail);
         s_TibiaMasksShader.data.red.value = [_loc5_.redFloat,_loc5_.greenFloat,_loc5_.blueFloat,1];
         s_TibiaMasksShader.data.green.value = [_loc6_.redFloat,_loc6_.greenFloat,_loc6_.blueFloat,1];
         s_TibiaMasksShader.data.blue.value = [_loc7_.redFloat,_loc7_.greenFloat,_loc7_.blueFloat,1];
         s_TibiaMasksShader.data.yellow.value = [_loc4_.redFloat,_loc4_.greenFloat,_loc4_.blueFloat,1];
         s_TibiaMasksShader.data.greyscale.input = param1;
         s_TibiaMasksShader.data.mask.input = param2;
         var _loc8_:ShaderJob = new ShaderJob();
         _loc8_.shader = s_TibiaMasksShader;
         _loc8_.target = param3;
         _loc8_.start(true);
      }
      
      override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false) : CachedSpriteInformation
      {
         var _loc6_:int = 0;
         if(m_Type.layers != 2)
         {
            return super.getSprite(param1,param2,param3,param4,param5);
         }
         if(Boolean(m_CacheDirty) || Boolean(this.m_UncomittedRebuildCache))
         {
            this.rebuildCache();
         }
         _loc6_ = this.getSpriteIndex(param1,param2,param3,param4);
         this.m_TempSpriteInformation.setCachedSpriteInformationTo(m_Type.spriteIDs[_loc6_],this.m_InstanceBitmap,this.m_InstanceSprite[_loc6_],m_CacheDirty);
         return this.m_TempSpriteInformation;
      }
   }
}
