package tibia.appearances.widgetClasses
{
    import tibia.appearances.*;

    public interface ISpriteProvider
    {

        public function ISpriteProvider();

        function getSprite(param1:uint, param2:CachedSpriteInformation = null, param3:AppearanceType = null) : CachedSpriteInformation;

    }
}
