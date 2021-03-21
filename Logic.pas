Unit Logic;
  Interface
    Uses Types,WorkWithMainArrays;
    Procedure CheckTheWin(var ArrChislo:ArrayMainCoord;var id:integer);//Проверка комбинации
    procedure ifsKoursMove(var quadrat:CusCoord;var kours1:integer;var kours2:integer);//условия движения курсора
    procedure quadrat_assign(var quadrat:CusCoord;kours1:integer;kours2:integer);//присвоение новых координат курсору
    function PosDefine(quadrat:CusCoord;coord:Coords):integer;//определение позиции
    procedure MovePictureUp(posi:integer;move:integer;var grab:boolean;var steps:integer;var namb:ArrayMainCoord;var chislo:ArrayMainCoord);//функции перемещают ячейки в соответсвующих направлениях
    procedure MovePictureDown(posi:integer;move:integer;var grab:boolean;var steps:integer;var namb:ArrayMainCoord;var chislo:ArrayMainCoord);
    procedure MovePictureLeft(posi:integer;move:integer;var grab:boolean;var steps:integer;var namb:ArrayMainCoord;var chislo:ArrayMainCoord);
    procedure MovePictureRight(posi:integer;move:integer;var grab:boolean;var steps:integer;var namb:ArrayMainCoord;var chislo:ArrayMainCoord);
  Implementation
    //Если комбинация числел победная,меняет "уровень" программы//
    Procedure  CheckTheWin;
    var i,kontrol:integer;
      begin
        for i:=0 to 15 do
          begin
            if ArrChislo[i]=i then
              kontrol:=kontrol+1;
            if kontrol=16 then
              id:=3;
          end;
      end;
    //Условия движения курсора
    procedure ifsKoursMove;
    begin
      if quadrat[0]<46 then
        begin
          kours1:=0;
          quadrat[0]:=46;
          quadrat[1]:=128;
        end
      else if quadrat[0]>292 then
        begin
          kours1:=246;
          quadrat[0]:=292;
          quadrat[1]:=374;
        end;
      if quadrat[2]<124 then
        begin
          kours2:=0;
          quadrat[2]:=124;
          quadrat[3]:=206;
        end
      else if quadrat[2]>370 then
        begin
          kours2:=246;
          quadrat[2]:=370;
          quadrat[3]:=452;
        end;  
    end;
    procedure quadrat_assign;
    begin
      quadrat[0]:=kours1+46;
      quadrat[1]:=kours1+128;
      quadrat[2]:=kours2+124;
      quadrat[3]:=kours2+206;
    end;
    function PosDefine:integer;
    begin
      for var i:=0 to 15 do
        if (quadrat[0]=coord[i].x) and (quadrat[2]=coord[i].y) then
          PosDefine:=i;        
    end;
    Procedure MovePictureDown;
      var pct,pct1:integer;
      begin
        if (posi+4)<=15 then  
            begin
              pct:=chislo[posi];
              pct1:=chislo[posi+4];
              if pct1=15 then
                begin  
                  namb[pct1]:=posi;
                  namb[pct]:=posi+4;
                  steps:=steps+1;
                  UpDateChislo(chislo,namb);
                  //grab:=false;
                end
            end;
      end;
    Procedure MovePictureUp;
      var pct,pct1:integer;
      begin
        if (posi-4)>=0 then
            begin
              pct:=chislo[posi];
              pct1:=chislo[posi-4];
              if pct1=15 then
                begin      
                  namb[pct1]:=posi;
                  namb[pct]:=posi-4;
                  steps:=steps+1;
                  UpDateChislo(chislo,namb);
                  //grab:=false;
                end;
            end;
      end;
    Procedure MovePictureLeft;
      var pct,pct1:integer;
      begin
        if (((posi-1)<>3) and ((posi-1)<>7) and ((posi-1)<>11) and ((posi-1)>=0)) then
            begin
              pct:=chislo[posi];
              pct1:=chislo[posi-1];
              if pct1=15 then
                begin
                  namb[pct1]:=posi;
                  namb[pct]:=posi-1;
                  steps:=steps+1;
                  UpDateChislo(chislo,namb);
                  //grab:=false;
                end;
            end;
      end;
    Procedure MovePictureRight;
      var pct,pct1:integer;
      begin
       if (((posi+1)<>4) and ((posi+1)<>8) and ((posi+12)<>11) and ((posi+1)<=15)) then  
          begin
            pct:=chislo[posi];
            pct1:=chislo[posi+1];
            if pct1=15 then
              begin
                namb[pct1]:=posi;
                namb[pct]:=posi+1;
                steps:=steps+1;
                UpDateChislo(chislo,namb);
                //grab:=false;
              end;
          end;
      end;      
  end.