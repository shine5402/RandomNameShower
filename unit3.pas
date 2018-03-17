unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, shellapi;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label1: TLabel;
    Label2: TLabel;
    fileVersion: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
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

procedure TAboutForm.Memo1Change(Sender: TObject);
begin

end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin

end;

procedure TAboutForm.Image2Click(Sender: TObject);
begin
  shellexecute(handle, 'open', 'https://www.gnu.org/licenses/gpl.html', nil, nil, 1);
end;

procedure TAboutForm.Image3Click(Sender: TObject);
begin
  shellexecute(handle, 'open', 'https://github.com/shine5402/RandomNameShower',
    nil, nil, 1);
end;

procedure TAboutForm.Image4Click(Sender: TObject);
begin
  shellexecute(handle, 'open', 'https://github.com/shine5402/RandomNameShower',
    nil, nil, 1);
end;

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  AboutForm.Hide;
end;

procedure TAboutForm.Button2Click(Sender: TObject);
begin
  shellexecute(handle, 'open', 'https://github.com/shine5402/RandomNameShower/releases',
    nil, nil, 1);
end;

end.
