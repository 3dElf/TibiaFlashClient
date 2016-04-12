package tibia.creatures
{
    import __AS3__.vec.*;
    import flash.events.*;
    import mx.collections.*;
    import mx.resources.*;
    import tibia.chat.*;
    import tibia.creatures.buddylistClasses.*;
    import tibia.network.*;
    import tibia.worldmap.*;

    public class BuddySet extends EventDispatcher
    {
        private var m_Icons:Vector.<BuddyIcon> = null;
        private var m_ID:int = 0;
        private var m_Buddies:IList = null;
        private static const BUDDIES_REFRESH:int = 1;
        public static const DEFAULT_SET:int = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 1;
        private static const BUDDIES_REBUILD:int = 2;
        private static const BUNDLE:String = "BuddylistWidget";
        private static const BUDDIES_NOACTION:int = 0;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function BuddySet(param1:int)
        {
            this.m_ID = param1;
            this.m_Buddies = new ArrayList();
            this.m_Icons = new Vector.<BuddyIcon>;
            var _loc_2:* = 0;
            while (_loc_2 < BuddyIcon.NUM_ICONS)
            {
                
                this.m_Icons.push(new BuddyIcon(_loc_2));
                _loc_2++;
            }
            return;
        }// end function

        public function removeBuddy(param1:int, param2:Boolean = true) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = this.getBuddyIndex(param1);
            if (_loc_3 > -1)
            {
                this.m_Buddies.removeItemAt(_loc_3);
                _loc_4 = null;
                var _loc_5:* = Tibia.s_GetCommunication();
                _loc_4 = Tibia.s_GetCommunication();
                if (param2 && _loc_5 != null && _loc_4.isGameRunning)
                {
                    _loc_4.sendCREMOVEBUDDY(param1);
                }
            }
            return;
        }// end function

        public function addBuddy(param1:String, param2:Boolean = true) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = Tibia.s_GetCommunication();
            _loc_3 = Tibia.s_GetCommunication();
            if (param2 && _loc_4 != null && _loc_3.isGameRunning)
            {
                _loc_3.sendCADDBUDDY(param1);
            }
            return;
        }// end function

        public function get length() : int
        {
            return this.m_Buddies.length;
        }// end function

        private function getBuddyIndex(param1:int) : int
        {
            var _loc_5:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = this.m_Buddies.length - 1;
            var _loc_4:* = 0;
            while (_loc_2 <= _loc_3)
            {
                
                _loc_4 = _loc_2 + _loc_3 >>> 1;
                _loc_5 = Buddy(this.m_Buddies.getItemAt(_loc_4));
                if (_loc_5.ID < param1)
                {
                    _loc_2 = _loc_4 + 1;
                    continue;
                }
                if (_loc_5.ID > param1)
                {
                    _loc_3 = _loc_4 - 1;
                    continue;
                }
                return _loc_4;
            }
            return -_loc_2 - 1;
        }// end function

        public function get buddies() : IList
        {
            return this.m_Buddies;
        }// end function

        public function markBuddiesOffline() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this.m_Buddies.length - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = Buddy(this.m_Buddies.getItemAt(_loc_1));
                _loc_2.name = null;
                _loc_2.status = Buddy.STATUS_OFFLINE;
                _loc_2.lastUpdate = Number.NEGATIVE_INFINITY;
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public function updateBuddy(param1:int, ... args) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            args = null;
            var _loc_4:* = this.getBuddyIndex(param1);
            if (args.length == 1)
            {
                if (_loc_4 > -1)
                {
                    args = Buddy(this.m_Buddies.getItemAt(_loc_4));
                    args.status = uint(args[0]);
                    args.lastUpdate = Tibia.s_FrameTibiaTimestamp;
                    if (args.status == Buddy.STATUS_ONLINE && args.notify)
                    {
                        _loc_5 = ResourceManager.getInstance().getString(BUNDLE, "NOTIFICATION_MESSAGE", [args.name]);
                        _loc_6 = Tibia.s_GetWorldMapStorage();
                        if (_loc_6 != null)
                        {
                            _loc_6.addOnscreenMessage(MessageMode.MESSAGE_STATUS, _loc_5);
                        }
                        _loc_7 = Tibia.s_GetChatStorage();
                        if (_loc_7 != null)
                        {
                            _loc_7.addChannelMessage(-1, -1, null, 0, MessageMode.MESSAGE_STATUS, _loc_5);
                        }
                    }
                }
            }
            else if (args.length == 5)
            {
                if (_loc_4 > -1)
                {
                    args = Buddy(this.m_Buddies.getItemAt(_loc_4));
                }
                else
                {
                    args = new Buddy(param1, null);
                    if (this.m_Buddies.length < Buddy.NUM_BUDDIES)
                    {
                        this.m_Buddies.addItemAt(args, -_loc_4 - 1);
                    }
                }
                args.name = String(args[0]);
                args.description = String(args[1]);
                args.icon = int(args[2]);
                args.notify = Boolean(args[3]);
                args.status = uint(args[4]);
                args.lastUpdate = Number.NEGATIVE_INFINITY;
            }
            else
            {
                throw new ArgumentError("BuddySet.updateBuddy: Invalid overload.");
            }
            return;
        }// end function

        public function getBuddy(param1) : Buddy
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1 is int)
            {
                _loc_2 = this.getBuddyIndex(int(param1));
                if (_loc_2 > -1)
                {
                    return Buddy(this.m_Buddies.getItemAt(_loc_2));
                }
            }
            else if (param1 is String)
            {
                _loc_3 = String(param1).toLowerCase();
                _loc_4 = this.m_Buddies.length - 1;
                while (_loc_4 >= 0)
                {
                    
                    _loc_5 = Buddy(this.m_Buddies.getItemAt(_loc_4));
                    _loc_6 = _loc_5.name;
                    if (_loc_6 != null)
                    {
                        _loc_6 = _loc_6.toLowerCase();
                    }
                    if (_loc_6 == _loc_3)
                    {
                        return _loc_5;
                    }
                    _loc_4 = _loc_4 - 1;
                }
            }
            return null;
        }// end function

        public function get icons() : Vector.<BuddyIcon>
        {
            return this.m_Icons;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function clone() : BuddySet
        {
            var _loc_4:* = null;
            var _loc_1:* = new BuddySet(this.m_ID);
            var _loc_2:* = 0;
            var _loc_3:* = Math.min(this.m_Buddies.length, Buddy.NUM_BUDDIES);
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = Buddy(this.m_Buddies.getItemAt(_loc_2));
                _loc_1.m_Buddies.addItem(_loc_4.clone());
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public function clearBuddies() : void
        {
            this.m_Buddies.removeAll();
            return;
        }// end function

    }
}
