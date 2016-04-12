package tibia.game.serverModalDialogClasses
{

    public class Choice extends Object
    {
        private var m_Label:String;
        private var m_Value:int;

        public function Choice(param1:String, param2:int)
        {
            this.m_Label = param1;
            if (this.m_Label == null || this.m_Label == "")
            {
                throw new ArgumentError("Choice.Choice: Invalid label.");
            }
            this.m_Value = param2;
            return;
        }// end function

        public function get value() : int
        {
            return this.m_Value;
        }// end function

        public function get label() : String
        {
            return this.m_Label;
        }// end function

    }
}
