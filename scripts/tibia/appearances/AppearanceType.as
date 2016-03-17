package tibia.appearances
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class AppearanceType
   {
       
      public var isMarket:Boolean = false;
      
      public var isHookEast:Boolean = false;
      
      public var isUnmoveable:Boolean = false;
      
      public var isCloth:Boolean = false;
      
      public var patternDepth:int = 0;
      
      public var patternWidth:int = 0;
      
      public var isUnsight:Boolean = false;
      
      public var ID:int = 0;
      
      public var isHangable:Boolean = false;
      
      public var displacementX:int = 0;
      
      public var displacementY:int = 0;
      
      public var height:int = 0;
      
      public var isLiquidContainer:Boolean = false;
      
      public var isLight:Boolean = false;
      
      public var bitmap:BitmapData = null;
      
      public var phaseDuration:Vector.<int>;
      
      public var clothSlot:int = 0;
      
      public var isDisplaced:Boolean = false;
      
      public var marketRestrictProfession:uint = 0;
      
      public var isAnimateAlways:Boolean = false;
      
      public var layers:int = 0;
      
      public var isLyingObject:Boolean = false;
      
      public var marketRestrictLevel:uint = 0;
      
      public var brightness:int = 0;
      
      public var isUnpassable:Boolean = false;
      
      public var phases:int = 0;
      
      public var isLiquidPool:Boolean = false;
      
      public var isIgnoreLook:Boolean = false;
      
      public var elevation:int = 0;
      
      public var lensHelp:int = 0;
      
      public var isHookSouth:Boolean = false;
      
      public var marketCategory:int = 0;
      
      public var isCachable:Boolean = false;
      
      public var isAvoid:Boolean = false;
      
      public var marketShowAs:int = 0;
      
      public var isContainer:Boolean = false;
      
      public var automapColour:int = 0;
      
      public var isAnimation:Boolean = false;
      
      public var lightColour:int = 0;
      
      public var isBank:Boolean = false;
      
      public var waypoints:int = 0;
      
      public var isClip:Boolean = false;
      
      public var isDonthide:Boolean = false;
      
      public var exactSize:int = 0;
      
      public var isLensHelp:Boolean = false;
      
      public var marketNameLowerCase:String = null;
      
      public var isTakeable:Boolean = false;
      
      public var isWriteable:Boolean = false;
      
      public var isFullBank:Boolean = false;
      
      public var isCumulative:Boolean = false;
      
      public var isAutomap:Boolean = false;
      
      public var sprite:Vector.<Rectangle>;
      
      public var width:int = 0;
      
      public var isTop:Boolean = false;
      
      public var isTranslucent:Boolean = false;
      
      public var isWriteableOnce:Boolean = false;
      
      public var isMultiUse:Boolean = false;
      
      public var marketTradeAs:int = 0;
      
      public var patternHeight:int = 0;
      
      public var isForceUse:Boolean = false;
      
      public var marketName:String = null;
      
      public var numSprites:int = 0;
      
      public var isHeight:Boolean = false;
      
      public var isBottom:Boolean = false;
      
      public var maxTextLength:int = 0;
      
      public var totalDuration:int = 0;
      
      public var isRotateable:Boolean = false;
      
      public function AppearanceType(param1:int)
      {
         this.phaseDuration = new Vector.<int>();
         this.sprite = new Vector.<Rectangle>();
         super();
         this.ID = param1;
      }
   }
}
