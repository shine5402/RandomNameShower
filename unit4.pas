unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls,md5;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation
uses unit2;
{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  if md5print(md5string(edit1.Text))=passwordmd5 then begin
     passwordmd5:=md5print(md5string(edit2.Text));
     form3.Close;
  end else showmessage('密码错误，请重试。')
end;

end.

