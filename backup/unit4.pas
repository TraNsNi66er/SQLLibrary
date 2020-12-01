unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtDlgs,
  DateUtils;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CalendarDialog1: TCalendarDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation
uses unit1;

{$R *.lfm}

{ TForm4 }

procedure TForm4.Edit1Change(Sender: TObject);
begin
  form4.listbox1.Clear;
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select title as "Название", author as "Автор", published as "Дата издания", stock as "Количество"  from books WHERE title LIKE :titleSearch;');
  form1.SQLQuery1.params.parambyname('titleSearch').asstring := form4.edit1.Text+'%';
  form1.SQLQuery1.Open;
  while not form1.SQLQuery1.EOF do
        begin
             form4.Listbox1.Items.Add(form1.SQLQuery1.FieldByName('Название').AsString);
             form1.SQLQuery1.Next;
        end;
end;

procedure TForm4.Button2Click(Sender: TObject);
var
  bookid:integer;
  memberid:integer;
begin
  if form1.MySQL57Connection1.Connected=true then
  begin
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select bookid from books WHERE title = :bookSearch;');
  form1.SQLQuery1.params.parambyname('bookSearch').asstring := ListBox1.Items[listbox1.ItemIndex];
  form1.SQLQuery1.Open;
  bookid:=form1.SQLQuery1.FieldByName('bookid').AsInteger;

  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select memberid from members WHERE lastname = :memberSearch;');
  form1.SQLQuery1.params.parambyname('memberSearch').asstring := ListBox2.Items[listbox2.ItemIndex];
  form1.SQLQuery1.Open;
  memberid:=form1.SQLQuery1.FieldByName('memberid').AsInteger;

  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('insert into borrowings (id,bookid,memberid,borrowdate,returndate) values (null,:book_id,:member_id,:give_date,:return_date);');

  form1.SQLQuery1.params.parambyname('book_id').AsInteger := bookid;
  form1.SQLQuery1.params.parambyname('member_id').AsInteger := memberid;
  form1.SQLQuery1.params.parambyname('give_date').AsString := edit3.text;
  form1.SQLQuery1.params.parambyname('return_date').AsString := edit4.text;


  form1.SQLQuery1.ExecSQL;
  form1.SQLTransaction1.Commit;
  end
  else
  ShowMessage('соединение потеряно');
end;

procedure TForm4.Button3Click(Sender: TObject);
  var
    dt:tdatetime;
begin
  if form1.MySQL57Connection1.Connected=true then
    begin
      dt:= now;
      CalendarDialog1.Date := dt;
      CalendarDialog1.Title:='Select a date';
      if CalendarDialog1.Execute then
        begin
          dt:= CalendarDialog1.Date;
          edit4.text:=FormatDateTime( 'yyyy-mm-dd',dt );
        end
      else
        ShowMessage( 'Today is '+FormatDateTime( 'yyyy-mm-dd',dt ));
    end
  else
      ShowMessage('соединение потеряно');
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  Form4.Close;
  Form1.Show;
  Form1.Enabled:=true;
end;

procedure TForm4.Edit2Change(Sender: TObject);
begin
  form4.listbox2.Clear;
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select firstname as "Имя", lastname as "Фамилия" from members WHERE lastname LIKE :lname;');
  form1.SQLQuery1.params.parambyname('lname').asstring := form4.edit2.Text+'%';
  form1.SQLQuery1.Open;
  while not form1.SQLQuery1.EOF do
        begin
             form4.Listbox2.Items.Add(form1.SQLQuery1.FieldByName('Фамилия').AsString);
             form1.SQLQuery1.Next;
        end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  edit3.text:= inttostr(YearOf(now))+'-'+inttostr(MonthOf(now))+'-'+inttostr(DayOf(now));
end;

end.

