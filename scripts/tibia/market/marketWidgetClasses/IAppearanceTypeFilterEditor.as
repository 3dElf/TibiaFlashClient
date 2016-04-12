package tibia.market.marketWidgetClasses
{
    import mx.core.*;
    import mx.styles.*;
    import tibia.appearances.*;

    public interface IAppearanceTypeFilterEditor extends IUIComponent, IStyleClient
    {

        public function IAppearanceTypeFilterEditor();

        function get filterFunction() : Function;

        function invalidateFilterFunction() : void;

        function adjustFilterFunction(param1:AppearanceType) : void;

    }
}
