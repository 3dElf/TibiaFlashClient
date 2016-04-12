package shared.utility
{
    import flash.utils.*;

    public class WeakReference extends Object
    {
        private var m_Dictionary:Dictionary;

        public function WeakReference(param1 = null)
        {
            this.m_Dictionary = new Dictionary(true);
            this.value = param1;
            return;
        }// end function

        public function get value()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this.m_Dictionary)
            {
                
                return _loc_1;
            }
            return null;
        }// end function

        public function set value(param1) : void
        {
            var _loc_2:* = undefined;
            for (_loc_2 in this.m_Dictionary)
            {
                
                delete _loc_4[_loc_2];
            }
            if (param1 != null)
            {
                _loc_4[param1] = true;
            }
            return;
        }// end function

    }
}
