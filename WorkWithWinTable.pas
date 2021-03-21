unit WorkWithWinTable;
  Interface
    Uses Types;
    var
      Names:WinTableResName;
      Scores:WinTableResScore;
      stat:text;
    Procedure ParseLine(var line:string;var Name:WinTableResName;var Score:WinTableResScore;k:integer);//Парсинг строки
    Procedure TopSort(var Name:WinTableResName;var Score:WinTableResScore;g:integer);//Сортировка от мал. к большему
    Procedure AddUserToTopList(var Names:WinTableResName;var Scores:WinTableResScore;g:integer;steps:integer;name:string);//Добавляет результаты пользователя
    Procedure UpDateStatFile(var grab:boolean;var Names:WinTableResName;var Scores:WinTableResScore;id:integer;steps:integer;name:string);//Считывает и обновляет данные файла статистики после игры.
    Procedure AddStatFile(var stat:text);//Добавляет файл статистики в папку с игрой, если файл отсутвует.
   
  Implementation
  //Считывание строки из файла
  Procedure ParseLine;
  var i,err:integer;
      Colon:boolean;
      Scr:string;
   begin
     i:=1;
     Colon:=False;
     Scr:='';
     Name[k]:='';
     Score[k]:=0;
      while(i<=Length(line))do
        begin
          if(Ord(line[i])=58)then
            Colon:=True;
          if Colon=False then
            Name[k]:=Name[k]+line[i]
          else
            if Ord(line[i])<>58 then
              begin
                Scr := Scr+line[i];
                val(Scr,Score[k],err);
              end;
          i:=i+1;
        end;
    end;
  //Сортировка массивов результатов
  Procedure TopSort;
  var i,k,AddVar:integer;
  AddVarStr:string;
  begin
    AddVar:=0;
    AddVarStr:='';
    for i:=0 to g-1 do
      for k:=0 to g-2-i do
        begin
          if Score[k]>Score[k+1] then
            begin
              AddVar:=Score[k];
              Score[k]:=Score[k+1];
              Score[k+1]:=AddVar;
              AddVarStr:=Name[k];
              Name[k]:=Name[k+1];
              Name[k+1]:=AddVarStr;
            end;
        end;
  end;
  //Добавление результатов пользователя в массива
  Procedure AddUserToTopList;
  begin
    if g-1=users then
      begin
        Scores[users]:=steps;
        Names[users]:=name;
      end
    else
      begin
        Scores[g]:=steps;
        Names[g]:=name;
      end;
  end;
  
  procedure UpDateStatFile;
  var lineP:string;
      i,k:integer;
      stat:text;
  begin
    if (grab=false) then
      begin
       Assign(stat,'stat.txt');
       i:=0;
       Reset(stat);
       while((not(EOF(stat))) and (i<=users))do
        begin
          readln(stat,lineP);
          ParseLine(lineP,Names,Scores,i);
          i:=i+1;
        end;
        Close(stat);
        TopSort(Names,Scores,i);
        if id=3 then
          begin
            AddUserToTopList(Names,Scores,i,steps,name);
            if i-1=users then
              i:=i-1;  
            TopSort(Names,Scores,i+1);
            Rewrite(stat);
            for k:=0 to i do
              writeln(stat,Names[k]+':'+Scores[k]);
            close(stat);
          end;  
        grab:=true;
      end;
  end;
  procedure AddStatFile;
    begin
       stat:=OpenWrite('stat.txt');
       Close(stat);      
    end;
End.