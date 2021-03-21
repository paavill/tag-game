{
  В модуле описаны процедуры и переменные управления игровым процессом, меню и вводом.
  Также в этом модуле описаны обработчики событий.
}
unit Control;
  Interface
    uses GraphABC,Types;
    var
      steps,picture_move,move,id,kours1,kours2:integer;//Кол-во шагов;Попытка передвижения ячейки;Направление движения;Номер уровня на котором работает программа;Координаты курсора.
      name:string;//Имя игрока
      quadrat:CusCoord;//Массив координат игрового (управляющего ячейками на поле) квадратного курсора
      grab,GR,isGame:boolean;//Переменная готовности игровой сессии и захвата
    Function IsLetter(key:integer):boolean;//Принадлежность вводимого символа к буквами
    Function IsNumber(key:integer):boolean;//К Цифрам
    procedure KeyDownControl(key:integer);//Обработчик нажатия клавиши
    procedure KeyUp(key:integer);//Обработчик поднятия клавиши 
  Implementation
 Function IsLetter:boolean;
  var i:integer;  
    begin
      i:=VK_A;
      while i<=VK_Z do
        if key<>i then
          i := i+1
        else
          i:=VK_Z+2;
        if i=VK_Z+2 then
          IsLetter := true
        else
          IsLetter := false;     
    end;
  Function IsNumber:boolean;
  var i:integer;
    begin
      i:=ord('0');
      while i<=ord('9') do
        if key<>i then
          i := i+1
        else
          i:=ord('9')+2;
        if i=ord('9')+2 then
          IsNumber := true
        else
          IsNumber := false;       
    end;
  procedure KeyDownControl;
  begin
    if id=0 then
      begin
        case key of
          VK_W, VK_UP: kours2:=kours2-60;
          VK_S, VK_DOWN: kours2:=kours2+60;
          VK_ESCAPE: id:=-1;
          VK_RETURN: grab:=true;  
        end;
        if kours2>180 then
          kours2:=0;
        if kours2<0 then
          kours2:=180;
      end
    else
      begin  
        if id=-1 then
          begin
            if key = VK_RETURN then
               isGame:=false;
            if key = VK_ESCAPE then
               id:=0;
          end;
        if id=1 then
        begin
          case key of
            VK_BACK: delete(name,length(name),1);
            VK_RETURN: grab:=true;
            VK_ESCAPE:begin
                        id:=0;
                        kours1:=0;
                        kours2:=0;
                        name:='';
                      end;
          else
            if (length(name)<11)and(IsLetter(key) or IsNumber(key)) then 
              name:=name+chr(key);
          end;
        end;
        
        if id=2 then
        begin
            case key of
              VK_W,VK_UP:begin
                    kours2:=kours2-82;
                    picture_move:=1;
                    move:=1;
                   end;
              VK_S,VK_DOWN:begin
                    kours2:=kours2+82;
                    picture_move:=1;
                    move:=2;
                   end;
              VK_A,VK_LEFT:begin
                    kours1:=kours1-82;
                    picture_move:=1;
                    move:=3;
                   end;        
              VK_D,VK_RIGHT:begin
                    kours1:=kours1+82;
                    picture_move:=1;
                    move:=4;
                   end;
              VK_RETURN: grab:=not(grab);
              VK_ESCAPE:begin
                    id:=0;
                    kours1:=0;
                    kours2:=0;
                    grab:=false;
                   end;        
            end;
         end;
      if (id=3) or (id=4) or(id=5) then
        begin
          if key=VK_ESCAPE then
            begin
              kours1:=0;
              GR:=false;
              case id of
                3: kours2:=0;
                4: kours2:=60;
                5: kours2:=120;
              end;
              id:=0;
              steps:=0;
              grab:=false;          
            end;
        end;
      end;
  end;
  procedure KeyUp;
  begin
    if id=2 then
    begin  
      case key of
        VK_W,VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT,VK_S,VK_A,VK_D:begin
                                                            picture_move:=0;
                                                            move:=0;
                                                           end;
      end;
    end;
  end;
  Begin
    GR:=False;//Начальное состояние игровой сессии
    steps:=0;//Нач.кол-во шагов
    kours1:=0;//Присвоение смещения курсору по X//
    kours2:=0;//Присвоение смещения курсору по y//      
    grab:=false;//Присвоение значения переменной захвата//
end.