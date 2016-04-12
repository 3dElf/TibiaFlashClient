package tibia.input.gameaction
{
    import mx.events.*;
    import mx.resources.*;
    import shared.utility.*;
    import tibia.appearances.*;
    import tibia.chat.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.input.widgetClasses.*;
    import tibia.network.*;
    import tibia.worldmap.*;

    public class MoveActionImpl extends Object implements IActionImpl
    {
        protected var m_Position:int = -1;
        protected var m_SourceAbsolute:Vector3D = null;
        protected var m_ObjectAmount:int = 0;
        protected var m_DestAbsolute:Vector3D = null;
        protected var m_ObjectType:AppearanceType = null;
        protected var m_MoveAmount:int = -2;
        private static const BUNDLE:String = "StaticAction";
        public static const MOVE_ALL:int = -2;
        public static const MOVE_ASK:int = -1;

        public function MoveActionImpl(param1:Vector3D, param2:ObjectInstance, param3:int, param4:Vector3D, param5:int)
        {
            if (param1 == null)
            {
                throw new ArgumentError("MoveActionImpl.MoveActionImpl: Invalid source co-ordinate.");
            }
            this.m_SourceAbsolute = param1.clone();
            if (param2 == null || param2.type == null)
            {
                throw new ArgumentError("MoveActionImpl.MoveActionImpl: Invalid object.");
            }
            this.m_ObjectType = param2.type;
            if (this.m_ObjectType.isCumulative)
            {
                this.m_ObjectAmount = param2.data;
            }
            else
            {
                this.m_ObjectAmount = 1;
            }
            this.m_Position = param3;
            if (param4 == null)
            {
                throw new ArgumentError("MoveActionImpl.MoveActionImpl: Invalid destination co-ordinate.");
            }
            this.m_DestAbsolute = param4.clone();
            if (param5 < MOVE_ALL || param5 > 100)
            {
                throw new ArgumentError("MoveActionImpl.MoveActionImpl: Invalid amount.");
            }
            this.m_MoveAmount = param5;
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this.m_SourceAbsolute.equals(this.m_DestAbsolute))
            {
                if (this.m_ObjectType.isUnmoveable)
                {
                    _loc_2 = Tibia.s_GetWorldMapStorage();
                    _loc_3 = ResourceManager.getInstance();
                    _loc_2.addOnscreenMessage(MessageMode.MESSAGE_FAILURE, _loc_3.getString(BUNDLE, "GAME_MOVE_UNMOVEABLE"));
                }
                else if (this.m_ObjectType.isCumulative && this.m_ObjectAmount > 1 && this.m_MoveAmount == MOVE_ASK)
                {
                    _loc_4 = new SplitStackWidget();
                    _loc_4.objectType = this.m_ObjectType;
                    _loc_4.objectAmount = this.m_ObjectAmount;
                    _loc_4.selectedAmount = this.m_ObjectAmount;
                    _loc_4.addEventListener(CloseEvent.CLOSE, this.onWidgetClose);
                    _loc_4.show();
                }
                else
                {
                    this.performInternal(this.m_MoveAmount);
                }
            }
            return;
        }// end function

        private function onWidgetClose(event:CloseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = event.currentTarget as SplitStackWidget;
            _loc_2 = event.currentTarget as SplitStackWidget;
            if (event != null && event.detail == PopUpBase.BUTTON_OKAY && _loc_3 != null)
            {
                this.performInternal(_loc_2.selectedAmount);
            }
            return;
        }// end function

        private function performInternal(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 == MOVE_ALL)
            {
                _loc_2 = this.m_ObjectAmount;
            }
            else if (param1 > 0 && param1 <= this.m_ObjectAmount)
            {
                _loc_2 = param1;
            }
            else
            {
                _loc_2 = 1;
            }
            var _loc_3:* = Tibia.s_GetCommunication();
            if (_loc_3 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCMOVEOBJECT(this.m_SourceAbsolute.x, this.m_SourceAbsolute.y, this.m_SourceAbsolute.z, this.m_ObjectType.ID, this.m_Position, this.m_DestAbsolute.x, this.m_DestAbsolute.y, this.m_DestAbsolute.z, _loc_2);
            }
            return;
        }// end function

    }
}
