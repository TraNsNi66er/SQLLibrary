unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql57conn, sqldb, db, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    MySQL57Connection1: TMySQL57Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
 uses Unit2, unit3, Unit4, Unit5 ;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  MySQL57Connection1.Connected:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
edit1.enabled:=true;
edit2.enabled:=true;
SQLQuery1.Close;
SQLQuery1.SQL.Clear;
SQLQuery1.SQL.Add('Select title as "Название", author as "Автор", published as "Дата издания", stock as "Количество"  from books;');
SQLQuery1.Open;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
SQLQuery1.Close;
SQLQuery1.SQL.Clear;
SQLQuery1.SQL.Add('Select firstname as "Имя", lastname as "Фамилия" from members;');
SQLQuery1.Open;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
SQLQuery1.Close;
SQLQuery1.SQL.Clear;
SQLQuery1.SQL.Add('SELECT members.firstname AS "Имя", members.lastname AS "Фамилия", books.title AS "Название", borrowings.borrowdate AS "Дата выдачи",borrowings.returndate AS "Дата возврата",borrowings.returned AS "Возврат" FROM borrowings JOIN books ON borrowings.bookid=books.bookid JOIN members ON members.memberid=borrowings.memberid WHERE borrowings.returned=0' );
SQLQuery1.Open;
end;

procedure TForm1.Button5Click(Sender: TObject);  //добавить книгу
begin
  Form2.Show;
  Form1.Show;
  Form1.Enabled:=false;
end;

procedure TForm1.Button6Click(Sender: TObject);   //добавить пользователя
begin
  Form3.Show;
  Form1.Enabled:=false;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form4.Show;
  Form1.Enabled:=false;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  Form5.Show;
  Form1.Enabled:=false;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

  SQLQuery1.Close;
  SQLQuery1.SQL.Clear;
  if ((sender as TEdit).Name = 'Edit2') then
     begin
       SQLQuery1.SQL.Add('Select title as "Название", author as "Автор", published as "Дата издания", stock as "Количество"  from books WHERE author LIKE :authSearch;');
       SQLQuery1.params.parambyname('authSearch').asstring := edit2.Text + '%';
     end;
  if ((sender as TEdit).Name = 'Edit1') then
     begin
          SQLQuery1.SQL.Add('Select title as "Название", author as "Автор", published as "Дата издания", stock as "Количество"  from books WHERE title LIKE :titleSearch;');
          SQLQuery1.params.parambyname('titleSearch').asstring := edit1.Text+'%';
     end;
  SQLQuery1.Open;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MySQL57Connection1.Connected:=true;
  if (not MySQL57Connection1.Connected) then button1.Visible:=true;
end;

end.

