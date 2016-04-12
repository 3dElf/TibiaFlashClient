package 
{
    import flash.net.*;
    import mx.collections.*;
    import mx.core.*;
    import mx.effects.*;
    import mx.graphics.*;
    import mx.styles.*;
    import mx.utils.*;

    public class _Tibia_FlexInit extends Object
    {

        public function _Tibia_FlexInit()
        {
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            var fbs:* = param1;
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("addedEffect", "added");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("completeEffect", "complete");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("creationCompleteEffect", "creationComplete");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("focusInEffect", "focusIn");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("focusOutEffect", "focusOut");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("hideEffect", "hide");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("itemsChangeEffect", "itemsChange");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("mouseDownEffect", "mouseDown");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("mouseUpEffect", "mouseUp");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("moveEffect", "move");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("removedEffect", "removed");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("resizeEffect", "resize");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("rollOutEffect", "rollOut");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("rollOverEffect", "rollOver");
            var _loc_3:* = EffectManager;
            _loc_3.mx_internal::registerEffectTrigger("showEffect", "show");
            try
            {
                if (getClassByAlias("flex.messaging.io.ArrayCollection") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayCollection", ArrayCollection);
                try
                {
                }
                if (getClassByAlias("flex.messaging.io.ArrayList") == null)
                {
                    registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ArrayList", ArrayList);
                try
                {
                }
                if (getClassByAlias("flex.graphics.ImageSnapshot") == null)
                {
                    registerClassAlias("flex.graphics.ImageSnapshot", ImageSnapshot);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.graphics.ImageSnapshot", ImageSnapshot);
                try
                {
                }
                if (getClassByAlias("flex.messaging.io.ObjectProxy") == null)
                {
                    registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
                }
            }
            catch (e:Error)
            {
                registerClassAlias("flex.messaging.io.ObjectProxy", ObjectProxy);
            }
            var styleNames:Array;
            var i:int;
            while (i < styleNames.length)
            {
                
                StyleManager.registerInheritingStyle(styleNames[i]);
                i = (i + 1);
            }
            return;
        }// end function

    }
}
