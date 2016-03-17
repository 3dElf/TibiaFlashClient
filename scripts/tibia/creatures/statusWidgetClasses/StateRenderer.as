package tibia.creatures.statusWidgetClasses
{
   import mx.core.UIComponent;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   import mx.core.EdgeMetrics;
   import mx.core.IFlexDisplayObject;
   
   public class StateRenderer extends UIComponent
   {
      
      protected static const PROFESSION_MASK_DRUID:int = 1 << PROFESSION_DRUID;
      
      protected static const STATE_PZ_BLOCK:int = 13;
      
      protected static const PROFESSION_SORCERER:int = 3;
      
      protected static const PK_REVENGE:int = 6;
      
      protected static const STATE_SLOW:int = 5;
      
      protected static const PARTY_NONE:int = 0;
      
      protected static const PARTY_MEMBER_SEXP_ACTIVE:int = 5;
      
      protected static const PROFESSION_MASK_SORCERER:int = 1 << PROFESSION_SORCERER;
      
      protected static const SKILL_FIGHTCLUB:int = 9;
      
      private static const STATE_FLAGS:Array = [{
         "state":STATE_POISONED,
         "styleProp":"poisonedImage",
         "toolTip":"TIP_STATE_POISONED"
      },{
         "state":STATE_BURNING,
         "styleProp":"burningImage",
         "toolTip":"TIP_STATE_BURNING"
      },{
         "state":STATE_ELECTRIFIED,
         "styleProp":"electrifiedImage",
         "toolTip":"TIP_STATE_ELECTRIFIED"
      },{
         "state":STATE_DRUNK,
         "styleProp":"drunkImage",
         "toolTip":"TIP_STATE_DRUNK"
      },{
         "state":STATE_MANA_SHIELD,
         "styleProp":"manaShieldImage",
         "toolTip":"TIP_STATE_MANA_SHIELD"
      },{
         "state":STATE_SLOW,
         "styleProp":"slowImage",
         "toolTip":"TIP_STATE_SLOW"
      },{
         "state":STATE_FAST,
         "styleProp":"fastImage",
         "toolTip":"TIP_STATE_FAST"
      },{
         "state":STATE_FIGHTING,
         "styleProp":"fightingImage",
         "toolTip":"TIP_STATE_FIGHTING"
      },{
         "state":STATE_DROWNING,
         "styleProp":"drowningImage",
         "toolTip":"TIP_STATE_DROWNING"
      },{
         "state":STATE_FREEZING,
         "styleProp":"freezingImage",
         "toolTip":"TIP_STATE_FREEZING"
      },{
         "state":STATE_DAZZLED,
         "styleProp":"dazzledImage",
         "toolTip":"TIP_STATE_DAZZLED"
      },{
         "state":STATE_CURSED,
         "styleProp":"cursedImage",
         "toolTip":"TIP_STATE_CURSED"
      },{
         "state":STATE_STRENGTHENED,
         "styleProp":"strengthenedImage",
         "toolTip":"TIP_STATE_STRENGTHENED"
      },{
         "state":STATE_PZ_BLOCK,
         "styleProp":"pzBlockImage",
         "toolTip":"TIP_STATE_PZ_BLOCK"
      },{
         "state":STATE_PZ_ENTERED,
         "styleProp":"pzEnteredImage",
         "toolTip":"TIP_STATE_PZ_ENTERED"
      },{
         "state":STATE_BLEEDING,
         "styleProp":"bleedingImage",
         "toolTip":"TIP_STATE_BLEEDING"
      },{
         "state":STATE_HUNGRY,
         "styleProp":"hungryImage",
         "toolTip":"TIP_STATE_HUNGRY"
      }];
      
      protected static const PK_PARTYMODE:int = 2;
      
      protected static const WAR_ALLY:int = 1;
      
      protected static const PROFESSION_MASK_NONE:int = 1 << PROFESSION_NONE;
      
      protected static const WAR_ENEMY:int = 2;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_GUILTY:int = 8;
      
      protected static const PARTY_MEMBER:int = 2;
      
      protected static const STATE_DRUNK:int = 3;
      
      protected static const WAR_NEUTRAL:int = 3;
      
      protected static const SKILL_EXPERIENCE:int = 0;
      
      protected static const TYPE_NPC:int = 2;
      
      protected static const PROFESSION_KNIGHT:int = 1;
      
      protected static const SKILL_STAMINA:int = 16;
      
      protected static const STATE_NONE:int = -1;
      
      protected static const PROFESSION_PALADIN:int = 2;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_GUILTY:int = 7;
      
      protected static const SKILL_FIGHTSHIELD:int = 7;
      
      protected static const SKILL_FIGHTAXE:int = 11;
      
      protected static const WAR_NONE:int = 0;
      
      protected static const SKILL_FIGHTDISTANCE:int = 8;
      
      protected static const PK_EXCPLAYERKILLER:int = 5;
      
      protected static const NUM_CREATURES:int = 1300;
      
      protected static const NUM_TRAPPERS:int = 8;
      
      protected static const SKILL_FED:int = 14;
      
      protected static const SKILL_MAGLEVEL:int = 2;
      
      protected static const SKILL_SOULPOINTS:int = 15;
      
      protected static const SKILL_FISHING:int = 13;
      
      protected static const PARTY_LEADER_SEXP_OFF:int = 4;
      
      protected static const PK_PLAYERKILLER:int = 4;
      
      protected static const STATE_FAST:int = 6;
      
      protected static const STATE_BLEEDING:int = 15;
      
      protected static const STATE_DAZZLED:int = 10;
      
      protected static const PROFESSION_MASK_KNIGHT:int = 1 << PROFESSION_KNIGHT;
      
      protected static const TYPE_PLAYER:int = 0;
      
      protected static const SKILL_HITPOINTS:int = 3;
      
      protected static const SKILL_NONE:int = -1;
      
      private static const BUNDLE:String = "StatusWidget";
      
      protected static const STATE_MANA_SHIELD:int = 4;
      
      protected static const SKILL_MANA:int = 4;
      
      protected static const PROFESSION_MASK_PALADIN:int = 1 << PROFESSION_PALADIN;
      
      protected static const MAX_NAME_LENGTH:int = 29;
      
      protected static const STATE_CURSED:int = 11;
      
      protected static const STATE_FREEZING:int = 9;
      
      protected static const PARTY_LEADER:int = 1;
      
      protected static const PARTY_LEADER_SEXP_INACTIVE_INNOCENT:int = 10;
      
      protected static const STATE_PZ_ENTERED:int = 14;
      
      protected static const PROFESSION_NONE:int = 0;
      
      protected static const PK_ATTACKER:int = 1;
      
      protected static const STATE_ELECTRIFIED:int = 2;
      
      protected static const SKILL_FIGHTSWORD:int = 10;
      
      protected static const TYPE_MONSTER:int = 1;
      
      protected static const SKILL_CARRYSTRENGTH:int = 6;
      
      protected static const STATE_POISONED:int = 0;
      
      protected static const STATE_BURNING:int = 1;
      
      protected static const SKILL_FIGHTFIST:int = 12;
      
      protected static const STATE_DROWNING:int = 8;
      
      protected static const PK_AGGRESSOR:int = 3;
      
      protected static const SKILL_LEVEL:int = 1;
      
      protected static const STATE_STRENGTHENED:int = 12;
      
      protected static const STATE_HUNGRY:int = 31;
      
      protected static const PROFESSION_MASK_ANY:int = PROFESSION_MASK_DRUID | PROFESSION_MASK_KNIGHT | PROFESSION_MASK_PALADIN | PROFESSION_MASK_SORCERER;
      
      protected static const PROFESSION_DRUID:int = 4;
      
      protected static const PARTY_MEMBER_SEXP_OFF:int = 3;
      
      protected static const STATE_FIGHTING:int = 7;
      
      protected static const SKILL_GOSTRENGTH:int = 5;
      
      protected static const PARTY_MEMBER_SEXP_INACTIVE_INNOCENT:int = 9;
      
      protected static const PK_NONE:int = 0;
      
      protected static const PARTY_LEADER_SEXP_ACTIVE:int = 6;
      
      {
         s_InitializeStyle();
      }
      
      private var m_UncommittedBitSet:Boolean = true;
      
      protected var m_BitSet:uint = 4.294967295E9;
      
      private var m_UncommittedMaxColumns:Boolean = false;
      
      protected var m_MaxColumns:int = 2.147483647E9;
      
      private var m_UncommittedMaxRows:Boolean = false;
      
      protected var m_MinRows:int = 1;
      
      private var m_ChildColumns:int = 0;
      
      private var m_UncommittedMinColumns:Boolean = false;
      
      private var m_ChildRows:int = 0;
      
      protected var m_MinColumns:int = 1;
      
      protected var m_MaxRows:int = 2.147483647E9;
      
      private var m_InvalidStyle:Boolean = false;
      
      private var m_ChildHeight:Number = NaN;
      
      private var m_UncommittedMinRows:Boolean = false;
      
      private var m_ChildWidth:Number = NaN;
      
      public function StateRenderer()
      {
         super();
      }
      
      private static function s_InitializeStyle() : void
      {
         var Selector:String = "StateRenderer";
         var Decl:CSSStyleDeclaration = StyleManager.getStyleDeclaration(Selector);
         if(Decl == null)
         {
            Decl = new CSSStyleDeclaration(Selector);
         }
         Decl.defaultFactory = function():void
         {
            StateRenderer.horizontalAlign = "center";
            StateRenderer.verticalAlign = "middle";
            StateRenderer.horizontalGap = 1;
            StateRenderer.verticalGap = 1;
         };
         StyleManager.setStyleDeclaration(Selector,Decl,true);
      }
      
      public function get minColumns() : int
      {
         return this.m_MinColumns;
      }
      
      public function set maxRows(param1:int) : void
      {
         param1 = Math.max(1,param1);
         if(this.m_MaxRows != param1)
         {
            this.m_MaxRows = param1;
            this.m_UncommittedMaxRows = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      public function get viewMetricsAndPadding() : EdgeMetrics
      {
         var _loc1_:EdgeMetrics = this.borderMetrics.clone();
         _loc1_.bottom = _loc1_.bottom + getStyle("paddingBottom");
         _loc1_.left = _loc1_.left + getStyle("paddingLeft");
         _loc1_.right = _loc1_.right + getStyle("paddingRight");
         _loc1_.top = _loc1_.top + getStyle("paddingTop");
         return _loc1_;
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         var _loc3_:SkinWrapper = null;
         super.commitProperties();
         if(this.m_InvalidStyle)
         {
            this.commitStyle();
            this.m_InvalidStyle = false;
         }
         if(this.m_UncommittedBitSet)
         {
            _loc1_ = numChildren - 1;
            while(_loc1_ >= 0)
            {
               removeChildAt(_loc1_);
               _loc1_--;
            }
            for each(_loc2_ in STATE_FLAGS)
            {
               if(this.m_BitSet & 1 << _loc2_.state)
               {
                  _loc3_ = new SkinWrapper(_loc2_.skinInstance);
                  _loc3_.toolTip = resourceManager.getString(BUNDLE,_loc2_.toolTip);
                  addChild(_loc3_);
               }
            }
            this.m_UncommittedBitSet = false;
         }
         if(this.m_UncommittedMinColumns)
         {
            this.m_UncommittedMinColumns = false;
         }
         if(this.m_UncommittedMaxColumns)
         {
            this.m_UncommittedMaxColumns = false;
         }
         if(this.m_UncommittedMinRows)
         {
            this.m_UncommittedMinRows = false;
         }
         if(this.m_UncommittedMaxRows)
         {
            this.m_UncommittedMaxRows = false;
         }
      }
      
      public function get minRows() : int
      {
         return this.m_MinRows;
      }
      
      public function get bitSet() : uint
      {
         return this.m_BitSet;
      }
      
      override public function styleChanged(param1:String) : void
      {
         super.styleChanged(param1);
         this.invalidateStyle();
      }
      
      override protected function measure() : void
      {
         super.measure();
         var _loc1_:EdgeMetrics = this.viewMetricsAndPadding;
         var _loc2_:Number = getStyle("horizontalGap");
         var _loc3_:Number = _loc1_.left + _loc1_.right;
         var _loc4_:Number = getStyle("verticalGap");
         var _loc5_:Number = _loc1_.top + _loc1_.bottom;
         this.m_ChildColumns = this.m_MinColumns;
         this.m_ChildRows = this.m_MinRows;
         var _loc6_:int = 0;
         var _loc7_:int = STATE_FLAGS.length - 1;
         while(_loc7_ >= 0)
         {
            if(this.m_BitSet & 1 << STATE_FLAGS[_loc7_].state)
            {
               _loc6_++;
            }
            _loc7_--;
         }
         while(this.m_ChildRows * this.m_ChildColumns < _loc6_)
         {
            if(this.m_ChildRows < this.m_MaxRows)
            {
               this.m_ChildRows++;
               continue;
            }
            if(this.m_ChildColumns < this.m_MaxColumns)
            {
               this.m_ChildColumns++;
               continue;
            }
            break;
         }
         measuredMinWidth = this.m_MinColumns * this.m_ChildWidth + (this.m_MinColumns - 1) * _loc2_ + _loc3_;
         measuredWidth = Math.max(measuredMinWidth,this.m_ChildColumns * this.m_ChildWidth + (this.m_ChildColumns - 1) * _loc2_ + _loc3_);
         measuredMinHeight = this.m_MinRows * this.m_ChildHeight + (this.m_MinRows - 1) * _loc4_ + _loc5_;
         measuredHeight = Math.max(measuredMinHeight,this.m_ChildRows * this.m_ChildHeight + (this.m_ChildRows - 1) * _loc4_ + _loc5_);
      }
      
      public function get maxColumns() : int
      {
         return this.m_MaxColumns;
      }
      
      public function set minColumns(param1:int) : void
      {
         param1 = Math.max(1,param1);
         if(this.m_MinColumns != param1)
         {
            this.m_MinColumns = param1;
            this.m_UncommittedMinColumns = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      protected function commitStyle() : void
      {
         var _loc1_:Object = null;
         var _loc2_:* = undefined;
         this.m_ChildWidth = 0;
         this.m_ChildHeight = 0;
         for each(_loc1_ in STATE_FLAGS)
         {
            _loc2_ = getStyle(_loc1_.styleProp);
            if(_loc1_.styleCache != _loc2_)
            {
               _loc1_.styleCache = _loc2_;
               if(_loc2_ is Class)
               {
                  _loc1_.skinInstance = IFlexDisplayObject(new Class(_loc2_)());
               }
               else
               {
                  _loc1_.skinInstance = null;
               }
            }
            if(_loc1_.skinInstance is IFlexDisplayObject)
            {
               this.m_ChildWidth = Math.max(this.m_ChildWidth,IFlexDisplayObject(_loc1_.skinInstance).measuredWidth);
               this.m_ChildHeight = Math.max(this.m_ChildHeight,IFlexDisplayObject(_loc1_.skinInstance).measuredHeight);
            }
         }
      }
      
      public function set bitSet(param1:uint) : void
      {
         if(this.m_BitSet != param1)
         {
            this.m_BitSet = param1;
            this.m_UncommittedBitSet = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      public function set minRows(param1:int) : void
      {
         param1 = Math.max(1,param1);
         if(this.m_MinRows != param1)
         {
            this.m_MinRows = param1;
            this.m_UncommittedMinRows = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      public function get maxRows() : int
      {
         return this.m_MaxRows;
      }
      
      protected function invalidateStyle() : void
      {
         this.m_InvalidStyle = true;
         invalidateProperties();
      }
      
      public function get borderMetrics() : EdgeMetrics
      {
         return EdgeMetrics.EMPTY;
      }
      
      public function set maxColumns(param1:int) : void
      {
         param1 = Math.max(1,param1);
         if(this.m_MaxColumns != param1)
         {
            this.m_MaxColumns = param1;
            this.m_UncommittedMaxColumns = true;
            invalidateDisplayList();
            invalidateProperties();
            invalidateSize();
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc12_:UIComponent = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         super.updateDisplayList(param1,param2);
         if(this.m_ChildRows == 0 || this.m_ChildColumns == 0)
         {
            return;
         }
         var _loc3_:EdgeMetrics = this.viewMetricsAndPadding;
         var _loc4_:Number = getStyle("horizontalGap");
         var _loc5_:Number = getStyle("verticalGap");
         var _loc6_:Number = this.m_ChildRows * this.m_ChildHeight + (this.m_ChildRows - 1) * _loc5_;
         var _loc7_:Number = param2 - _loc3_.top - _loc3_.bottom;
         var _loc8_:Number = _loc3_.left;
         var _loc9_:Number = _loc3_.top + (_loc7_ - _loc6_) / 2 - this.m_ChildHeight - _loc5_;
         var _loc10_:int = 0;
         var _loc11_:int = numChildren;
         while(_loc10_ < _loc11_)
         {
            if(_loc10_ % this.m_ChildColumns == 0)
            {
               _loc15_ = Math.min(_loc11_ - _loc10_,this.m_ChildColumns);
               _loc16_ = _loc15_ * this.m_ChildWidth + (_loc15_ - 1) * _loc4_;
               _loc17_ = param1 - _loc3_.left - _loc3_.right;
               _loc8_ = _loc3_.left + (_loc17_ - _loc16_) / 2;
               _loc9_ = _loc9_ + (this.m_ChildHeight + _loc5_);
            }
            _loc12_ = UIComponent(getChildAt(_loc10_));
            _loc13_ = _loc12_.getExplicitOrMeasuredHeight();
            _loc14_ = _loc12_.getExplicitOrMeasuredWidth();
            _loc12_.move(_loc8_ + (this.m_ChildWidth - _loc14_) / 2,_loc9_ + (this.m_ChildHeight - _loc13_) / 2);
            _loc12_.setActualSize(_loc14_,_loc13_);
            _loc8_ = _loc8_ + (this.m_ChildWidth + _loc4_);
            _loc10_++;
         }
      }
   }
}

import mx.core.UIComponent;
import mx.core.IFlexDisplayObject;
import flash.geom.Matrix;
import flash.display.DisplayObject;

class SkinWrapper extends UIComponent
{
    
   function SkinWrapper(param1:IFlexDisplayObject)
   {
      super();
      if(param1 != null)
      {
         addChild(DisplayObject(param1));
      }
   }
   
   override protected function measure() : void
   {
      var _loc1_:IFlexDisplayObject = null;
      super.measure();
      if(numChildren > 0)
      {
         _loc1_ = IFlexDisplayObject(getChildAt(0));
         measuredMinWidth = measuredWidth = _loc1_.measuredWidth;
         measuredMinHeight = measuredHeight = _loc1_.measuredHeight;
      }
      else
      {
         measuredMinWidth = measuredWidth = 18;
         measuredMinHeight = measuredHeight = 18;
      }
   }
   
   override protected function updateDisplayList(param1:Number, param2:Number) : void
   {
      var _loc3_:IFlexDisplayObject = null;
      var _loc4_:Matrix = null;
      var _loc5_:Number = NaN;
      var _loc6_:Number = NaN;
      var _loc7_:Number = NaN;
      var _loc8_:Number = NaN;
      super.updateDisplayList(param1,param2);
      if(numChildren > 0)
      {
         _loc3_ = IFlexDisplayObject(getChildAt(0));
         _loc3_.move(0,0);
         _loc3_.setActualSize(_loc3_.measuredWidth,_loc3_.measuredHeight);
         _loc4_ = transform.concatenatedMatrix;
         _loc5_ = _loc4_.a;
         _loc6_ = _loc4_.b;
         if(_loc5_ == _loc4_.d && Math.abs(_loc5_) <= 1 && _loc6_ == -_loc4_.c && Math.abs(_loc6_) <= 1)
         {
            _loc7_ = _loc3_.measuredWidth / 2;
            _loc8_ = _loc3_.measuredHeight / 2;
            _loc3_.transform.matrix = new Matrix(_loc5_,-_loc6_,_loc6_,_loc5_,-_loc7_ * _loc5_ - _loc8_ * _loc6_ + _loc7_,_loc7_ * _loc6_ - _loc8_ * _loc5_ + _loc8_);
         }
      }
      else
      {
         graphics.clear();
         graphics.beginFill(65280,1);
         graphics.drawRect(0,0,param1,param2);
         graphics.endFill();
      }
   }
}
