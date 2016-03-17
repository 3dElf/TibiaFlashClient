package shared.utility
{
   public class Colour
   {
      
      public static const HSI_SI_VALUES:int = 7;
      
      public static const HSI_H_STEPS:int = 19;
       
      protected var m_Green:uint = 0;
      
      protected var m_Blue:uint = 0;
      
      protected var m_Red:uint = 0;
      
      protected var m_Alpha:uint = 0;
      
      public function Colour(param1:int, param2:int, param3:int, param4:int = 255)
      {
         super();
         this.red = param1;
         this.green = param2;
         this.blue = param3;
         this.alpha = param4;
      }
      
      public static function s_FromHSI(param1:int) : Colour
      {
         var _loc8_:int = 0;
         if(param1 >= HSI_H_STEPS * HSI_SI_VALUES)
         {
            param1 = 0;
         }
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         if(param1 % HSI_H_STEPS == 0)
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = 1 - param1 / HSI_H_STEPS / HSI_SI_VALUES;
         }
         else
         {
            _loc2_ = param1 % HSI_H_STEPS * (1 / 18);
            _loc3_ = 1;
            _loc4_ = 1;
            switch(int(param1 / HSI_H_STEPS))
            {
               case 0:
                  _loc3_ = 0.25;
                  _loc4_ = 1;
                  break;
               case 1:
                  _loc3_ = 0.25;
                  _loc4_ = 0.75;
                  break;
               case 2:
                  _loc3_ = 0.5;
                  _loc4_ = 0.75;
                  break;
               case 3:
                  _loc3_ = 0.667;
                  _loc4_ = 0.75;
                  break;
               case 4:
                  _loc3_ = 1;
                  _loc4_ = 1;
                  break;
               case 5:
                  _loc3_ = 1;
                  _loc4_ = 0.75;
                  break;
               case 6:
                  _loc3_ = 1;
                  _loc4_ = 0.5;
            }
         }
         if(_loc4_ == 0)
         {
            return new Colour(0,0,0);
         }
         if(_loc3_ == 0)
         {
            _loc8_ = int(_loc4_ * 255);
            return new Colour(_loc8_,_loc8_,_loc8_);
         }
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         if(_loc2_ < 1 / 6)
         {
            _loc5_ = _loc4_;
            _loc7_ = _loc4_ * (1 - _loc3_);
            _loc6_ = _loc7_ + (_loc4_ - _loc7_) * 6 * _loc2_;
         }
         else if(_loc2_ < 2 / 6)
         {
            _loc6_ = _loc4_;
            _loc7_ = _loc4_ * (1 - _loc3_);
            _loc5_ = _loc6_ - (_loc4_ - _loc7_) * (6 * _loc2_ - 1);
         }
         else if(_loc2_ < 3 / 6)
         {
            _loc6_ = _loc4_;
            _loc5_ = _loc4_ * (1 - _loc3_);
            _loc7_ = _loc5_ + (_loc4_ - _loc5_) * (6 * _loc2_ - 2);
         }
         else if(_loc2_ < 4 / 6)
         {
            _loc7_ = _loc4_;
            _loc5_ = _loc4_ * (1 - _loc3_);
            _loc6_ = _loc7_ - (_loc4_ - _loc5_) * (6 * _loc2_ - 3);
         }
         else if(_loc2_ < 5 / 6)
         {
            _loc7_ = _loc4_;
            _loc6_ = _loc4_ * (1 - _loc3_);
            _loc5_ = _loc6_ + (_loc4_ - _loc6_) * (6 * _loc2_ - 4);
         }
         else
         {
            _loc5_ = _loc4_;
            _loc6_ = _loc4_ * (1 - _loc3_);
            _loc7_ = _loc5_ - (_loc4_ - _loc6_) * (6 * _loc2_ - 5);
         }
         return new Colour(int(_loc5_ * 255),int(_loc6_ * 255),int(_loc7_ * 255));
      }
      
      public static function s_FromARGB(param1:int) : Colour
      {
         var _loc2_:* = param1 >> 24 & 255;
         var _loc3_:* = param1 >> 16 & 255;
         var _loc4_:* = param1 >> 8 & 255;
         var _loc5_:* = param1 & 255;
         return new Colour(_loc3_,_loc4_,_loc5_,_loc2_);
      }
      
      public static function s_FromEightBit(param1:int) : Colour
      {
         if(param1 < 0 || param1 >= 216)
         {
            return new Colour(0,0,0);
         }
         var _loc2_:int = int(param1 / 36) % 6 * 51;
         var _loc3_:int = int(param1 / 6) % 6 * 51;
         var _loc4_:int = param1 % 6 * 51;
         return new Colour(_loc2_,_loc3_,_loc4_);
      }
      
      public function get green() : int
      {
         return this.m_Green & 255;
      }
      
      public function mul(param1:int, param2:Boolean = true) : Colour
      {
         var _loc3_:int = this.m_Red * param1;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         var _loc4_:int = this.m_Green * param1;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         var _loc5_:int = this.m_Blue * param1;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         var _loc6_:int = this.m_Alpha;
         if(param2)
         {
            _loc6_ = this.m_Alpha * param1;
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
         }
         return new Colour(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public function set green(param1:int) : void
      {
         if(param1 < 0 || param1 > 255)
         {
            throw new ArgumentError("Colour.set green: Invalid value: " + param1);
         }
         this.m_Green = param1;
      }
      
      public function divFloat(param1:Number, param2:Boolean = true) : Colour
      {
         if(param1 == 0)
         {
            throw new ArgumentError("Colour.divideFloat: Invalid colour.");
         }
         var _loc3_:int = int(this.m_Red / param1 + 0.5);
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         var _loc4_:int = int(this.m_Green / param1 + 0.5);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         var _loc5_:int = int(this.m_Blue / param1 + 0.5);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         var _loc6_:int = this.m_Alpha;
         if(param2)
         {
            _loc6_ = int(this.m_Alpha / param1 + 0.5);
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
         }
         return new Colour(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public function get ARGB() : int
      {
         return this.m_Alpha << 24 | this.m_Red << 16 | this.m_Green << 8 | this.m_Blue;
      }
      
      public function div(param1:int, param2:Boolean = true) : Colour
      {
         if(param1 == 0)
         {
            throw new ArgumentError("Colour.divide: Division by 0.");
         }
         var _loc3_:int = this.m_Red / param1;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         var _loc4_:int = this.m_Green / param1;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         var _loc5_:int = this.m_Blue / param1;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         var _loc6_:int = this.m_Alpha;
         if(param2)
         {
            _loc6_ = this.m_Alpha / param1;
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
         }
         return new Colour(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public function get blue() : int
      {
         return this.m_Blue & 255;
      }
      
      public function get alpha() : int
      {
         return this.m_Alpha & 255;
      }
      
      public function get red() : int
      {
         return this.m_Red & 255;
      }
      
      public function add(param1:Colour, param2:Boolean = true) : Colour
      {
         var _loc3_:int = this.m_Red + param1.m_Red;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         var _loc4_:int = this.m_Green + param1.m_Green;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         var _loc5_:int = this.m_Blue + param1.m_Blue;
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         var _loc6_:int = this.m_Alpha;
         if(param2)
         {
            _loc6_ = this.m_Alpha + param1.m_Alpha;
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
         }
         return new Colour(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public function set red(param1:int) : void
      {
         if(param1 < 0 || param1 > 255)
         {
            throw new ArgumentError("Colour.set red: Invalid value: " + param1);
         }
         this.m_Red = param1;
      }
      
      public function get RGB() : int
      {
         return this.m_Red << 16 | this.m_Green << 8 | this.m_Blue;
      }
      
      public function set blue(param1:int) : void
      {
         if(param1 < 0 || param1 > 255)
         {
            throw new ArgumentError("Colour.set blue: Invalid value: " + param1);
         }
         this.m_Blue = param1;
      }
      
      public function mulFloat(param1:Number, param2:Boolean = true) : Colour
      {
         var _loc3_:int = int(this.m_Red * param1 + 0.5);
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         var _loc4_:int = int(this.m_Green * param1 + 0.5);
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_loc4_ > 255)
         {
            _loc4_ = 255;
         }
         var _loc5_:int = int(this.m_Blue * param1 + 0.5);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         if(_loc5_ > 255)
         {
            _loc5_ = 255;
         }
         var _loc6_:int = this.m_Alpha;
         if(param2)
         {
            _loc6_ = int(this.m_Alpha * param1 + 0.5);
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
         }
         return new Colour(_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public function toString() : String
      {
         return (this.m_Red << 24 | this.m_Green << 16 | this.m_Blue << 8 | this.m_Alpha).toString();
      }
      
      public function set alpha(param1:int) : void
      {
         if(param1 < 0 || param1 > 255)
         {
            throw new ArgumentError("Colour.set alpha: Invalid value: " + param1);
         }
         this.m_Alpha = param1;
      }
      
      public function get eightBit() : int
      {
         return this.red / 51 * 36 + this.green / 51 * 6 + this.blue / 51;
      }
   }
}
