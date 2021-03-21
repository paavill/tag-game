Unit Types;
  Interface
    Uses GraphABC;
    Const
     users=100;
    Type
      CusCoord=array[0..3] of integer;//тип координат курсора
      ArrayMainCoord = array[0..15] of integer;//тип основных массивов
      WinTableResScore=array[0..users] of integer;//тип результатов за предыдущие игры
      WinTableResName=array[0..users] of string;//тип имен игроков,результаты которых в Score
      FieldNumbers=array[0..15] of picture;//тип  изображений
      TypForArrCoord=record
        x:integer;
        y:integer;
      end;
      Coords=array[0..15] of TypForArrCoord;//тип координат основных массивов
Implementation
end.