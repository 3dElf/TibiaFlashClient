package tibia.chat
{
    import mx.collections.*;
    import shared.utility.*;
    import tibia.creatures.*;
    import tibia.options.*;

    public class NameFilterSet extends Object
    {
        protected var m_BlackItems:IList = null;
        protected var m_BlackYelling:Boolean = false;
        protected var m_WhiteEnabled:Boolean = true;
        protected var m_WhiteItems:IList = null;
        protected var m_ID:int = 0;
        protected var m_BlackEnabled:Boolean = true;
        protected var m_BlackPrivate:Boolean = false;
        protected var m_WhiteBuddies:Boolean = false;
        public static const DEFAULT_SET:int = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        public static const NUM_SETS:int = 1;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function NameFilterSet(param1:int)
        {
            this.m_ID = param1;
            this.m_BlackItems = new ArrayCollection();
            this.m_WhiteItems = new ArrayCollection();
            return;
        }// end function

        public function removeBlacklist(param1:String) : void
        {
            var _loc_2:* = -1;
            do
            {
                
                this.m_BlackItems.removeItemAt(_loc_2);
                var _loc_3:* = this.indexOf(param1, this.m_BlackItems);
                _loc_2 = this.indexOf(param1, this.m_BlackItems);
            }while (_loc_3 > -1)
            return;
        }// end function

        public function set whitelistBuddies(param1:Boolean) : void
        {
            this.m_WhiteBuddies = param1;
            return;
        }// end function

        public function addBlacklist(param1:String, param2:Boolean = false) : void
        {
            if (this.indexOf(param1, this.m_BlackItems) < 0)
            {
                this.m_BlackItems.addItem(new NameFilterItem(param1, param2));
            }
            return;
        }// end function

        public function set blacklistEnabled(param1:Boolean) : void
        {
            this.m_BlackEnabled = param1;
            return;
        }// end function

        public function set blacklistPrivate(param1:Boolean) : void
        {
            this.m_BlackPrivate = param1;
            return;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<namefilterset id=\"" + this.m_ID + "\">\r\n                         " + ("<blacklistEnabled>" + this.m_BlackEnabled + "</blacklistEnabled>") + "\r\n                         " + ("<blacklistPrivate>" + this.m_BlackPrivate + "</blacklistPrivate>") + "\r\n                         " + ("<blacklistYelling>" + this.m_BlackYelling + "</blacklistYelling>") + "\r\n                         " + ("<whitelistEnabled>" + this.m_WhiteEnabled + "</whitelistEnabled>") + "\r\n                         " + ("<whitelistBuddies>" + this.m_WhiteBuddies + "</whitelistBuddies>") + "\r\n                       </namefilterset>");
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            _loc_5 = <blacklistItems/>;
            _loc_2 = 0;
            _loc_3 = this.m_BlackItems.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = NameFilterItem(this.m_BlackItems.getItemAt(_loc_2));
                if (_loc_4.permanent)
                {
                    _loc_5.appendChild(new XML("<name>" + _loc_4.pattern + "</name>"));
                }
                _loc_2++;
            }
            _loc_1.appendChild(_loc_5);
            _loc_5 = <whitelistItems/>;
            _loc_2 = 0;
            _loc_3 = this.m_WhiteItems.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = NameFilterItem(this.m_WhiteItems.getItemAt(_loc_2));
                if (_loc_4.permanent)
                {
                    _loc_5.appendChild(new XML("<name>" + _loc_4.pattern + "</name>"));
                }
                _loc_2++;
            }
            _loc_1.appendChild(_loc_5);
            return _loc_1;
        }// end function

        function get whitelistItems() : IList
        {
            return this.m_WhiteItems;
        }// end function

        private function indexOf(param1:String, param2:IList) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1 != null && param2 != null)
            {
                param1 = param1.toLowerCase();
                _loc_3 = param2.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_4 = NameFilterItem(param2.getItemAt(_loc_3));
                    if (_loc_4 != null && _loc_4.pattern != null && _loc_4.pattern.toLowerCase() == param1)
                    {
                        return _loc_3;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return -1;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function isWhitelisted(param1:String) : Boolean
        {
            return this.indexOf(param1, this.m_WhiteItems) > -1;
        }// end function

        public function get whitelistBuddies() : Boolean
        {
            return this.m_WhiteBuddies;
        }// end function

        public function acceptMessage(param1:int, param2:String, param3:String) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this.m_WhiteEnabled)
            {
                _loc_4 = Tibia.s_GetOptions();
                _loc_5 = null;
                var _loc_6:* = _loc_4.getBuddySet(BuddySet.DEFAULT_SET);
                _loc_5 = _loc_4.getBuddySet(BuddySet.DEFAULT_SET);
                if (this.m_WhiteBuddies && _loc_4 != null && _loc_6 != null && _loc_5.getBuddy(param2) != null)
                {
                    return true;
                }
                if (this.indexOf(param2, this.m_WhiteItems) > -1)
                {
                    return true;
                }
            }
            if (this.m_BlackEnabled)
            {
                if (this.m_BlackPrivate && param1 == MessageMode.MESSAGE_PRIVATE_FROM)
                {
                    return false;
                }
                if (this.m_BlackYelling && param1 == MessageMode.MESSAGE_YELL)
                {
                    return false;
                }
                if (this.indexOf(param2, this.m_BlackItems) > -1)
                {
                    return false;
                }
            }
            return true;
        }// end function

        function get blacklistItems() : IList
        {
            return this.m_BlackItems;
        }// end function

        public function get blacklistEnabled() : Boolean
        {
            return this.m_BlackEnabled;
        }// end function

        public function isBlacklisted(param1:String) : Boolean
        {
            return this.indexOf(param1, this.m_BlackItems) > -1;
        }// end function

        public function set blacklistYelling(param1:Boolean) : void
        {
            this.m_BlackYelling = param1;
            return;
        }// end function

        public function get blacklistPrivate() : Boolean
        {
            return this.m_BlackPrivate;
        }// end function

        public function get blacklistYelling() : Boolean
        {
            return this.m_BlackYelling;
        }// end function

        public function get whitelistEnabled() : Boolean
        {
            return this.m_WhiteEnabled;
        }// end function

        public function set whitelistEnabled(param1:Boolean) : void
        {
            this.m_WhiteEnabled = param1;
            return;
        }// end function

        public function clone() : NameFilterSet
        {
            var _loc_1:* = new NameFilterSet(this.ID);
            _loc_1.blacklistEnabled = this.blacklistEnabled;
            _loc_1.blacklistPrivate = this.blacklistPrivate;
            _loc_1.blacklistYelling = this.blacklistYelling;
            _loc_1.whitelistBuddies = this.whitelistBuddies;
            _loc_1.whitelistEnabled = this.whitelistEnabled;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            _loc_2 = 0;
            _loc_3 = this.m_BlackItems.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_1.m_BlackItems.addItem(this.m_BlackItems.getItemAt(_loc_2).clone());
                _loc_2++;
            }
            _loc_2 = 0;
            _loc_3 = this.m_WhiteItems.length;
            while (_loc_2 < _loc_3)
            {
                
                _loc_1.m_WhiteItems.addItem(this.m_WhiteItems.getItemAt(_loc_2).clone());
                _loc_2++;
            }
            return _loc_1;
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : NameFilterSet
        {
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 == null || param1.localName() != "namefilterset" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("NameFilterSet.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_9:* = param1.@id;
            _loc_3 = param1.@id;
            if (_loc_9 == null || _loc_3.length() != 1)
            {
                return null;
            }
            _loc_4 = parseInt(_loc_3[0].toString());
            var _loc_5:* = new NameFilterSet(_loc_4);
            for each (_loc_6 in param1.elements())
            {
                
                switch(_loc_6.localName())
                {
                    case "blacklistEnabled":
                    {
                        _loc_5.blacklistEnabled = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "blacklistPrivate":
                    {
                        _loc_5.blacklistPrivate = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "blacklistYelling":
                    {
                        _loc_5.blacklistYelling = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "blacklistItems":
                    {
                        for each (_loc_7 in _loc_6.elements("name"))
                        {
                            
                            ns_options_internal::blacklistItems.addItem(new NameFilterItem(XMLHelper.s_UnmarshallString(_loc_7), true));
                        }
                        break;
                    }
                    case "whitelistEnabled":
                    {
                        _loc_5.whitelistEnabled = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "whitelistBuddies":
                    {
                        _loc_5.whitelistBuddies = XMLHelper.s_UnmarshallBoolean(_loc_6);
                        break;
                    }
                    case "whitelistItems":
                    {
                        for each (_loc_8 in _loc_6.elements("name"))
                        {
                            
                            ns_options_internal::whitelistItems.addItem(new NameFilterItem(XMLHelper.s_UnmarshallString(_loc_8), true));
                        }
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return _loc_5;
        }// end function

    }
}
