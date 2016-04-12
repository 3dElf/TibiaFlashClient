package tibia.ingameshop.shopWidgetClasses
{
    import tibia.ingameshop.*;

    public interface IIngameShopWidgetComponent
    {

        public function IIngameShopWidgetComponent();

        function set shopWidget(param1:IngameShopWidget) : void;

        function dispose() : void;

    }
}
