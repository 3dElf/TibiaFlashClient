package tibia.input.gameaction
{
    import mx.resources.*;
    import tibia.creatures.*;
    import tibia.game.*;
    import tibia.input.*;
    import tibia.magic.*;
    import tibia.network.*;

    public class SpellAction extends Object implements IAction
    {
        private var m_Spell:Spell = null;
        private var m_Parameter:String = null;
        private var m_LastPerform:Number = 0;
        static const OPTIONS_MAX_COMPATIBLE_VERSION:Number = 5;
        private static const BUNDLE:String = "StaticAction";
        static const OPTIONS_MIN_COMPATIBLE_VERSION:Number = 2;

        public function SpellAction(param1, param2:String)
        {
            this.m_Spell = null;
            if (param1 is Spell)
            {
                this.m_Spell = Spell(param1);
            }
            else if (param1 is int)
            {
                this.m_Spell = SpellStorage.getSpell(int(param1));
            }
            if (this.m_Spell == null)
            {
                throw new ArgumentError("SpellAction.SpellAction: Invalid spell: " + param1);
            }
            this.m_Parameter = param2;
            if (this.m_Parameter != null)
            {
                this.m_Parameter = this.m_Parameter.replace(/(^\s+|\s+$)/, "");
            }
            return;
        }// end function

        public function perform(param1:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = Tibia.s_GetPlayer();
            if (_loc_2 == null || _loc_2.getSpellCasts(this.m_Spell) < 0)
            {
                return;
            }
            var _loc_3:* = Tibia.s_GetConnection();
            var _loc_4:* = Tibia.s_GetSpellStorage();
            if (param1 && _loc_3 != null && _loc_4 != null)
            {
                if (this.m_LastPerform + SpellStorage.MIN_SPELL_DELAY / 2 > Tibia.s_FrameTibiaTimestamp)
                {
                    return;
                }
                _loc_5 = _loc_4.getSpellDelay(this.m_Spell.ID);
                if (_loc_5 != null && _loc_5.end - _loc_3.latency > Tibia.s_FrameTibiaTimestamp)
                {
                    return;
                }
            }
            this.m_Spell.cast(null, this.m_Parameter);
            this.m_LastPerform = Tibia.s_FrameTibiaTimestamp;
            return;
        }// end function

        public function clone() : IAction
        {
            return new SpellAction(this.m_Spell, this.m_Parameter);
        }// end function

        public function equals(param1:IAction) : Boolean
        {
            return param1 is SpellAction && SpellAction(param1).m_Spell == this.m_Spell && SpellAction(param1).m_Parameter == this.m_Parameter;
        }// end function

        public function get spell() : Spell
        {
            return this.m_Spell;
        }// end function

        public function get parameter() : String
        {
            return this.m_Parameter;
        }// end function

        public function get hidden() : Boolean
        {
            return true;
        }// end function

        public function marshall() : XML
        {
            var _loc_1:* = new XML("<action type=\"spell\" spell=\"" + this.m_Spell.ID + "\"/>");
            if (this.m_Parameter != null && this.m_Parameter.length > 0)
            {
                _loc_1.@parameter = this.m_Parameter;
            }
            return _loc_1;
        }// end function

        public function toString() : String
        {
            var _loc_1:* = ResourceManager.getInstance();
            return _loc_1.getString(BUNDLE, "GAME_SPELL", [this.m_Spell.name]);
        }// end function

        public static function s_Unmarshall(param1:XML, param2:Number) : SpellAction
        {
            if (param1 == null || param1.localName() != "action" || param2 < OPTIONS_MIN_COMPATIBLE_VERSION || param2 > OPTIONS_MAX_COMPATIBLE_VERSION)
            {
                throw new Error("SpellAction.s_Unmarshall: Invalid input.");
            }
            var _loc_3:* = null;
            var _loc_6:* = param1.@type;
            _loc_3 = param1.@type;
            if (_loc_6 == null || _loc_3.length() != 1 || _loc_3[0].toString() != "spell")
            {
                return null;
            }
            var _loc_4:* = -1;
            var _loc_6:* = param1.@spell;
            _loc_3 = param1.@spell;
            if (_loc_6 != null && _loc_3.length() == 1)
            {
                _loc_4 = parseInt(_loc_3[0].toString());
            }
            var _loc_5:* = null;
            var _loc_6:* = param1.@parameter;
            _loc_3 = param1.@parameter;
            if (_loc_6 != null && _loc_3.length() == 1)
            {
                _loc_5 = _loc_3[0].toString();
            }
            else
            {
                var _loc_6:* = param1.text();
                _loc_3 = param1.text();
                if (_loc_6 != null && _loc_3.length() == 1)
                {
                    _loc_5 = _loc_3[0].toString();
                }
            }
            if (SpellStorage.checkSpell(_loc_4))
            {
                return new SpellAction(_loc_4, _loc_5);
            }
            return null;
        }// end function

    }
}
