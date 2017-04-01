unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.Label2Click(Sender: TObject);
begin

end;

procedure TAboutForm.Label3Click(Sender: TObject);
begin

end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin

end;

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  AboutForm.Hide;
end;

end.

