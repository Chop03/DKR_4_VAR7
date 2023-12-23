program DKR4;
Uses GraphABC;
var 
  x1, x2 : integer;
  outT, outF, diff, zoom: real;
  c : byte;
const
  n = 1000000000;
  m = 20;

function integral: real;
begin
  integral:=((x2*x2*x2*x2)/4-(2*(x2*x2*x2))/3)-((x1*x1*x1*x1)/4-(2*(x1*x1*x1))/3);
end;

function f(x:real):real;begin f := x*x*x -2*x*x -4*x; end;
function f1(x, zoom:real):real;
begin
  f1 := 1/power(10, zoom)*x*x*x -
  1/power(10, zoom)*2*x*x -
  1/power(10, zoom)*4*x;
end;
function integral_graph(a, b, mode: integer; graph : boolean): real;
var
  h, s, x, s1 : real;
  y1, check: integer;
begin
  h := (b-a)/mode;
  x:=a;
  if graph = True then
  begin
    y1 := 400;
    check := 0;
    for x1:integer:= 300 to 1200 do
    begin
      line(x1, round(y1 - f1(x1-300, zoom)), x1 + 1, round(y1 - f1(x1-299, zoom)));
      if (x1 - 300 >= a) and (x1 - 300 <= b) then
      begin
        if (check mod round(h)) <> 0 then
        begin
          setpencolor(clmoneygreen);
          line(x1, y1, x1, round(y1 - 1 - f1(x1-298, zoom)));
          setpencolor(clblack);
        end;
        if (check mod round(h)) = 0 then
        begin
          setpencolor(clred);
          if check = round(h)*mode then
            line(x1, y1, x1, round(y1 + 1 - f1(x1-298, zoom)))
          else begin
            line(x1, y1, x1, round(y1 - 1 - f1(x1-300+round(h), zoom)));
            line(x1, round(y1 - 1 - f1(x1-300+round(h), zoom)), x1 + round(h), round(y1 - 1 - f1(x1-300+round(h), zoom)));
          end;
          setpencolor(clBlack);
        end;
        check:=check+1;
      end;
    end;
  end;
  if graph = False then
  begin
    for i:integer := 1 to mode - 1 do
    begin
      s1:=h*(1*(x*x*x)+(-2)*(x*x)+(-4)*x);
      s:=s+s1;
      x:=x+h;
    end;
    integral_graph := s;
  end;
end;


begin
  SetWindowWidth(1200);
  SetWindowHeight(600);
  c := 1;
  while True do
  begin
    textout(5, 10, 'Введите масштаб графика и функции (рекомендуется максимальный) : ');
    textout(5, 25, 'От 1 до 6');
    read(zoom);
    zoom:=round(zoom);
    if (zoom >= 1) and (zoom <= 6) then break;
    ClearWindow;
  end;
  repeat
    ClearWindow;   
    // область графика
    Line(300, 400, 300, 100);
    Line(300, 400, 1000, 400);
    Line(300, 100, 310, 110);
    Line(300, 100, 290, 110);
    Line(1000, 400, 990, 390);
    Line(1000, 400, 990, 410);
    
    textout(5, 10, 'Вычисление интеграла - 1');
    textout(5, 25, 'Выход - 0');
    textout(5, 40, 'Выберите программу: ');
    textout(280, 100, 'y');
    textout(990, 410, 'x');
    textout(295, 405, '0');
    readln(c);
    Case c of
    1:
    begin
      textout(5, 70, 'Введите пределы интегрирования: ');
      readln(x1, x2);
      textout(5, 90, 'Построение графика . . .');
      integral_graph(round(x1*power(10, (zoom - 1)*(1/zoom))),
      round(x2*power(10, (zoom - 1)*(1/zoom))), m, True);
      textout(5, 120, 'Идёт интегрирование . . . ');
      outT := integral();
      outF := integral_graph(x1, x2, m, False);
      diff := (outT - outF) / outF * 100;
      textout(5, 145, 'Результаты интегрирования: ');
      textout(5, 160, outF+' ед^2');
      textout(5, 180, 'Погрешность: ');
      textout(5, 195, abs(diff)+'%');
      textout(5, 230, 'Нажмите ENTER');
      readln;
    end;
    0:
    begin
      textout(5, 70, 'Выключение программы . . .');
      Sleep(300);
      Window.Close;
    end;
    end;
  until c = 0;
end.
