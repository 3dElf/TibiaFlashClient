package tibia.market.marketWidgetClasses
{
    import tibia.appearances.*;

    public interface ITypeComponent
    {

        public function ITypeComponent();

        function set selectedType(param1) : void;

        function get selectedType() : AppearanceType;

    }
}
