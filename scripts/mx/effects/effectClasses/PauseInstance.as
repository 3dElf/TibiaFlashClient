package mx.effects.effectClasses
{

    public class PauseInstance extends TweenEffectInstance
    {
        static const VERSION:String = "3.6.0.21751";

        public function PauseInstance(param1:Object)
        {
            super(param1);
            return;
        }// end function

        override public function play() : void
        {
            super.play();
            tween = createTween(this, 0, 0, duration);
            return;
        }// end function

    }
}
