package tibia.actionbar.widgetClasses
{
    import mx.core.*;
    import tibia.input.*;

    public interface IActionButton extends IFlexDisplayObject, IUIComponent, IToolTipManagerClient, IInvalidating
    {

        public function IActionButton();

        function get position() : int;

        function set position(param1:int) : void;

        function set action(param1:IAction) : void;

        function get action() : IAction;

    }
}
