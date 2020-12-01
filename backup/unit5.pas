unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private

  public

  end;

var
  Form5: TForm5;

implementation
uses unit1;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Close;
  Form1.Show;
  Form1.Enabled:=true;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  fam,book: string;
  memb_id,book_id:string;
begin
  fam:=listbox1.Items[listbox1.ItemIndex];
  book:=listbox2.Items[listbox2.ItemIndex];

  form5.listbox3.Clear;
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select memberid  from members WHERE lastname = :lname;');
  form1.SQLQuery1.params.parambyname('lname').asstring := fam;
  form1.SQLQuery1.Open;
  while not form1.SQLQuery1.EOF do
        begin
             form5.Listbox3.Items.Add(form1.SQLQuery1.FieldByName('memberid').AsString);
             form1.SQLQuery1.Next;
        end;

  //form5.listbox3.Clear;
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select bookid  from books WHERE title = :btitle;');
  form1.SQLQuery1.params.parambyname('btitle').asstring := book;
  form1.SQLQuery1.Open;
  while not form1.SQLQuery1.EOF do
        begin
             form5.Listbox3.Items.Add(form1.SQLQuery1.FieldByName('bookid').AsString);
             form1.SQLQuery1.Next;
        end;

  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('UPDATE borrowings SET returned=true WHERE memberid=:m_id and bookid=:b_id');
  ShowMessage('Книга принята!');
  form1.SQLQuery1.params.parambyname('m_id').asstring := ListBox3.Items[0];
  form1.SQLQuery1.params.parambyname('b_id').asstring := ListBox3.Items[1];

  form1.SQLQuery1.ExecSQL;
  form1.SQLTransaction1.Commit;



end;

procedure TForm5.Edit1Change(Sender: TObject);
begin
  listbox1.Clear;
  form5.listbox2.Clear;
  form1.SQLQuery1.Close;
  form1.SQLQuery1.SQL.Clear;
  form1.SQLQuery1.SQL.Add('Select firstname as "Имя", lastname as "Фамилия" from members WHERE lastname LIKE :lname;');
  form1.SQLQuery1.params.parambyname('lname').asstring := form5.edit1.Text+'%';
  form1.SQLQuery1.Open;
  while not form1.SQLQuery1.EOF do
        begin
             form5.Listbox1.Items.Add(form1.SQLQuery1.FieldByName('Фамилия').AsString);
             form1.SQLQuery1.Next;
        end;
end;

procedure TForm5.ListBox1SelectionChange(Sender: TObject; User: boolean);
var
  fam_selected:string;
begin
   listbox2.Clear;
   fam_selected:=listbox1.Items[listbox1.ItemIndex];

   form1.SQLQuery1.Close;
   form1.SQLQuery1.SQL.Clear;
   form1.SQLQuery1.SQL.Add('SELECT members.firstname AS "Имя", members.lastname AS "Фамилия", books.title AS "Название", borrowings.borrowdate AS "Дата выдачи",borrowings.returndate AS "Дата возврата" FROM borrowings JOIN books ON borrowings.bookid=books.bookid JOIN members ON members.memberid=borrowings.memberid WHERE members.lastname = :lname');
   form1.SQLQuery1.params.parambyname('lname').asstring := fam_selected;
   form1.SQLQuery1.Open;
     while not form1.SQLQuery1.EOF do
        begin
             form5.Listbox2.Items.Add(form1.SQLQuery1.FieldByName('Название').AsString);
             form1.SQLQuery1.Next;
        end;
end;

end.

