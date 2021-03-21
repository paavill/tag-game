Unit WorkWithMainArrays;
  Interface
    Uses Types;
    var 
      namb,chislo:ArrayMainCoord;
      coord:Coords;
    Procedure tru_comb_array(var ArrMain:ArrayMainCoord);//исключение повторений
    Function SolvableComb(var ArrChislo:ArrayMainCoord; var ArrNamb:ArrayMainCoord):boolean;//проверка на разрешмость
    procedure UpDateChislo(var chislo:ArrayMainCoord; var namb:ArrayMainCoord);//Обновления массива
    Function GameReady(var chislo:ArrayMainCoord; var namb:ArrayMainCoord):boolean;//Подготовка игровой сесии
    procedure points(var coord:Coords);//Заполнение массива координат
    
  Implementation
    //процедура проверяющаяя на отсутчтвие повторяющихся цифр//
    Procedure tru_comb_array;
      var chp,chk:integer;
      begin
          chp:=1;
        while (chp<>0) do
          begin
            chk:=0;
            for var g:=0 to 14 do
              for var k:=0 to 14 do
                if (ArrMain[g]=ArrMain[k]) then
                  if (g<>k) then
                    begin
                      ArrMain[k]:=random(15);
                      chk:=chk+1;
                    end;
            if chk<>0 then
              chp:=1
            else
              chp:=0;
          end;
      end;
   //проверяет решабильность данной комбинации на поле//
   Function SolvableComb:boolean;
    var x,n1,n:integer;
    begin
      for var i:=0 to 14 do
        begin
          x:=-1;
          repeat
            x:=x+1;
          until ArrNamb[x]=i;
          ArrChislo[i]:=x;
        end;  
      n1:=0;
       for var i:=0 to 14 do
        begin
          n:=0;
        for var k:=i to 14 do
         begin
           if (ArrChislo[i]>ArrChislo[k]) then
              n:=n+1;
         end;
        n1:=n1+n;
       end;
      n1:=n1+4;
      if (n1 mod 2)<>0 then
        SolvableComb := false
      else
        SolvableComb := true;  
    end;
    procedure UpDateChislo;
    var x:integer;
    begin
      for var i:=0 to 15 do
        begin
          x:=-1;
          repeat
            x:=x+1;
          until namb[x]=i;
          chislo[i]:=x;
        end;  
    end;
    Function GameReady:boolean;
      begin
        repeat  //Провека на неразрешимость//
          for var i:=0 to 14 do
            namb[i]:=random(15);
          tru_comb_array(namb);
        until SolvableComb(chislo,namb);
        GameReady:=True;
      end;
    procedure points;
    var valx:integer;
    begin
      valx:=82;
      for var i:=0 to 3 do
        for var k:=0 to 3 do
           coord[i*4+k].x:=46+k*valx;
      for var i:=0 to 3 do
        for var k:=0 to 3 do
           coord[k+4*i].y:=124+i*valx;      
    end;    
Begin
namb[15]:=15;
chislo[15]:=15;  
End.