unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, MaskEdit,
  ComCtrls, ExtDlgs;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CalendarDialog1: TCalendarDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    UpDown1: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MaskEdit2Change(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses unit1,Unit3;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
form1.SQLQuery1.Close;
form1.SQLQuery1.SQL.Clear;
form1.SQLQuery1.SQL.Add('insert into books (bookid,title,author,published,stock) values (null,:title,:author,:data,:stk);');

form1.SQLQuery1.params.parambyname('title').asstring := edit1.text;
form1.SQLQuery1.params.parambyname('author').asstring := edit2.text ;
form1.SQLQuery1.params.parambyname('data').AsString := maskedit1.text;
form1.SQLQuery1.params.parambyname('stk').AsInteger := strtoint(maskedit2.text);

form1.SQLQuery1.ExecSQL;
form1.SQLTransaction1.Commit;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form1.Enabled:=true;
  Form1.Show;
  Form2.Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
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
          maskedit1.text:=FormatDateTime( 'yyyy-mm-dd',dt );
        end
      else
        ShowMessage( 'Today is '+FormatDateTime( 'yyyy-mm-dd',dt ));
    end
  else
      ShowMessage('соединение потеряно');
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.MaskEdit2Change(Sender: TObject);
begin

end;

end.

