package tibia.questlog
{

    public class QuestFlag extends Object
    {
        private var m_Description:String = null;
        private var m_Name:String = null;
        public static const MAX_DESCRIPTION_LENGTH:int = 200;
        public static const MAX_NAME_LENGTH:int = 50;

        public function QuestFlag(param1:String, param2:String)
        {
            if (param1 == null || param1.length > MAX_NAME_LENGTH)
            {
                throw new ArgumentError("QuestFlag.QuestFlag: Invalid name: \"" + param1 + "\".");
            }
            this.m_Name = param1;
            if (param2 == null || param2.length > MAX_DESCRIPTION_LENGTH)
            {
                throw new ArgumentError("QuestFlag.QuestFlag: Invalid description: \"" + param2 + "\".");
            }
            this.m_Description = param2;
            return;
        }// end function

        public function get name() : String
        {
            return this.m_Name;
        }// end function

        public function get description() : String
        {
            return this.m_Description;
        }// end function

    }
}
