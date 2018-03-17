unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls, unit3, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    FontDialog1: TFontDialog;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);
    procedure Timer1StopTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    procedure givenames(newnames : TStrings);
  end;

var
  Form1: TForm1;
  names: TStringList;
  namespath, settingspath, nameshash, s, nameslasthash: string;
  rollnumber, k, i, j{,animateduration,animatetimes,animateintervalmin,rollnumbermin},
  encryptkey, hashencryptlength, animateinterval: integer;
  animate, savefontsetting, saveanimatesetting, savewindowsize,
  whetherhash, encrypthash: boolean;
  settings: tinifile;

implementation

uses unit2, unit6;

{$R *.lfm}

{ TForm1 }
procedure Tform1.givenames(newnames : TStrings);
begin
  names.Assign(newnames);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if savewindowsize then
  begin
    Form1.SetBounds(settings.ReadInteger('window', 'left', 169),
      settings.ReadInteger('window', 'top', 491), settings.ReadInteger(
      'window', 'width', 339), settings.ReadInteger('window', 'height', 274));

    Form1.WindowState := TWindowState(settings.ReadInteger(
      'window', 'WindowState', integer(wsNormal)));
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if fontdialog1.Execute then
    label1.Font := fontdialog1.Font;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  aboutform.Show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  animate := not animate;
  MenuItem5.Checked := animate;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  form2.Show;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Label1.Caption := '';
end;

procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
  k := 0;
  timer1.interval := animateinterval;
end;

procedure TForm1.Timer1StopTimer(Sender: TObject);
begin
  k := 0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  tmp: integer;
begin
  tmp := random(i);
  Label1.Caption := names.Strings[tmp];
  application.ProcessMessages;
  k := k + 1;
  if k > rollnumber then
  begin
    Label1.Caption := names.Strings[j];
    timer1.Enabled := False;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     {i:=names.count;
  j:=random(i);
  Label1.Caption:=names.Strings[j];
  }
  if animate then
  begin
    j := random(i);
    timer1.Enabled := True;
  end
  else
  begin
    j := random(i);
    Label1.Caption := names.Strings[j];
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Exitingform := Texitingform.Create(Application);
  exitingform.Show;
end;



end.
