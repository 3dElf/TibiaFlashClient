package tibia.creatures.buddylistClasses
{

    public class BuddyIcon extends Object
    {
        protected var m_ID:int = 0;
        public static const DEFAULT_ICON:int = 0;
        public static const NUM_ICONS:int = 11;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function BuddyIcon(param1:int)
        {
            if (param1 < 0 || param1 >= NUM_ICONS)
            {
                throw new ArgumentError("Icon.Icon: Invalid ID " + param1 + ".");
            }
            this.m_ID = param1;
            return;
        }// end function

        public function get ID() : int
        {
            return this.m_ID;
        }// end function

        public function marshall() : XML
        {
            return new XML("<icon ID=\"" + this.m_ID + "\"/>");
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : BuddyIcon
        {
            if (param1 == null || param1.localName() != "icon" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("BuddyIcon.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_6:* = param1.@ID;
            _loc_3 = param1.@ID;
            if (_loc_6 == null || _loc_3.length() != 1)
            {
                return null;
            }
            var _loc_4:* = parseInt(_loc_3[0].toString());
            if (parseInt(_loc_3[0].toString()) < 0 || _loc_4 >= NUM_ICONS)
            {
                return null;
            }
            var _loc_5:* = new BuddyIcon(_loc_4);
            return new BuddyIcon(_loc_4);
        }// end function

    }
}
