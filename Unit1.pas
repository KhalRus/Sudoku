unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls;

type
  TForm1 = class(TForm)
    sgData: TStringGrid;
    bRun: TButton;
    edFile: TEdit;
    bSave: TButton;
    bLoad: TButton;
    bCheck: TButton;
    procedure sgDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure bRunClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
    procedure bLoadClick(Sender: TObject);
    procedure sgDataExit(Sender: TObject);
    procedure bCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}
const
  coor : array [1..9, 1..2] of integer = ((1, 1), (1, 4), (1, 7),
                                          (4, 1), (4, 4), (4, 7),
                                          (7, 1), (7, 4), (7, 7));
var
  data : array [1..9, 1..9, 0..9] of integer;
  redrw : boolean;

procedure TForm1.sgDataDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  k, n : integer;
  s, s1, s2, s3 : string;
begin
  With sgData.Canvas do
  begin
    Pen.Width := 2;
    MoveTo(197, 0);
    LineTo(197, 591);
    MoveTo(395, 0);
    LineTo(395, 591);
    MoveTo(0, 197);
    LineTo(591, 197);
    MoveTo(0, 395);
    LineTo(591, 395);
    if (sgData.Cells[aCol, aRow] <> '') or redrw then
    begin
      Brush.Color := clWhite;
      FillRect(Rect);
    end;

    if sgData.Cells[aCol, aRow] <> '' then
    begin
      Font.Color := clBlack;
      k := Round((64 - TextWidth(sgData.Cells[aCol, aRow])) / 2);
      TextOut(Rect.Left + k, Rect.Top, sgData.Cells[aCol, aRow]);
    end
    else
      if redrw then
      begin
        Font.Color := clAqua;
        if data[aRow + 1, aCol + 1, 0] = 1 then
        begin
          n := 0;
          for k := 1 to 9 do
            if data[aRow + 1, aCol + 1, k] <> 0 then
              n := data[aRow + 1, aCol + 1, k];
          s := IntToStr(n);
          k := Round((64 - TextWidth(s)) / 2);
          TextOut(Rect.Left + k, Rect.Top, s);
        end
        else
        begin
          s := '';
          Font.Size := 14;
          for k := 1 to 9 do
            if data[aRow + 1, aCol + 1, k] <> 0 then
              s := s + IntToStr(data[aRow + 1, aCol + 1, k]) + ' ';
          n := Length(s) - 1;
          s := Copy(s, 1, n);
          if n < 6 then
            TextOut(Rect.Left + 11, Rect.Top + 1, s)
          else
            if n < 12 then
            begin
              s1 := Copy(s, 1, 5);
              s2 := Copy(s, 7, n - 6);
              TextOut(Rect.Left + 11, Rect.Top +  1, s1);
              TextOut(Rect.Left + 11, Rect.Top + 21, s2);
            end
            else
            begin
              s1 := Copy(s, 1, 5);
              s2 := Copy(s, 7, 5);
              s3 := Copy(s, 13, n - 12);
              TextOut(Rect.Left + 11, Rect.Top +  1, s1);
              TextOut(Rect.Left + 11, Rect.Top + 21, s2);
              TextOut(Rect.Left + 11, Rect.Top + 41, s3);
            end;
        end;
      end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  redrw := false;
end;

procedure TForm1.bRunClick(Sender: TObject);
var
  i, j, k, c, r, n, l, c1, c2, r1, r2, l1, l2, r3, c3, m : integer;
  chd, f : boolean;
  num : array [1..9, 1..2] of integer;
