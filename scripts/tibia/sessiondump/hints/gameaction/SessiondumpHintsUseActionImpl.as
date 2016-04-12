package tibia.sessiondump.hints.gameaction
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.gameaction.*;
    import tibia.magic.*;
    import tibia.network.*;
    import tibia.sessiondump.controller.*;
    import tibia.sessiondump.hints.condition.*;

    public class SessiondumpHintsUseActionImpl extends UseActionImpl
    {
        private var m_DestinationAbsolute:Vector3D = null;
        private var m_DestinationPosition:int = -1;
        private var m_DestinationObjectID:int = -1;
        static var concurrentMultiUse:SessiondumpHintsUseActionImpl = null;

        public function SessiondumpHintsUseActionImpl(param1:Vector3D, param2, param3:int, param4:int = 0)
        {
            super(param1, param2, param3, param4);
            return;
        }// end function

        override public function perform(param1:Boolean = false) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetCreatureStorage();
            var _loc_4:* = Tibia.s_GetContainerStorage();
            var _loc_5:* = Tibia.s_GetPlayer();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null && _loc_4 != null && _loc_5 != null)
            {
                if (m_Absolute.x == 65535 && m_Absolute.y == 0)
                {
                    if (_loc_4.getAvailableInventory(m_Type.ID, m_PositionOrData) < 1)
                    {
                        return;
                    }
                    if (m_Type.isMultiUse && SpellStorage.checkRune(m_Type.ID) && _loc_5.getRuneUses(SpellStorage.getRune(m_Type.ID)) < 1)
                    {
                        return;
                    }
                }
                if (m_Type.isContainer)
                {
                    _loc_6 = 0;
                    if (m_Target == TARGET_NEW_WINDOW || m_Absolute.x < 65535 || m_Absolute.y >= BodyContainerView.FIRST_SLOT && m_Absolute.y <= BodyContainerView.LAST_SLOT)
                    {
                        _loc_6 = _loc_4.getFreeContainerViewID();
                    }
                    else if (m_Absolute.y >= 64 && m_Absolute.y < 64 + ContainerStorage.MAX_CONTAINER_VIEWS)
                    {
                        _loc_6 = m_Absolute.y - 64;
                    }
                    SessiondumpHintActionsController.getInstance().actionPerformed(this);
                }
                else if (!m_Type.isMultiUse)
                {
                    SessiondumpHintActionsController.getInstance().actionPerformed(this);
                }
                else if (m_Target == TARGET_SELF)
                {
                }
                else if (m_Target == TARGET_ATTACK && _loc_3.getAttackTarget() != null)
                {
                }
                else
                {
                    if (m_Absolute.x < 65535)
                    {
                        _loc_7 = Tibia.s_GameActionFactory.createAutowalkAction(m_Absolute.x, m_Absolute.y, m_Absolute.z, false, false);
                        _loc_7.perform();
                    }
                    if (concurrentMultiUse != null)
                    {
                        concurrentMultiUse.updateGlobalListeners(false);
                        concurrentMultiUse.updateCursor(false);
                        concurrentMultiUse = null;
                    }
                    updateGlobalListeners(true);
                    updateCursor(true);
                    concurrentMultiUse = this;
                }
            }
            return;
        }// end function

        override protected function onUsePerform(event:MouseEvent) : void
        {
            var _loc_11:* = null;
            event.preventDefault();
            event.stopImmediatePropagation();
            updateGlobalListeners(false);
            updateCursor(false);
            concurrentMultiUse = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetContainerStorage();
            var _loc_4:* = Tibia.s_GetCreatureStorage();
            if (_loc_2 == null || !_loc_2.isGameRunning || _loc_3 == null || _loc_4 == null)
            {
                return;
            }
            var _loc_5:* = event.target as DisplayObject;
            var _loc_6:* = null;
            if (_loc_5 != null)
            {
                _loc_6 = _loc_5.localToGlobal(new Point(event.localX, event.localY));
            }
            var _loc_7:* = null;
            do
            {
                
                _loc_5 = _loc_5.parent;
                var _loc_12:* = _loc_5 as IUseWidget;
                _loc_7 = _loc_5 as IUseWidget;
            }while (_loc_5 != null && _loc_12 == null)
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_12:* = _loc_7.getMultiUseObjectUnderPoint(_loc_6);
            _loc_10 = _loc_7.getMultiUseObjectUnderPoint(_loc_6);
            var _loc_12:* = _loc_10.object as ObjectInstance;
            _loc_9 = _loc_10.object as ObjectInstance;
            if (_loc_7 != null && _loc_6 != null && _loc_12 != null && _loc_12 != null)
            {
                _loc_11 = null;
                if (_loc_9.ID == AppearanceInstance.CREATURE)
                {
                    _loc_11 = _loc_4.getCreature(_loc_9.data);
                }
                var _loc_12:* = _loc_10.absolute as Vector3D;
                _loc_8 = _loc_10.absolute as Vector3D;
                if ((_loc_11 == null || _loc_11.isHuman) && _loc_12 != null && int(_loc_10.position) > -1)
                {
                    this.m_DestinationAbsolute = _loc_8.clone();
                    this.m_DestinationObjectID = _loc_9.ID;
                    this.m_DestinationPosition = int(_loc_10.position);
                    SessiondumpHintActionsController.getInstance().actionPerformed(this);
                }
            }
            return;
        }// end function

        public function meetsCondition(param1:HintConditionUse) : Boolean
        {
            var _loc_2:* = param1.absolutePosition.equals(m_Absolute) || param1.absolutePosition.x == m_Absolute.x && m_Absolute.y == 0 && m_Absolute.z == 0;
            return _loc_2 && param1.useTypeID == m_Type.ID && (param1.useTarget == m_Target || param1.useTarget == UseActionImpl.TARGET_AUTO) && param1.positionOrData == m_PositionOrData && (param1.multiuseTarget == null || param1.multiuseTarget.equals(this.m_DestinationAbsolute) && param1.multiuseObjectID == this.m_DestinationObjectID && param1.multiuseObjectPosition == this.m_DestinationPosition);
        }// end function

    }
}
