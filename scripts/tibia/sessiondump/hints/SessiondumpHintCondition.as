package tibia.sessiondump.hints
{
   import tibia.sessiondump.hints.condition.HintConditionBase;
   import tibia.sessiondump.controller.SessiondumpMouseShield;
   import tibia.worldmap.WorldMapStorage;
   import tibia.sessiondump.controller.SessiondumpHintActionsController;
   import shared.utility.Vector3D;
   import tibia.sessiondump.hints.condition.HintConditionAutowalk;
   import tibia.sessiondump.hints.condition.HintConditionMove;
   import tibia.sessiondump.hints.condition.HintConditionTalk;
   import tibia.sessiondump.hints.condition.HintConditionAttack;
   import tibia.sessiondump.hints.condition.HintConditionGreet;
   import tibia.sessiondump.hints.condition.HintConditionUse;
   import tibia.appearances.AppearanceType;
   import tibia.creatures.CreatureStorage;
   import tibia.creatures.Creature;
   import tibia.help.GUIRectangle;
   import tibia.creatures.battlelistWidgetClasses.BattlelistWidgetView;
   import tibia.actionbar.widgetClasses.ActionBarWidget;
   
   public class SessiondumpHintCondition extends SessiondumpHintBase
   {
      
      private static const ACTION_LOOK:int = 6;
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_HEAD:String = "color-head";
      
      private static const ACTION_SMARTCLICK:int = 100;
      
      private static var FIELD_CONDITIONTYPE:String = "conditiontype";
      
      private static const ACTION_TALK:int = 9;
      
      private static var FIELD_OBJECTTYPEID:String = "objecttypeid";
      
      private static var FIELD_OBJECTINDEX:String = "objectindex";
      
      private static const MOUSE_BUTTON_RIGHT:int = 2;
      
      private static var CONDITION_TYPE_DRAG_DROP:String = "DRAG_DROP";
      
      private static const MOUSE_BUTTON_MIDDLE:int = 3;
      
      private static var FIELD_CREATURE_ID:String = "creatureid";
      
      private static const MOUSE_BUTTON_LEFT:int = 1;
      
      public static const TYPE:String = "CONDITION";
      
      private static var FIELD_PLAYER_NAME:String = "player-name";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_LEGS:String = "color-legs";
      
      private static var FIELD_MULTIUSE_OBJECT_ID:String = "multiuseobjectid";
      
      private static var FIELD_PLAYER_OUTFIT_ADDONS:String = "add-ons";
      
      private static var FIELD_MULTIUSE_OBJECT_POSITION:String = "multiuseobjectposition";
      
      private static var FIELD_OBJECTID:String = "objectid";
      
      private static var FIELD_AMOUNT:String = "amount";
      
      private static var FIELD_DESTINATION_COORDINATE:String = "destination";
      
      private static const ACTION_ATTACK:int = 1;
      
      private static var FIELD_TEXT:String = "text";
      
      private static const ACTION_CONTEXT_MENU:int = 5;
      
      private static var FIELD_CHANNEL:String = "channel";
      
      private static var FIELD_TYPE:String = "type";
      
      private static var FIELD_CONDITIONDATA:String = "conditiondata";
      
      private static var FIELD_USE_TYPE_ID:String = "usetypeid";
      
      private static var FIELD_SESSIONDUMP:String = "sessiondump";
      
      private static var FIELD_PLAYER_OUTFIT:String = "player-outfit";
      
      private static var FIELD_OBJECTTYPE:String = "objecttype";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_TORSO:String = "color-torso";
      
      private static var FIELD_TARGET:String = "target";
      
      private static var CONDITION_TYPE_CLICK_CREATURE:String = "CLICK_CREATURE";
      
      private static const ACTION_NONE:int = 0;
      
      private static var FIELD_UIELEMENT:String = "uielement";
      
      private static var FIELD_CHANNEL_ID:String = "channelid";
      
      private static var FIELD_PLAYER_OUTFIT_COLOR_DETAIL:String = "color-detail";
      
      private static const ACTION_OPEN:int = 8;
      
      private static const MOUSE_BUTTON_BOTH:int = 4;
      
      private static const ACTION_AUTOWALK_HIGHLIGHT:int = 4;
      
      private static const ACTION_UNSET:int = -1;
      
      private static var FIELD_PLAYER_OUTFIT_ID:String = "id";
      
      private static var FIELD_SKIP_TO_TIMESTAMP:String = "skiptotimestamp";
      
      private static var FIELD_TUTORIAL_PROGRESS:String = "tutorialprogress";
      
      private static var FIELD_TIMESTAMP:String = "timestamp";
      
      private static const ACTION_ATTACK_OR_TALK:int = 102;
      
      private static const ACTION_USE_OR_OPEN:int = 101;
      
      private static var FIELD_MULTIUSE_TARGET:String = "multiusetarget";
      
      private static const ACTION_USE:int = 7;
      
      private static const ACTION_AUTOWALK:int = 3;
      
      private static var FIELD_CREATURE_NAME:String = "creaturename";
      
      private static var CONDITION_TYPE_CLICK:String = "CLICK";
      
      private static var FIELD_POSITION:String = "position";
      
      private static var FIELD_OBJECTDATA:String = "objectdata";
      
      private static var FIELD_SOURCE_COORDINATE:String = "source";
      
      private static var FIELD_COORDINATE:String = "coordinate";
       
      private var m_Conditiontype:String = null;
      
      private var m_ObjecttypeIndex:uint = 0;
      
      private var m_Condition:HintConditionBase = null;
      
      private var m_Amount:uint = 0;
      
      private var m_ObjecttypeID:uint = 0;
      
      private var m_Coordinate:Vector3D = null;
      
      private var m_DestinationCoordinate:Vector3D = null;
      
      private var m_Running:Boolean = false;
      
      public function SessiondumpHintCondition()
      {
         super();
         m_Type = TYPE;
      }
      
      public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
      {
         var _loc2_:SessiondumpHintCondition = new SessiondumpHintCondition();
         if(FIELD_CONDITIONTYPE in param1)
         {
            _loc2_.m_Condition = HintConditionBase.s_Unmarshall(param1);
         }
         return _loc2_;
      }
      
      override public function cancel() : void
      {
         SessiondumpMouseShield.getInstance().reset();
         this.m_Running = false;
         this.continueSessiondump();
         super.cancel();
      }
      
      override public function perform() : void
      {
         var _WorldMapStorage:WorldMapStorage = Tibia.s_GetWorldMapStorage();
         try
         {
            if(this.m_Running == false)
            {
               SessiondumpMouseShield.getInstance().startFadeAnimation();
               this.m_Running = true;
               this.showGraphicalHint();
               SessiondumpHintActionsController.getInstance().registerConditionListener(this.m_Condition,this.continueSessiondump);
               m_Processed = false;
            }
            return;
         }
         catch(e:Error)
         {
            throw new Error("SessiondumpHintCondition.perform: Failed to perform condition at " + timestamp + ":\n" + e.message);
         }
      }
      
      private function continueSessiondump() : void
      {
         SessiondumpMouseShield.getInstance().reset();
         this.m_Running = false;
         Tibia.s_GetUIEffectsManager().clearEffects();
         m_Processed = true;
      }
      
      override public function reset() : void
      {
         this.m_Running = false;
         super.reset();
      }
      
      private function showGraphicalHint() : void
      {
         var _loc4_:HintConditionAutowalk = null;
         var _loc5_:HintConditionMove = null;
         var _loc6_:HintConditionTalk = null;
         var _loc7_:HintConditionAttack = null;
         var _loc8_:HintConditionGreet = null;
         var _loc9_:HintConditionUse = null;
         var _loc10_:AppearanceType = null;
         var _loc1_:CreatureStorage = Tibia.s_GetCreatureStorage();
         var _loc2_:WorldMapStorage = Tibia.s_GetWorldMapStorage();
         var _loc3_:Creature = null;
         if(this.m_Condition is HintConditionAutowalk)
         {
            _loc4_ = this.m_Condition as HintConditionAutowalk;
            Tibia.s_GetUIEffectsManager().showMapEffect(_loc4_.mapCoordinate);
            SessiondumpMouseShield.getInstance().clearMouseHoles();
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc4_.mapCoordinate));
         }
         else if(this.m_Condition is HintConditionMove)
         {
            _loc5_ = this.m_Condition as HintConditionMove;
            Tibia.s_GetUIEffectsManager().showDragDropEffect(_loc5_.sourcePosition,_loc5_.destinationPosition);
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc5_.sourcePosition));
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc5_.destinationPosition));
         }
         else if(this.m_Condition is HintConditionTalk)
         {
            _loc6_ = this.m_Condition as HintConditionTalk;
            Tibia.s_GetUIEffectsManager().showKeywordEffect(_loc6_.text);
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromKeyword(_loc6_.text));
         }
         else if(this.m_Condition is HintConditionAttack)
         {
            _loc7_ = this.m_Condition as HintConditionAttack;
            _loc3_ = _loc1_.getCreatureByName(_loc7_.creatureName);
            if(_loc3_ != null)
            {
               Tibia.s_GetUIEffectsManager().showMapEffect(_loc3_.position);
               Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(BattlelistWidgetView,_loc3_,false);
               SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc3_.position));
               SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(BattlelistWidgetView,_loc3_));
            }
         }
         else if(this.m_Condition is HintConditionGreet)
         {
            _loc8_ = this.m_Condition as HintConditionGreet;
            _loc3_ = _loc1_.getCreatureByName(_loc8_.creatureName);
            if(_loc3_ != null)
            {
               Tibia.s_GetUIEffectsManager().showMapEffect(_loc3_.position);
               Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(BattlelistWidgetView,_loc3_,false);
               SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc3_.position));
               SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(BattlelistWidgetView,_loc3_));
            }
         }
         else if(this.m_Condition is HintConditionUse)
         {
            _loc9_ = this.m_Condition as HintConditionUse;
            Tibia.s_GetUIEffectsManager().showUseEffect(_loc9_.absolutePosition,_loc9_.multiuseTarget);
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc9_.absolutePosition));
            SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromCoordinate(_loc9_.multiuseTarget));
            _loc10_ = Tibia.s_GetAppearanceStorage().getObjectType(_loc9_.useTypeID);
            if(_loc10_ != null)
            {
               Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(ActionBarWidget,_loc10_);
               SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(ActionBarWidget,_loc10_));
            }
         }
      }
   }
}
