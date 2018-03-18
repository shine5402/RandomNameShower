unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Menus, ExtCtrls, unit3, IniFiles;

type

  { TMainForm }

  TMainForm = class(TForm)
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
  MainForm: TMainForm;
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

{ TMainForm }
procedure TMainForm.givenames(newnames : TStrings);
begin
  names.Assign(newnames);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if savewindowsize then
  begin
    MainForm.SetBounds(settings.ReadInteger('window', 'left', 169),
      settings.ReadInteger('window', 'top', 491), settings.ReadInteger(
      'window', 'width', 339), settings.ReadInteger('window', 'height', 274));

    MainForm.WindowState := TWindowState(settings.ReadInteger(
      'window', 'WindowState', integer(wsNormal)));
  end;
end;

procedure TMainForm.MenuItem3Click(Sender: TObject);
begin
  if fontdialog1.Execute then
    label1.Font := fontdialog1.Font;
end;

procedure TMainForm.MenuItem4Click(Sender: TObject);
begin
 AboutForm := TAboutForm.Create(Application);//动态创建窗体
  try
    AboutForm.ShowModal;//显示模式窗体
  finally
    AboutForm.Free; //释放窗体实例
    //ShowMessage(BoolToStr(ModalForm = nil));
    AboutForm := nil; //把窗体变量设为nil
    //ShowMessage(BoolToStr(ModalForm = nil));
  end;
 // aboutform.Show;
end;

procedure TMainForm.MenuItem5Click(Sender: TObject);
begin
  animate := not animate;
  MenuItem5.Checked := animate;
end;

procedure TMainForm.MenuItem6Click(Sender: TObject);
begin

end;

procedure TMainForm.MenuItem7Click(Sender: TObject);
begin
  OptionForm := TOptionForm.Create(Application);//动态创建窗体
  try
    OptionForm.ShowModal;//显示模式窗体
  finally
    OptionForm.Free; //释放窗体实例
    //ShowMessage(BoolToStr(ModalForm = nil));
    OptionForm := nil; //把窗体变量设为nil
    //ShowMessage(BoolToStr(ModalForm = nil));
  end;
  //OptionForm.Show;
end;

procedure TMainForm.MenuItem8Click(Sender: TObject);
begin
  Label1.Caption := '';
end;

procedure TMainForm.Timer1StartTimer(Sender: TObject);
begin
  k := 0;
  timer1.interval := animateinterval;
end;

procedure TMainForm.Timer1StopTimer(Sender: TObject);
begin
  k := 0;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
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

procedure TMainForm.Button1Click(Sender: TObject);
begin
     {i:=names.count;
  j:=random(i);
  Label1.Caption:=names.Strings[j];
  }
  if i <> 0 then begin
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
end else begin
  showmessage('名字列表为空。请检查您的名单文件是否正确。然后重启本程序或打开选项窗口后点击“确定”来促使程序刷新名单。');
  end;
end;
procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Exitingform := Texitingform.Create(Application);
  exitingform.Show;
end;



end.
