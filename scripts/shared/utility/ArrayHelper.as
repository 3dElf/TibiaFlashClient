package shared.utility
{

    public class ArrayHelper extends Object
    {

        public function ArrayHelper()
        {
            return;
        }// end function

        public static function s_IndexOf(param1:Array, param2:String, param3) : int
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 != null && param2 != null)
            {
                _loc_4 = 0;
                _loc_5 = param1.length;
                while (_loc_4 < _loc_5)
                {
                    
                    if (param1[_loc_4] != null && param1[_loc_4].hasOwnProperty(param2) && param1[_loc_4][param2] == param3)
                    {
                        return _loc_4;
                    }
                    _loc_4++;
                }
            }
            return -1;
        }// end function

    }
}
