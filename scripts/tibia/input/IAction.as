package tibia.input
{
    import tibia.input.*;

    public interface IAction extends IActionImpl
    {

        public function IAction();

        function get hidden() : Boolean;

        function toString() : String;

        function clone() : IAction;

        function marshall() : XML;

        function equals(param1:IAction) : Boolean;

    }
}
