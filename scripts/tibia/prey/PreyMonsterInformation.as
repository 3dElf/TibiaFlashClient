package tibia.prey
{
    import shared.utility.*;
    import tibia.appearances.*;

    public class PreyMonsterInformation extends Object
    {
        private var m_MonsterAppearanceInstance:AppearanceInstance = null;
        private var m_MonsterName:String;

        public function PreyMonsterInformation(param1:String, param2:AppearanceInstance)
        {
            this.m_MonsterName = param1;
            this.m_MonsterAppearanceInstance = param2;
            return;
        }// end function

        public function get monsterName() : String
        {
            return StringHelper.s_Capitalise(this.m_MonsterName);
        }// end function

        public function get monsterAppearanceInstance() : AppearanceInstance
        {
            return this.m_MonsterAppearanceInstance;
        }// end function

        public function equals(param1:PreyMonsterInformation) : Boolean
        {
            return param1 != null && this.m_MonsterName == param1.m_MonsterName && (this.m_MonsterAppearanceInstance == param1.m_MonsterAppearanceInstance || this.m_MonsterAppearanceInstance != null && param1.m_MonsterAppearanceInstance != null && this.m_MonsterAppearanceInstance.ID == param1.m_MonsterAppearanceInstance.ID);
        }// end function

    }
}
