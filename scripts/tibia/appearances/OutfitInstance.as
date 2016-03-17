package tibia.appearances
{
   import flash.filters.BitmapFilter;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.geom.ColorTransform;
   import flash.filters.ColorMatrixFilter;
   import tibia.§appearances:ns_appearance_internal§.m_Type;
   import shared.utility.Colour;
   import flash.display.BitmapDataChannel;
   import flash.geom.Point;
   import tibia.§appearances:ns_appearance_internal§.m_Phase;
   
   public class OutfitInstance extends AppearanceInstance
   {
      
      protected static const RENDERER_DEFAULT_HEIGHT:Number = MAP_WIDTH * FIELD_SIZE;
      
      private static const REPLACE_BLUE_WIDTH_YELLOW:BitmapFilter = new ColorMatrixFilter([1,-1,0,0,0,-1,1,0,0,0,1,1,0,0,-255,0,0,-1,1,0]);
      
      protected static const NUM_EFFECTS:int = 200;
      
      protected static const MAP_HEIGHT:int = 11;
      
      protected static const RENDERER_DEFAULT_WIDTH:Number = MAP_WIDTH * FIELD_SIZE;
      
      protected static const ONSCREEN_MESSAGE_WIDTH:int = 295;
      
      public static const MAX_NAME_LENGTH:int = 30;
      
      private static const INSTANCE_CACHE_MAX_WIDTH:int = 2 * FIELD_SIZE;
      
      public static const INVISIBLE_OUTFIT_ID:int = 0;
      
      private static const s_MaskBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      private static const s_ColourBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      protected static const UNDERGROUND_LAYER:int = 2;
      
      protected static const NUM_FIELDS:int = MAPSIZE_Z * MAPSIZE_Y * MAPSIZE_X;
      
      protected static const FIELD_HEIGHT:int = 24;
      
      private static const s_ColourRect:Rectangle = new Rectangle(0,0,s_ColourBitmap.width,s_ColourBitmap.height);
      
      protected static const FIELD_CACHESIZE:int = FIELD_SIZE;
      
      private static const s_ColourTransform:ColorTransform = new ColorTransform();
      
      protected static const ONSCREEN_MESSAGE_HEIGHT:int = 195;
      
      private static const INSTANCE_CACHE_MAX_SPRITES:int = 2 * 3 * 4;
      
      protected static const MAP_MIN_X:int = 24576;
      
      protected static const MAP_MIN_Y:int = 24576;
      
      protected static const MAP_MIN_Z:int = 0;
      
      protected static const PLAYER_OFFSET_Y:int = 6;
      
      protected static const FIELD_SIZE:int = 32;
      
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
      
      private static const s_GreyRect:Rectangle = new Rectangle(0,0,s_GreyBitmap.width,s_GreyBitmap.height);
      
      private static const s_GreyBitmap:BitmapData = new BitmapData(INSTANCE_CACHE_MAX_WIDTH * INSTANCE_CACHE_MAX_SPRITES,INSTANCE_CACHE_MAX_HEIGHT,true,0);
      
      protected static const MAP_WIDTH:int = 15;
      
      protected static const NUM_ONSCREEN_MESSAGES:int = 16;
      
      private static const INSTANCE_CACHE_MAX_HEIGHT:int = 2 * FIELD_SIZE;
      
      private static const s_MaskRect:Rectangle = new Rectangle(0,0,s_MaskBitmap.width,s_MaskBitmap.height);
      
      protected static const GROUND_LAYER:int = 7;
       
      protected var m_ColourLegs:int = 0;
      
      protected var m_AddOns:int = 0;
      
      protected var m_ColourHead:int = 0;
      
      protected var m_ColourDetail:int = 0;
      
      private var m_InstanceSprite:Vector.<Rectangle> = null;
      
      protected var m_ColourTorso:int = 0;
      
      private var m_InstanceBitmap:BitmapData = null;
      
      public function OutfitInstance(param1:int, param2:AppearanceType, param3:int, param4:int, param5:int, param6:int, param7:int)
      {
         super(param1,param2);
         this.m_InstanceBitmap = m_Type.bitmap;
         this.m_InstanceSprite = m_Type.sprite;
         this.m_ColourHead = param3;
         this.m_ColourTorso = param4;
         this.m_ColourLegs = param5;
         this.m_ColourDetail = param6;
         this.m_AddOns = param7;
         this.rebuildCache();
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
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         if(m_Type.layers != 2)
         {
            return;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.m_InstanceBitmap == m_Type.bitmap)
         {
            _loc12_ = m_Type.width * FIELD_SIZE;
            _loc13_ = m_Type.height * FIELD_SIZE;
            this.m_InstanceBitmap = new BitmapData(_loc12_ * m_Type.phases * m_Type.patternDepth * m_Type.patternWidth,_loc13_,true,0);
            this.m_InstanceSprite = new Vector.<Rectangle>(m_Type.numSprites,true);
            _loc1_ = m_Type.numSprites - 1;
            while(_loc1_ >= 0)
            {
               this.m_InstanceSprite[_loc1_] = m_Type.sprite[_loc1_];
               _loc1_--;
            }
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
                     this.m_InstanceSprite[_loc2_] = new Rectangle(_loc1_ * _loc12_,0,_loc12_,_loc13_);
                     _loc1_++;
                     _loc5_--;
                  }
                  _loc7_--;
               }
               _loc3_--;
            }
         }
         var _loc8_:uint = Colour.s_ARGBFromHSI(this.m_ColourHead);
         var _loc9_:uint = Colour.s_ARGBFromHSI(this.m_ColourTorso);
         var _loc10_:uint = Colour.s_ARGBFromHSI(this.m_ColourLegs);
         var _loc11_:uint = Colour.s_ARGBFromHSI(this.m_ColourDetail);
         _loc6_ = 0;
         while(_loc6_ < m_Type.patternHeight)
         {
            if(!(_loc6_ > 0 && (this.m_AddOns & 1 << _loc6_ - 1) == 0))
            {
               _loc3_ = m_Type.phases - 1;
               while(_loc3_ >= 0)
               {
                  _loc7_ = m_Type.patternDepth - 1;
                  while(_loc7_ >= 0)
                  {
                     _loc5_ = m_Type.patternWidth - 1;
                     while(_loc5_ >= 0)
                     {
                        _loc4_ = (((_loc3_ * m_Type.patternDepth + _loc7_) * m_Type.patternHeight + _loc6_) * m_Type.patternWidth + _loc5_) * m_Type.layers + 0;
                        _loc2_ = (((_loc3_ * m_Type.patternDepth + _loc7_) * m_Type.patternHeight + 0) * m_Type.patternWidth + _loc5_) * m_Type.layers + 0;
                        s_GreyBitmap.copyPixels(m_Type.bitmap,m_Type.sprite[_loc4_],this.m_InstanceSprite[_loc2_].topLeft);
                        _loc4_++;
                        s_MaskBitmap.copyPixels(m_Type.bitmap,m_Type.sprite[_loc4_],this.m_InstanceSprite[_loc2_].topLeft);
                        _loc5_--;
                     }
                     _loc7_--;
                  }
                  _loc3_--;
               }
               this.colouriseChannel(s_GreyBitmap,s_GreyRect,s_MaskBitmap,s_MaskRect,BitmapDataChannel.BLUE,_loc11_);
               s_MaskBitmap.applyFilter(s_MaskBitmap,s_MaskRect,s_MaskRect.topLeft,REPLACE_BLUE_WIDTH_YELLOW);
               this.colouriseChannel(s_GreyBitmap,s_GreyRect,s_MaskBitmap,s_MaskRect,BitmapDataChannel.BLUE,_loc8_);
               this.colouriseChannel(s_GreyBitmap,s_GreyRect,s_MaskBitmap,s_MaskRect,BitmapDataChannel.RED,_loc9_);
               this.colouriseChannel(s_GreyBitmap,s_GreyRect,s_MaskBitmap,s_MaskRect,BitmapDataChannel.GREEN,_loc10_);
               this.m_InstanceBitmap.copyPixels(s_GreyBitmap,s_GreyRect,new Point(0,0),null,null,_loc6_ > 0);
            }
            _loc6_++;
         }
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
            this.rebuildCache();
         }
      }
      
      private function colouriseChannel(param1:BitmapData, param2:Rectangle, param3:BitmapData, param4:Rectangle, param5:uint, param6:uint) : void
      {
         s_ColourBitmap.copyPixels(param1,param2,s_ColourRect.topLeft);
         s_ColourBitmap.copyChannel(param3,param4,s_ColourRect.topLeft,param5,BitmapDataChannel.ALPHA);
         s_ColourTransform.redMultiplier = (param6 >> 16 & 255) / 255;
         s_ColourTransform.greenMultiplier = (param6 >> 8 & 255) / 255;
         s_ColourTransform.blueMultiplier = (param6 & 255) / 255;
         s_ColourBitmap.colorTransform(s_ColourRect,s_ColourTransform);
         param1.copyPixels(s_ColourBitmap,s_ColourRect,param2.topLeft,null,null,true);
      }
      
      override public function getSprite(param1:int, param2:int, param3:int, param4:int, param5:Rectangle = null) : BitmapData
      {
         var _loc6_:int = param1 >= 0?int(param1 % m_Type.phases):int(m_Phase);
         var _loc7_:int = param2 >= 0?int(param2 % m_Type.patternWidth):0;
         var _loc8_:int = param3 >= 0?int(param3 % m_Type.patternHeight):0;
         var _loc9_:int = param4 >= 0?int(param4 % m_Type.patternDepth):0;
         var _loc10_:int = (((_loc6_ * m_Type.patternDepth + _loc9_) * m_Type.patternHeight + _loc8_) * m_Type.patternWidth + _loc7_) * m_Type.layers + 0;
         if(param5 != null)
         {
            param5.copyFrom(this.m_InstanceSprite[_loc10_]);
         }
         return this.m_InstanceBitmap;
      }
      
      override public function drawTo(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:int = 0;
         _loc7_ = (((m_Phase % m_Type.phases * m_Type.patternDepth + param6 % m_Type.patternDepth) * m_Type.patternHeight + param5 % m_Type.patternHeight) * m_Type.patternWidth + param4 % m_Type.patternWidth) * m_Type.layers + 0;
         var _loc8_:Rectangle = this.m_InstanceSprite[_loc7_];
         s_TempPoint.setTo(param2 - _loc8_.width - m_Type.displacementX,param3 - _loc8_.height - m_Type.displacementY);
         param1.copyPixels(this.m_InstanceBitmap,_loc8_,s_TempPoint,null,null,true);
      }
   }
}