begin
  if redrw then
  begin
    redrw := false;
    Form1.sgData.Repaint;
  end;

  chd := true;
  while chd do
  begin
  // ----------- проверка по одному полю ------------------
    chd := false;
    for i := 1 to 9 do
    begin
      // проверка по i-ой строке
      for c := 1 to 9 do
        for j := 1 to 9 do
          if (c <> j) and (data[i, c, 0] > 1) and (data[i, j, 0] = 1) then
          begin
            n := 0;
            for k := 1 to 9 do
              if data[i, j, k] <> 0 then
                n := data[i, j, k];

            for k := 1 to 9 do
              if data[i, c, k] = n then
              begin
                chd := true;
                data[i, c, k] := 0;
                data[i, c, 0] := data[i, c, 0] - 1;
              end;
          end;
      // проверка по i-му столбцу
      for r := 1 to 9 do
        for j := 1 to 9 do
          if (r <> j) and (data[r, i, 0] > 1) and (data[j, i, 0] = 1) then
          begin
            n := 0;
            for k := 1 to 9 do
              if data[j, i, k] <> 0 then
                n := data[j, i, k];

            for k := 1 to 9 do
              if data[r, i, k] = n then
              begin
                chd := true;
                data[r, i, k] := 0;
                data[r, i, 0] := data[r, i, 0] - 1;
              end;
          end;
      // проверка по i-му квадрату
      for l := 0 to 8 do
        for j := 0 to 8 do
          if (l <> j) then
          begin
            r1 := coor[i, 1] + l div 3;
            r2 := coor[i, 1] + j div 3;
            c1 := coor[i, 2] + l mod 3;
            c2 := coor[i, 2] + j mod 3;
            if (data[r1, c1, 0] > 1) and (data[r2, c2, 0] = 1) then
            begin
              n := 0;
              for k := 1 to 9 do
                if data[r2, c2, k] <> 0 then
                  n := data[r2, c2, k];

              for k := 1 to 9 do
                if data[r1, c1, k] = n then
                begin
                  chd := true;
                  data[r1, c1, k] := 0;
                  data[r1, c1, 0] := data[r1, c1, 0] - 1;
                end;
              end;
          end;
    end;

  // ----------- проверка по двум полям ------------------
    for i := 1 to 9 do
    begin
      // проверка по i-ой строке
      for c := 1 to 8 do
        for j := c + 1 to 9 do
          if (data[i, c, 0] = 2) and (data[i, j, 0] = 2) then
          begin
            f := true;
            l1 := 0;
            l2 := 0;
            for k := 1 to 9 do
            begin
              if data[i, c, k] <> data[i, j, k] then
                f := false;
              if data[i, c, k] <> 0 then
                if l1 = 0 then
                  l1 := data[i, c, k]
                else
                  l2 := data[i, c, k];
            end;

            if f then
              for k := 1 to 9 do
                if (k <> c) and (k <> j) and (data[i, k, 0] > 1) then
                  for l := 1 to 9 do
                    if (data[i, k, l] = l1) or (data[i, k, l] = l2) then
                    begin
                      chd := true;
                      data[i, k, l] := 0;
                      data[i, k, 0] := data[i, k, 0] - 1;
                    end;
          end;
      // проверка по i-му столбцу
      for r := 1 to 8 do
        for j := r + 1 to 9 do
          if (data[r, i, 0] = 2) and (data[j, i, 0] = 2) then
          begin
            f := true;
            l1 := 0;
            l2 := 0;
            for k := 1 to 9 do
            begin
              if data[r, i, k] <> data[j, i, k] then
                f := false;
              if data[r, i, k] <> 0 then
                if l1 = 0 then
                  l1 := data[r, i, k]
                else
                  l2 := data[r, i, k];
            end;

            if f then
              for k := 1 to 9 do
                if (k <> r) and (k <> j) and (data[k, i, 0] > 1) then
                  for l := 1 to 9 do
                    if (data[k, i, l] = l1) or (data[k, i, l] = l2) then
                    begin
                      chd := true;
                      data[k, i, l] := 0;
                      data[k, i, 0] := data[k, i, 0] - 1;
                    end;
          end;
      // проверка по i-му квадрату
      for l := 0 to 7 do
        for j := l + 1 to 8 do
        begin
          r1 := coor[i, 1] + l div 3;
          r2 := coor[i, 1] + j div 3;
          c1 := coor[i, 2] + l mod 3;
          c2 := coor[i, 2] + j mod 3;
          if (data[r1, c1, 0] = 2) and (data[r2, c2, 0] = 2) then
          begin
            f := true;
            l1 := 0;
            l2 := 0;
            for k := 1 to 9 do
            begin
              if data[r1, c1, k] <> data[r2, c2, k] then
                f := false;
              if data[r1, c1, k] <> 0 then
                if l1 = 0 then
                  l1 := data[r1, c1, k]
                else
                  l2 := data[r1, c1, k];
            end;

            if f then
              for k := 0 to 8 do
                if (k <> l) and (k <> j) then
                begin
                  r3 := coor[i, 1] + k div 3;
                  c3 := coor[i, 2] + k mod 3;
                  if data[r3, c3, 0] > 1 then
                    for m := 1 to 9 do
                      if (data[r3, c3, m] = l1) or (data[r3, c3, m] = l2) then
                      begin
                        chd := true;
                        data[r3, c3, m] := 0;
                        data[r3, c3, 0] := data[r3, c3, 0] - 1;
                      end;
                end;
            end;
        end;
    end;
(*
  // ----------- проверка по одному варианту ------------------
    for i := 1 to 9 do
    begin
      // проверка по i-ой строке
      for k := 1 to 9 do
        num[k, 1] := 0;
      for c := 1 to 9 do
        if data[i, c, 0] > 1 then
          for k := 1 to 9 do
            if data[i, c, k] <> 0 then
            begin
              num[data[i, c, k], 1] := num[data[i, c, k], 1] + 1;
              num[data[i, c, k], 2] := c;
            end;
      for k := 1 to 9 do
        if num[k, 1] = 1 then
        begin
          for l := 1 to 9 do
            data[i, num[k, 2], l] := 0;
          data[i, num[k, 2], 0] := 1;
          data[i, num[k, 2], k] := k;
          chd := true;
        end;
      // проверка по i-му столбцу
      for k := 1 to 9 do
        num[k, 1] := 0;
      for r := 1 to 9 do
        if data[r, i, 0] > 1 then
          for k := 1 to 9 do
            if data[r, i, k] <> 0 then
            begin
              num[data[r, i, k], 1] := num[data[r, i, k], 1] + 1;
              num[data[r, i, k], 2] := r;
            end;
      for k := 1 to 9 do
        if num[k, 1] = 1 then
        begin
          for l := 1 to 9 do
            data[num[k, 2], i, l] := 0;
          data[num[k, 2], i, 0] := 1;
          data[num[k, 2], i, k] := k;
          chd := true;
        end;
      // проверка по i-му квадрату
    end;
*)
  end;
  redrw := true;
  Form1.sgData.Repaint;
