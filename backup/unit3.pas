unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses Unit1,Unit2;

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
if form1.MySQL57Connection1.Connected=true then
  begin
    form1.SQLQuery1.Close;
    form1.SQLQuery1.SQL.Clear;
    form1.SQLQuery1.SQL.Add('insert into members (memberid,firstname,lastname) values (null,:fname,:lname);');

    form1.SQLQuery1.params.parambyname('fname').asstring := edit1.text;
    form1.SQLQuery1.params.parambyname('lname').asstring := edit2.text ;

    form1.SQLQuery1.ExecSQL;
    form1.SQLTransaction1.Commit;
  end
else
   ShowMessage('соединение потеряно');
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.Close;
  Form1.Show;
  Form1.Enabled:=true;
end;

end.

