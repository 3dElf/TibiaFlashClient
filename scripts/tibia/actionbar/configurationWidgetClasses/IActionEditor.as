package tibia.actionbar.configurationWidgetClasses
{
    import mx.core.*;
    import mx.styles.*;
    import tibia.input.*;

    public interface IActionEditor extends IUIComponent, ISimpleStyleClient
    {

        public function IActionEditor();

        function set action(param1:IAction) : void;

        function get action() : IAction;

    }
}
