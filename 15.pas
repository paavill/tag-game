{Курсовая работа.
 Цель: создать игру Пятнашки (или "15")
 Программа: Пятшнашки
 Программист: Чистяков П.А
 Проверил: Антипов О.В
 Дата написания: 11.05.2020
 Группа: 9413}
 
 {$apptype windows} 

program game_15;
uses GraphABC,Types,WorkWithMainArrays,Logic,WorkWithWinTable,UI,Control;
begin
SetWindowIsFixedSize(true);
SetWindowSize(419,500);
points(coord);
PictureLoad(pict);
OnKeyDown:=KeyDownControl;
OnKeyUp:=KeyUp;
SetWindowCaption('15');
isGame:=true;
while isGame do
begin
if not(GR) then
  GR:=GameReady(chislo,namb);//Состояние готовности игровой сессии
  MainUIDraw(id,name,kours1,kours2,grab,steps,quadrat,coord,namb,Names,Scores);//Орисовка графики
  //Игра//
  if id=0 then//Меню
    begin 
      if ((kours2=0) and (grab=true)) then//Обработка нажатия на кнопку Играть
        begin
          id:=1;
          kours2:=0;//Обнуление координаты курсора по Y
        end;
      if ((kours2=60) and (grab=true)) then//Обработка нажатия на кнопку Рекорды
        begin
          id:=4;
          kours2:=0;//Обнуление координаты курсора по Y
        end;
      if ((kours2=120) and (grab=true)) then//Обработка нажатия на кнопку Справка
        begin
          id:=5;
          kours2:=0;
        end;
      if ((kours2=180) and (grab=true)) then//Обработка нажатия на кнопку Выход  
        id:=-1;
        grab:=false;  
    end;
  if id=1 then//Ввод имени
   begin
    if grab=true then//Обработка ввода
      begin
        id:=2;
        grab:=false;
        if name='' then
          name:='RenamedUser';
      end;
   end;
  if id=2 then//Игровой процесс
   begin  
   if grab=true then //Срабатывает если включен захват ячейки
      begin
        if picture_move=1 then //При ключенном захвате попытка (при нажатии на клавишу движения) сдвинуть ячейку 
          begin
            case move of             
              2:MovePictureDown(PosDefine(quadrat,coord),move,grab,steps,namb,chislo);//При определенных условиях сдвигает ячейку
              1:MovePictureUp(PosDefine(quadrat,coord),move,grab,steps,namb,chislo);  
              4:MovePictureRight(PosDefine(quadrat,coord),move,grab,steps,namb,chislo);
              3:MovePictureLeft(PosDefine(quadrat,coord),move,grab,steps,namb,chislo);              
            end; 
            picture_move:=0;
            CheckTheWin(chislo,id);//Проверка на соответсвие текущей комбинации победной
          end
        else
          begin
            quadrat_assign(quadrat,kours1,kours2);//Присвоение курсору (красному квадрату новых координат)
            ifsKoursMove(quadrat,kours1,kours2);//Ограничения на движение курсора
          end;
      end
   else
    begin
      quadrat_assign(quadrat,kours1,kours2);
      ifsKoursMove(quadrat,kours1,kours2);
    end;
 end;
  if (id=3) or (id=4) then//Победная таблица рекордов
   if FileExists('stat.txt')=true then//Проверка существования файла статистики
     begin
        UpDateStatFile(grab,Names,Scores,id,steps,name);//Обновление файла статистики 
     end
  else
     begin
        AddStatFile(stat);//Создание файла статистики
     end;
 end;
 CloseWindow();
end.