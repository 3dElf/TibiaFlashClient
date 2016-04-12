package tibia.chat
{
    import shared.utility.*;

    public class NameFilterItem extends Object
    {
        private var m_Pattern:String = null;
        public var permanent:Boolean = false;
        protected var m_Undefined:Boolean = true;

        public function NameFilterItem(param1:String, param2:Boolean)
        {
            this.pattern = param1;
            this.permanent = param2;
            return;
        }// end function

        public function get pattern() : String
        {
            return this.m_Pattern;
        }// end function

        public function clone() : NameFilterItem
        {
            return new NameFilterItem(this.pattern, this.permanent);
        }// end function

        public function set pattern(param1:String) : void
        {
            if (param1 != null)
            {
                param1 = StringHelper.s_Trim(param1);
            }
            if (param1 != null && param1.length > 0)
            {
                this.m_Pattern = param1;
            }
            else
            {
                this.m_Pattern = null;
            }
            return;
        }// end function

    }
}
