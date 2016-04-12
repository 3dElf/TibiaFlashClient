package tibia.options.configurationWidgetClasses
{
    import mx.core.*;
    import mx.styles.*;
    import tibia.options.*;

    public interface IOptionsEditor extends IUIComponent, ISimpleStyleClient
    {

        public function IOptionsEditor();

        function get creationPolicy() : String;

        function set creationPolicy(param1:String) : void;

        function close(param1:Boolean = false) : void;

        function set options(param1:OptionsStorage) : void;

        function get options() : OptionsStorage;

    }
}
