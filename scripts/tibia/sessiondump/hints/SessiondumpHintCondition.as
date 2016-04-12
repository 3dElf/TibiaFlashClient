package tibia.sessiondump.hints
{
    import tibia.actionbar.widgetClasses.*;
    import tibia.appearances.*;
    import tibia.creatures.*;
    import tibia.creatures.battlelistWidgetClasses.*;
    import tibia.help.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.condition.*;
    import tibia.worldmap.*;

    public class SessiondumpHintCondition extends SessiondumpHintBase
    {
        private var m_Condition:HintConditionBase = null;
        private var m_Running:Boolean = false;
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
        private static var FIELD_USEDESTINATIONPOSITION:String = "usedestinationposition";
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
        private static var FIELD_OFFSET:String = "offset";
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
        private static var FIELD_TEXTHINT:String = "texthint";
        private static var FIELD_COORDINATE:String = "coordinate";

        public function SessiondumpHintCondition()
        {
            m_Type = TYPE;
            return;
        }// end function

        override public function perform() : void
        {
            var _WorldMapStorage:* = Tibia.s_GetWorldMapStorage();
            try
            {
                if (this.m_Running == false)
                {
                    this.m_Running = true;
                    this.showGraphicalHint();
                    SessiondumpHintActionsController.getInstance().registerConditionListener(this.m_Condition, this.continueSessiondump);
                    m_Processed = false;
                }
            }
            catch (e:Error)
            {
                throw new Error("SessiondumpHintCondition.perform: Failed to perform condition at " + timestamp + ":\n" + e.message);
            }
            return;
        }// end function

        private function showGraphicalHint() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_1:* = Tibia.s_GetCreatureStorage();
            var _loc_2:* = Tibia.s_GetWorldMapStorage();
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.m_Condition is HintConditionAutowalk)
            {
                _loc_6 = this.m_Condition as HintConditionAutowalk;
                Tibia.s_GetUIEffectsManager().showMapEffect(_loc_6.mapCoordinate);
                SessiondumpMouseShield.getInstance().clearMouseHoles();
                _loc_4 = GUIRectangle.s_FromCoordinate(_loc_6.mapCoordinate);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
            }
            else if (this.m_Condition is HintConditionMove)
            {
                _loc_7 = this.m_Condition as HintConditionMove;
                Tibia.s_GetUIEffectsManager().showDragDropEffect(_loc_7.sourcePosition, _loc_7.destinationPosition);
                _loc_4 = GUIRectangle.s_FromCoordinate(_loc_7.sourcePosition);
                _loc_5 = GUIRectangle.s_FromCoordinate(_loc_7.destinationPosition);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_5);
            }
            else if (this.m_Condition is HintConditionTalk)
            {
                _loc_8 = this.m_Condition as HintConditionTalk;
                Tibia.s_GetUIEffectsManager().showKeywordEffect(_loc_8.text);
                _loc_4 = GUIRectangle.s_FromKeyword(_loc_8.text);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
            }
            else if (this.m_Condition is HintConditionAttack)
            {
                _loc_9 = this.m_Condition as HintConditionAttack;
                _loc_3 = _loc_1.getCreatureByName(_loc_9.creatureName);
                if (_loc_3 != null)
                {
                    Tibia.s_GetUIEffectsManager().showMapEffect(_loc_3.position);
                    Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(BattlelistWidgetView, _loc_3, false);
                    _loc_4 = GUIRectangle.s_FromCoordinate(_loc_3.position);
                    SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
                    SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(BattlelistWidgetView, _loc_3));
                }
            }
            else if (this.m_Condition is HintConditionGreet)
            {
                _loc_10 = this.m_Condition as HintConditionGreet;
                _loc_3 = _loc_1.getCreatureByName(_loc_10.creatureName);
                if (_loc_3 != null)
                {
                    Tibia.s_GetUIEffectsManager().showMapEffect(_loc_3.position);
                    Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(BattlelistWidgetView, _loc_3, false);
                    _loc_4 = GUIRectangle.s_FromCoordinate(_loc_3.position);
                    SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
                    SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(BattlelistWidgetView, _loc_3));
                }
            }
            else if (this.m_Condition is HintConditionUse)
            {
                _loc_11 = this.m_Condition as HintConditionUse;
                Tibia.s_GetUIEffectsManager().showUseEffect(_loc_11.absolutePosition, _loc_11.multiuseTarget);
                _loc_4 = GUIRectangle.s_FromCoordinate(_loc_11.absolutePosition);
                _loc_5 = GUIRectangle.s_FromCoordinate(_loc_11.multiuseTarget);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_4);
                SessiondumpMouseShield.getInstance().addMouseHole(_loc_5);
                _loc_12 = Tibia.s_GetAppearanceStorage().getObjectType(_loc_11.useTypeID);
                if (_loc_12 != null)
                {
                    Tibia.s_GetUIEffectsManager().higlightUIElementByIdentifier(ActionBarWidget, _loc_12);
                    SessiondumpMouseShield.getInstance().addMouseHole(GUIRectangle.s_FromUIComponent(ActionBarWidget, _loc_12));
                }
            }
            if (this.m_Condition.hintText != null)
            {
                Tibia.s_GetUIEffectsManager().showTextHint(this.m_Condition.hintText, this.m_Condition.hintTextUseDestinationPosition ? (_loc_5) : (_loc_4), this.m_Condition.hintTextOffset);
            }
            return;
        }// end function

        private function continueSessiondump() : void
        {
            SessiondumpMouseShield.getInstance().reset();
            this.m_Running = false;
            Tibia.s_GetUIEffectsManager().clearEffects();
            m_Processed = true;
            return;
        }// end function

        override public function cancel() : void
        {
            SessiondumpMouseShield.getInstance().reset();
            this.m_Running = false;
            this.continueSessiondump();
            super.cancel();
            return;
        }// end function

        override public function reset() : void
        {
            this.m_Running = false;
            super.reset();
            return;
        }// end function

        public static function s_Unmarshall(param1:Object) : SessiondumpHintBase
        {
            var _loc_2:* = new SessiondumpHintCondition;
            if (FIELD_CONDITIONTYPE in param1)
            {
                _loc_2.m_Condition = HintConditionBase.s_Unmarshall(param1);
            }
            return _loc_2;
        }// end function

    }
}
