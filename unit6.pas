unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, inifiles, md5, Windows, unit1, unit2;

const
  UM_CHECKFIRSTRUN = WM_USER + 100;

type

  { TExitingForm }

  TExitingForm = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
    procedure UmCheckFirstRun(var Message: TMessage); message UM_CHECKFIRSTRUN;
  public
    { public declarations }
  end;

var
  ExitingForm: TExitingForm;
  firstexit: boolean;

implementation

{$R *.lfm}

{ TExitingForm }

procedure TExitingForm.FormCreate(Sender: TObject);
begin
  firstexit := True;
  PostMessage(Handle, UM_CHECKFIRSTRUN, 0, 0);
end;

procedure TExitingForm.FormShow(Sender: TObject);
begin

end;

procedure TExitingform.UmCheckFirstRun(var Message: TMessage);
begin
  if firstexit then
  begin
    label1.Caption := '保存设置……';
    if savewindowsize then
    begin
      settings.WriteInteger('window', 'top', Form1.top);
      settings.WriteInteger('window', 'left', Form1.left);
      settings.WriteInteger('window', 'width', Form1.Width);
      settings.WriteInteger('window', 'height', Form1.Height);
      settings.WriteInteger('window', 'WindowState', integer(Form1.WindowState));
    end;
    progressbar1.position := 20;
    settings.WriteString('paths', 'namespath', namespath);
    settings.WriteBool('font', 'whethersave', savefontsetting);
    settings.WriteBool('animate', 'whethersave', saveanimatesetting);
    settings.WriteBool('window', 'whethersave', savewindowsize);
    settings.WriteBool('hash', 'whetherhash', whetherhash);
    settings.WriteBool('hash', 'encrypthash', encrypthash);
    progressbar1.position := 40;
    if savefontsetting then
    begin
      settings.writeinteger('font', 'size', form1.fontdialog1.Font.Size);
      settings.writeinteger('font', 'color', form1.fontdialog1.Font.color);
      settings.writestring('font', 'fontname', form1.fontdialog1.Font.Name);
    end;
    progressbar1.position := 60;
    if saveanimatesetting then
    begin
      settings.WriteBool('animate', 'switch', animate);
 { settings.WriteInteger('advanced','animte.animteduration',animateduration);
  settings.WriteInteger('advanced','animate.rollnumbermin',rollnumbermin);
  settings.WriteInteger('advanced','animate.animateintervalmin',animateintervalmin);}
      settings.WriteInteger('animate', 'rollnumber', rollnumber);
      settings.WriteInteger('animate', 'animateinterval', animateinterval);
    end;
    progressbar1.position := 80;
    if (whetherhash xor encrypthash) and whetherhash then
    begin
      label1.Caption := '保存hash……';
      settings.WriteString('hash', 'namesmd5', nameshash);
    end;
    if encrypthash then
    begin
      label1.Caption := '加密hash……';
      settings.writeinteger('hash', 'encryptkey', encryptkey);
      hashencryptlength := 0;
      nameshash := MD5Print(MD5File(namespath));
      for i := 1 to length(nameshash) do
      begin
        str(i, s);
        s := 'e' + s;
        //showmessage(s);
        settings.writeinteger('hash', s, Ord(nameshash[i]) xor encryptkey);
        hashencryptlength := hashencryptlength + 1;
      end;
      settings.writeinteger('hash', 'hashencryptlength', hashencryptlength);
    end;
    label1.Caption := '保存设置……';
    settings.WriteString('password', 'md5', passwordmd5);
    progressbar1.position := 100;
    label1.Caption := '完成！……';
    names.Destroy;
    settings.Destroy;
    application.Terminate;
  end;
end;

end.
