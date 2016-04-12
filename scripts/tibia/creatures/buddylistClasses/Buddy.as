package tibia.creatures.buddylistClasses
{
    import flash.events.*;
    import mx.events.*;
    import shared.utility.*;
    import tibia.reporting.*;
    import tibia.reporting.reportType.*;

    public class Buddy extends EventDispatcher implements IReportable
    {
        protected var m_Description:String = null;
        protected var m_Status:uint = 0;
        protected var m_Icon:int = 0;
        protected var m_ID:int = 0;
        protected var m_LastUpdate:Number = NaN;
        protected var m_Notify:Boolean = false;
        protected var m_Name:String = null;
        public static const STATUS_ONLINE:uint = 1;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const STATUS_PENDING:uint = 2;
        public static const NUM_BUDDIES:int = 2.14748e+009;
        private static const LOGIN_HIGHLIGHT_TIME:Number = 1000;
        public static const STATUS_OFFLINE:uint = 0;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function Buddy(param1:int, param2:String)
        {
            this.m_ID = param1;
            this.m_Name = param2;
            return;
        }// end function

        public function set name(param1:String) : void
        {
            var _loc_2:* = this.name;
            if (_loc_2 !== param1)
            {
                this._3373707name = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "name", _loc_2, param1));
            }
            return;
        }// end function

        public function set lastUpdate(param1:Number) : void
        {
            var _loc_2:* = this.lastUpdate;
            if (_loc_2 !== param1)
            {
                this._1992879871lastUpdate = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lastUpdate", _loc_2, param1));
            }
            return;
        }// end function

        public function set status(param1:uint) : void
        {
            var _loc_2:* = this.status;
            if (_loc_2 !== param1)
            {
                this._892481550status = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "status", _loc_2, param1));
            }
            return;
        }// end function

        public function get notify() : Boolean
        {
            return this.m_Notify;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        private function set _892481550status(param1:uint) : void
        {
            if (param1 != STATUS_ONLINE && param1 != STATUS_OFFLINE && param1 != STATUS_PENDING)
            {
                throw new ArgumentError("Buddy.state: Invalid buddy state");
            }
            this.m_Status = param1;
            return;
        }// end function

        public function set description(param1:String) : void
        {
            var _loc_2:* = this.description;
            if (_loc_2 !== param1)
            {
                this._1724546052description = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _loc_2, param1));
            }
            return;
        }// end function

        public function set notify(param1:Boolean) : void
        {
            var _loc_2:* = this.notify;
            if (_loc_2 !== param1)
            {
                this._1039689911notify = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notify", _loc_2, param1));
            }
            return;
        }// end function

        public function get characterName() : String
        {
            return this.m_Name;
        }// end function

        private function set _3373707name(param1:String) : void
        {
            this.m_Name = param1;
            return;
        }// end function

        public function clone() : Buddy
        {
            var _loc_1:* = new Buddy(this.m_ID, this.m_Name);
            _loc_1.description = this.m_Description;
            _loc_1.icon = this.m_Icon;
            _loc_1.lastUpdate = this.m_LastUpdate;
            _loc_1.notify = this.m_Notify;
            _loc_1.status = this.m_Status;
            return _loc_1;
        }// end function

        private function set _3226745icon(param1:int) : void
        {
            this.m_Icon = Math.max(0, Math.min(param1, (BuddyIcon.NUM_ICONS - 1)));
            return;
        }// end function

        public function set icon(param1:int) : void
        {
            var _loc_2:* = this.icon;
            if (_loc_2 !== param1)
            {
                this._3226745icon = param1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "icon", _loc_2, param1));
            }
            return;
        }// end function

        private function set _1039689911notify(param1:Boolean) : void
        {
            this.m_Notify = param1;
            return;
        }// end function

        private function set _1992879871lastUpdate(param1:Number) : void
        {
            this.m_LastUpdate = param1;
            return;
        }// end function

        public function isReportTypeAllowed(param1:uint) : Boolean
        {
            return param1 == Type.REPORT_NAME;
        }// end function

        public function get status() : uint
        {
            return this.m_Status;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function get highlight() : Boolean
        {
            return this.m_Status == STATUS_ONLINE && this.m_LastUpdate > Tibia.s_FrameTibiaTimestamp - LOGIN_HIGHLIGHT_TIME;
        }// end function

        public function setReportTypeAllowed(param1:uint, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get icon() : int
        {
            return this.m_Icon;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

        private function set _1724546052description(param1:String) : void
        {
            this.m_Description = StringHelper.s_Trim(param1);
            return;
        }// end function

        public function get lastUpdate() : Number
        {
            return this.m_LastUpdate;
        }// end function

    }
}
