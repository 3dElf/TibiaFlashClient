package tibia.input.gameaction
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import mx.core.*;
    import mx.events.*;
    import mx.managers.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.container.*;
    import tibia.creatures.*;
    import tibia.cursors.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.magic.*;
    import tibia.network.*;

    public class UseActionImpl extends Object implements IActionImpl
    {
        protected var m_Target:int = -1;
        protected var m_PositionOrData:int = -1;
        protected var m_Absolute:Vector3D = null;
        private var m_CursorHelper:CursorHelper;
        protected var m_Type:AppearanceType = null;
        public static const TARGET_NEW_WINDOW:int = 1;
        static var concurrentMultiUse:UseActionImpl = null;
        public static const TARGET_CROSSHAIR:int = 4;
        public static const TARGET_ATTACK:int = 3;
        public static const TARGET_SELF:int = 2;
        public static const TARGET_AUTO:int = 0;

        public function UseActionImpl(param1:Vector3D, param2, param3:int, param4:int = 0)
        {
            var _loc_5:* = null;
            this.m_CursorHelper = new CursorHelper(CursorManagerPriority.HIGH);
            if (param1 == null)
            {
                throw new ArgumentError("UseActionImpl.UseActionImpl: Invalid co-ordinate.");
            }
            this.m_Absolute = param1.clone();
            this.m_Type = null;
            if (param2 is ObjectInstance)
            {
                this.m_Type = ObjectInstance(param2).type;
            }
            else if (param2 is AppearanceType)
            {
                this.m_Type = AppearanceType(param2);
            }
            else if (param2 is int)
            {
                _loc_5 = Tibia.s_GetAppearanceStorage();
                if (_loc_5 != null)
                {
                    this.m_Type = _loc_5.getObjectType(int(param2));
                }
            }
            if (this.m_Type == null)
            {
                throw new ArgumentError("UseActionImpl.UseActionImpl: Invalid type: " + param2);
            }
            if (this.m_Absolute.x == 65535 && this.m_Absolute.y == 0)
            {
                this.m_PositionOrData = param3;
            }
            else if (this.m_Absolute.x == 65535 && this.m_Absolute.y != 0)
            {
                this.m_PositionOrData = this.m_Absolute.z;
            }
            else
            {
                this.m_PositionOrData = param3;
            }
            if (param4 != TARGET_AUTO && param4 != TARGET_NEW_WINDOW && param4 != TARGET_SELF && param4 != TARGET_ATTACK && param4 != TARGET_CROSSHAIR)
            {
                throw new ArgumentError("UseActionImpl.UseActionImpl: Invalid target: " + param4);
            }
            this.m_Target = param4;
            return;
        }// end function

        protected function onUsePerform(event:MouseEvent) : void
        {
            var _loc_11:* = null;
            event.preventDefault();
            event.stopImmediatePropagation();
            this.updateGlobalListeners(false);
            this.updateCursor(false);
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
                    _loc_2.sendCUSETWOOBJECTS(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, _loc_8.x, _loc_8.y, _loc_8.z, _loc_9.ID, int(_loc_10.position));
                }
                else
                {
                    _loc_2.sendCUSEONCREATURE(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, _loc_11.ID);
                }
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_2:* = Tibia.s_GetCommunication();
            var _loc_3:* = Tibia.s_GetCreatureStorage();
            var _loc_4:* = Tibia.s_GetContainerStorage();
            var _loc_5:* = Tibia.s_GetPlayer();
            if (_loc_2 != null && _loc_2.isGameRunning && _loc_3 != null && _loc_4 != null && _loc_5 != null)
            {
                if (this.m_Absolute.x == 65535 && this.m_Absolute.y == 0)
                {
                    if (_loc_4.getAvailableInventory(this.m_Type.ID, this.m_PositionOrData) < 1)
                    {
                        return;
                    }
                    if (this.m_Type.isMultiUse && SpellStorage.checkRune(this.m_Type.ID) && _loc_5.getRuneUses(SpellStorage.getRune(this.m_Type.ID)) < 1)
                    {
                        return;
                    }
                }
                if (this.m_Type.isContainer)
                {
                    _loc_6 = 0;
                    if (this.m_Target == TARGET_NEW_WINDOW || this.m_Absolute.x < 65535 || this.m_Absolute.y >= BodyContainerView.FIRST_SLOT && this.m_Absolute.y <= BodyContainerView.LAST_SLOT)
                    {
                        _loc_6 = _loc_4.getFreeContainerViewID();
                    }
                    else if (this.m_Absolute.y >= 64 && this.m_Absolute.y < 64 + ContainerStorage.MAX_CONTAINER_VIEWS)
                    {
                        _loc_6 = this.m_Absolute.y - 64;
                    }
                    _loc_2.sendCUSEOBJECT(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, _loc_6);
                }
                else if (!this.m_Type.isMultiUse)
                {
                    _loc_2.sendCUSEOBJECT(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, 0);
                }
                else if (this.m_Target == TARGET_SELF)
                {
                    _loc_2.sendCUSEONCREATURE(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, _loc_5.ID);
                }
                else if (this.m_Target == TARGET_ATTACK && _loc_3.getAttackTarget() != null)
                {
                    _loc_2.sendCUSEONCREATURE(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, this.m_Type.ID, this.m_PositionOrData, _loc_3.getAttackTarget().ID);
                }
                else
                {
                    if (this.m_Absolute.x < 65535)
                    {
                        _loc_7 = Tibia.s_GameActionFactory.createAutowalkAction(this.m_Absolute.x, this.m_Absolute.y, this.m_Absolute.z, false, false);
                        _loc_7.perform();
                    }
                    if (concurrentMultiUse != null)
                    {
                        concurrentMultiUse.updateGlobalListeners(false);
                        concurrentMultiUse.updateCursor(false);
                        concurrentMultiUse = null;
                    }
                    this.updateGlobalListeners(true);
                    this.updateCursor(true);
                    concurrentMultiUse = this;
                }
            }
            return;
        }// end function

        private function onUseAbort(event:Event) : void
        {
            event.preventDefault();
            event.stopImmediatePropagation();
            this.updateGlobalListeners(false);
            this.updateCursor(false);
            concurrentMultiUse = null;
            return;
        }// end function

        protected function updateGlobalListeners(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = Tibia.s_GetInstance();
            if (_loc_3 != null && _loc_3.systemManager != null)
            {
                _loc_2 = _loc_3.systemManager.getSandboxRoot();
            }
            if (_loc_2 != null)
            {
                if (param1)
                {
                    _loc_2.addEventListener(MouseEvent.MOUSE_UP, this.onUsePerform, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(MouseEvent.MOUSE_DOWN, this.onUseIgnore, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(MouseEvent.CLICK, this.onUseIgnore, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onUseAbort, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onUseIgnore, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(MouseEvent.RIGHT_CLICK, this.onUseIgnore, true, EventPriority.DEFAULT, false);
                    _loc_2.addEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onUseAbort);
                    _loc_2.addEventListener(Event.DEACTIVATE, this.onUseAbort);
                }
                else
                {
                    _loc_2.removeEventListener(MouseEvent.MOUSE_UP, this.onUsePerform, true);
                    _loc_2.removeEventListener(MouseEvent.MOUSE_DOWN, this.onUseIgnore, true);
                    _loc_2.removeEventListener(MouseEvent.CLICK, this.onUseIgnore, true);
                    _loc_2.removeEventListener(MouseEvent.RIGHT_MOUSE_UP, this.onUseAbort, true);
                    _loc_2.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, this.onUseIgnore, true);
                    _loc_2.removeEventListener(MouseEvent.RIGHT_CLICK, this.onUseIgnore, true);
                    _loc_2.removeEventListener(SandboxMouseEvent.MOUSE_UP_SOMEWHERE, this.onUseAbort);
                    _loc_2.removeEventListener(Event.DEACTIVATE, this.onUseAbort);
                }
            }
            return;
        }// end function

        private function onUseIgnore(event:MouseEvent) : void
        {
            event.preventDefault();
            event.stopImmediatePropagation();
            return;
        }// end function

        protected function updateCursor(param1:Boolean) : void
        {
            if (param1)
            {
                this.m_CursorHelper.setCursor(CrosshairCursor);
            }
            else
            {
                this.m_CursorHelper.resetCursor();
            }
            return;
        }// end function

    }
}
