package tibia.sessiondump.controller
{
    import flash.events.*;
    import tibia.input.*;
    import tibia.sessiondump.hints.condition.*;
    import tibia.sessiondump.hints.gameaction.*;

    public class SessiondumpHintActionsController extends EventDispatcher
    {
        private var m_CurrentCondition:HintConditionBase = null;
        private var m_ConditionCallback:Function = null;
        private static var s_Instance:SessiondumpHintActionsController = null;

        public function SessiondumpHintActionsController()
        {
            return;
        }// end function

        private function conditionMet() : void
        {
            this.m_ConditionCallback.call();
            this.m_CurrentCondition = null;
            this.m_ConditionCallback = null;
            return;
        }// end function

        public function get currentCondition() : HintConditionBase
        {
            return this.m_CurrentCondition;
        }// end function

        public function actionPerformed(param1:IActionImpl) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (param1 is SessiondumpHintsAutowalkActionImpl && this.m_CurrentCondition is HintConditionAutowalk)
            {
                _loc_2 = this.m_CurrentCondition as HintConditionAutowalk;
                _loc_3 = param1 as SessiondumpHintsAutowalkActionImpl;
                if (_loc_3.meetsCondition(_loc_2))
                {
                    this.conditionMet();
                }
            }
            else if (param1 is SessiondumpHintsMoveActionImpl && this.m_CurrentCondition is HintConditionMove)
            {
                _loc_4 = this.m_CurrentCondition as HintConditionMove;
                _loc_5 = param1 as SessiondumpHintsMoveActionImpl;
                if (_loc_5.meetsCondition(_loc_4))
                {
                    this.conditionMet();
                }
            }
            else if (param1 is SessiondumpHintsToggleAttackTargetActionImpl && this.m_CurrentCondition is HintConditionAttack)
            {
                _loc_6 = this.m_CurrentCondition as HintConditionAttack;
                _loc_7 = param1 as SessiondumpHintsToggleAttackTargetActionImpl;
                if (_loc_7.meetsCondition(_loc_6))
                {
                    this.conditionMet();
                }
            }
            else if (param1 is SessiondumpHintsGreetActionImpl && this.m_CurrentCondition is HintConditionGreet)
            {
                _loc_8 = this.m_CurrentCondition as HintConditionGreet;
                _loc_9 = param1 as SessiondumpHintsGreetActionImpl;
                if (_loc_9.meetsCondition(_loc_8))
                {
                    this.conditionMet();
                }
            }
            else if (param1 is SessiondumpHintsTalkActionImpl && this.m_CurrentCondition is HintConditionTalk)
            {
                _loc_10 = this.m_CurrentCondition as HintConditionTalk;
                _loc_11 = param1 as SessiondumpHintsTalkActionImpl;
                if (_loc_11.meetsCondition(_loc_10))
                {
                    this.conditionMet();
                }
            }
            else if (param1 is SessiondumpHintsUseActionImpl && this.m_CurrentCondition is HintConditionUse)
            {
                _loc_12 = this.m_CurrentCondition as HintConditionUse;
                _loc_13 = param1 as SessiondumpHintsUseActionImpl;
                if (_loc_13.meetsCondition(_loc_12))
                {
                    this.conditionMet();
                }
            }
            return;
        }// end function

        public function registerConditionListener(param1:HintConditionBase, param2:Function) : void
        {
            this.m_CurrentCondition = param1;
            this.m_ConditionCallback = param2;
            return;
        }// end function

        public static function getInstance() : SessiondumpHintActionsController
        {
            if (s_Instance == null)
            {
                s_Instance = new SessiondumpHintActionsController;
            }
            return s_Instance;
        }// end function

    }
}
