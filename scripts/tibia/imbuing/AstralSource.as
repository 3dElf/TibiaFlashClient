package tibia.imbuing
{

    public class AstralSource extends Object
    {
        private var m_AppearanceTypeID:uint = 0;
        private var m_Name:String = "";
        private var m_ObjectCount:uint = 0;

        public function AstralSource(param1:uint, param2:uint, param3:String = "")
        {
            this.m_AppearanceTypeID = param1;
            this.m_ObjectCount = param2;
            this.m_Name = param3;
            return;
        }// end function

        public function get objectCount() : uint
        {
            return this.m_ObjectCount;
        }// end function

        public function get apperanceTypeID() : uint
        {
            return this.m_AppearanceTypeID;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

    }
}