end;

procedure TForm1.bSaveClick(Sender: TObject);
var
  i, j, l, k : integer;
  ft : TextFile;
begin
  AssignFile(ft, edFile.Text);
  Rewrite(ft);
  for i := 1 to 9 do
    for j := 1 to 9 do
      if data[i, j, 0] = 1 then
      begin
        k := 0;
        for l := 1 to 9 do
          if data[i, j, l] <> 0 then
            k := data[i, j, l];
        Write(ft, IntToStr(k));
      end
      else
        Write(ft, '0');
  CloseFile(ft);
  MessageDlg('Данные благополучно сохранены!', mtInformation, [mbOK], 1);
end;

procedure TForm1.bLoadClick(Sender: TObject);
var
  i, j : integer;
  ft : TextFile;
  s : char;
begin
  AssignFile(ft, edFile.Text);
  If not FileExists(edFile.Text) then
  begin
    MessageDlg('Файл не найден!!!', mtError, [mbOK], 1);
    Exit;
  end;
  Reset(ft);
  for i := 0 to 8 do
    for j := 0 to 8 do
    begin
      Read(ft, s);
      if s = '0' then
        sgData.Cells[j, i] := ''
      else
        sgData.Cells[j, i] := s;
    end;
  CloseFile(ft);
  redrw := false;
  Form1.sgDataExit(bLoad);
  Form1.sgData.Repaint;
end;

procedure TForm1.sgDataExit(Sender: TObject);
var
  i, c, r : integer;
begin
  // обнуление массива и считывание из формы
  for c := 1 to 9 do
    for r := 1 to 9 do
      for i := 0 to 9 do
        data[r, c, i] := 0;
  for c := 0 to 8 do
    for r := 0 to 8 do
      if sgData.Cells[c, r] <> '' then
      begin
        data[r + 1, c + 1, 0] := 1;
        data[r + 1, c + 1, StrToInt(sgData.Cells[c, r])] := StrToInt(sgData.Cells[c, r]);
      end
      else
      begin
        data[r + 1, c + 1, 0] := 9;
        for i := 1 to 9 do
          data[r + 1, c + 1, i] := i;
      end;
end;

procedure TForm1.bCheckClick(Sender: TObject);
var
  i, j, k, n, r, c : integer;
  s : string;
  dd : array [1..9] of integer;
begin
  s := '';
  n := 0;
  for i := 1 to 9 do
  begin
    // проверка по i-й строке
    for j := 1 to 9 do
      dd[j] := 0;
    for j := 1 to 9 do
      if data[i, j, 0] = 1 then
      begin
        for k := 1 to 9 do
          if data[i, j, k] <> 0 then
            n := data[i, j, k];
        dd[n] := dd[n] + 1;
      end;
    for j := 1 to 9 do
      if dd[j] > 1 then
        s := s + 'Ошибка в ' + IntToStr(i) + ' строке. Цифра ' + IntToStr(j) + chr(13);

    // проверка по i-му столбцу
    for j := 1 to 9 do
      dd[j] := 0;
    for j := 1 to 9 do
      if data[j, i, 0] = 1 then
      begin
        for k := 1 to 9 do
          if data[j, i, k] <> 0 then
            n := data[j, i, k];
        dd[n] := dd[n] + 1;
      end;
    for j := 1 to 9 do
      if dd[j] > 1 then
        s := s + 'Ошибка в ' + IntToStr(i) + ' столбце. Цифра ' + IntToStr(j) + chr(13);

    // проверка по i-му квадрату
    for j := 1 to 9 do
      dd[j] := 0;
    for j := 0 to 8 do
    begin
      r := coor[i, 1] + j div 3;
      c := coor[i, 2] + j mod 3;
      if data[r, c, 0] = 1 then
      begin
        for k := 1 to 9 do
          if data[r, c, k] <> 0 then
            n := data[r, c, k];
        dd[n] := dd[n] + 1;
      end;
    end;
    for j := 1 to 9 do
      if dd[j] > 1 then
        s := s + 'Ошибка в ' + IntToStr(i) + ' квадрате. Цифра ' + IntToStr(j) + chr(13);
  end;
  if s <> '' then
    MessageDlg('Найдены проблемы!!!' + chr(13) + chr(13) + s, mtWarning, [mbOK], 1)
  else
    MessageDlg('Ошибок не найдено!', mtInformation, [mbOK], 1);
end;

end.
