unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, inifiles, md5, Windows, unit1, unit2, unit7;

const
  UM_CHECKFIRSTRUN = WM_USER + 100;

type

  { TLoadingForm }

  TLoadingForm = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ProgressBar1Exit(Sender: TObject);

  private
    { private declarations }
    procedure UmCheckFirstRun(var Message: TMessage); message UM_CHECKFIRSTRUN;
    procedure DoThings();
        procedure DoThings_fffdone();
  public
    { public declarations }
    procedure firstrunformdone();
  end;



var
  LoadingForm: TLoadingForm;
  firstrun, allfirstrun, fffdone: boolean;

implementation
 uses unit4;
{$R *.lfm}
{ TLoadingForm }
procedure TLoadingForm.firstrunformdone();
begin
  fffdone:= true;
  firstrun := True;
  allfirstrun := false;
  Dothings_fffdone();
end;

procedure TLoadingForm.FormCreate(Sender: TObject);
begin
  firstrun := True;
  PostMessage(Handle, UM_CHECKFIRSTRUN, 0, 0);
end;

procedure TLoadingForm.FormShow(Sender: TObject);
begin

end;

procedure TLoadingForm.DoThings();
begin

  if firstrun then
  begin
    loadingform.label1.Caption := '程序启动……';
    loadingform.label1.Caption := '重置管理员开关';
    rootenabled := False;
    progressbar1.position := 6;
    loadingform.label1.Caption := '打开设置文件';
    settingspath := './settings.ini';

    if not (fileexists(settingspath)) and not(fffdone) then
    begin
      //showmessage('找不到设置文件（settings.ini），如果您是第一次使用本程序，或者自己删除了这个文件，那么可以不用在意这个警告。但是，如果您认为自己没有进行过删除操作，这可能代表着有人想要通过删除设置文件来绕过防暗箱设置等机制，请检查名单文件是否被篡改后继续。');
      firstrunform := TfirstRunForm.Create(Application);
      firstrunform.Show;
      allfirstrun := True;
    end;
    if not (allfirstrun) then
    begin
      settings := Tinifile.Create(settingspath);
      progressbar1.position := 13;
      loadingform.label1.Caption := '读取名单文件路径';
      namespath := settings.readstring('paths', 'namespath', './names.txt');
      if not (fileexists(namespath)) then
      begin
        ShowMessage('找不到名单文件，程序无法运作，即将退出。');
        application.Terminate;
      end;
      progressbar1.position := 20;
      loadingform.label1.Caption := '读取密码';
      passwordmd5 := settings.readstring('password', 'md5',
        '25d55ad283aa400af464c76d713c07ad');
      if passwordmd5 = '25d55ad283aa400af464c76d713c07ad' then
        ShowMessage('您的管理员密码目前为初始密码（12345678）。请进入选项进行修改。');
      progressbar1.position := 26;
      loadingform.label1.Caption := '读取字体保存布尔值';
      savefontsetting := settings.ReadBool('font', 'whethersave', True);
      progressbar1.position := 33;
      loadingform.label1.Caption := '读取动画保存布尔值';
      saveanimatesetting := settings.ReadBool('animate', 'whethersave', True);
      progressbar1.position := 40;
      loadingform.label1.Caption := '读取窗口保存布尔值';
      savewindowsize := settings.ReadBool('window', 'whethersave', False);
      progressbar1.position := 47;
      loadingform.label1.Caption := '读取防暗箱布尔值';
      whetherhash := settings.readbool('hash', 'whetherhash', False);
      encrypthash := settings.readbool('hash', 'encrypthash', False);
      progressbar1.position := 54;
      loadingform.label1.Caption := '读取名单文件';
      names := TStringList.Create;
      names.LoadFromFile(namespath);
      progressbar1.position := 60;
      loadingform.label1.Caption := '读取动画设置';
      if saveanimatesetting then
      begin
        animate := settings.ReadBool('animate', 'switch', False);
        rollnumber := settings.readinteger('animate', 'rollnumber', 30);
        animateinterval := settings.readinteger('animate', 'animateinterval', 50);
        form1.MenuItem5.Checked := animate;
      end;
      progressbar1.position := 67;
      loadingform.label1.Caption := '读取字体设置';
      if savefontsetting then
      begin
        form1.fontdialog1.Font.Size := settings.ReadInteger('font', 'size', 18);
        form1.fontdialog1.Font.color := settings.readinteger('font', 'color', clDefault);
        form1.fontdialog1.Font.Name := settings.Readstring('font', 'fontname', '微软雅黑');
        form1.label1.Font := form1.fontdialog1.Font;
      end;
      progressbar1.position := 74;
      loadingform.label1.Caption := '校验文件Hash值，如果卡顿超过3分钟，请退出重试……';
      if encrypthash then
      begin
        nameshash := MD5Print(MD5File(namespath));
        nameslasthash := '';
        encryptkey := settings.readinteger('hash', 'encryptkey', 1234);
        hashencryptlength := settings.readinteger('hash', 'hashencryptlength', 0);
        for i := 1 to hashencryptlength do
        begin
          str(i, s);
          s := 'e' + s;
          j := settings.readinteger('hash', s, 0) xor encryptkey;
          nameslasthash := nameslasthash + chr(j);
        end;
        if nameshash <> nameslasthash then
        begin
          ShowMessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
      end;
      if (whetherhash xor encrypthash) and whetherhash then
      begin
        nameslasthash := settings.readstring('hash', 'namesmd5', '');
        if nameslasthash = '' then
        begin
          ShowMessage('没有找到上一次的名单Hash记录，settings.ini中的记录可能被删除，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
        nameshash := MD5Print(MD5File(namespath));
        if nameshash <> nameslasthash then
        begin
          ShowMessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
      end;
      progressbar1.position := 80;
      loadingform.label1.Caption := '初始化变量';
      i := names.Count;
      k := 0;
      j := 0;
      randomize;
      progressbar1.position := 87;
      loadingform.label1.Caption := '启动完成！';
      progressbar1.position := 100;
      form1.Show;
    end;
    loadingform.hide;
  end;
end;
procedure TLoadingForm.DoThings_fffdone();
begin

  if firstrun then
  begin
    loadingform.label1.Caption := '程序启动……';
    loadingform.label1.Caption := '重置管理员开关并检查密码';
    rootenabled := False;
    if passwordmd5 = '' then Form3.passwdmd5('25d55ad283aa400af464c76d713c07ad');
    progressbar1.position := 6;
    begin
      loadingform.label1.Caption := '建立设置文件对象';
      settingspath := './settings.ini';
       settings := Tinifile.Create(settingspath);
      progressbar1.position := 13;
      loadingform.label1.Caption := '重设名单文本路径';
      namespath :='./names.txt';
      progressbar1.position := 26;
      loadingform.label1.Caption := '重设字体保存布尔值';
      savefontsetting := True;
      progressbar1.position := 33;
      loadingform.label1.Caption := '重设动画保存布尔值';
      saveanimatesetting := True;
      progressbar1.position := 40;
      loadingform.label1.Caption := '重设窗口保存布尔值';
      savewindowsize :=  False;
      progressbar1.position := 47;
      loadingform.label1.Caption := '重设防暗箱相关值';
      whetherhash := False;
      encrypthash := False;
      encryptkey := 1234;
      progressbar1.position := 54;
      loadingform.label1.Caption := '读取名单文件';
      names := TStringList.Create;
      names.LoadFromFile(namespath);
      progressbar1.position := 60;
      loadingform.label1.Caption := '重设动画设置';
        animate := False;
        rollnumber :=  30;
        animateinterval := 50;
        form1.MenuItem5.Checked := animate;
      progressbar1.position := 67;
      loadingform.label1.Caption := '重设字体设置';
        form1.fontdialog1.Font.Size := 18;
        form1.fontdialog1.Font.color := clDefault;
        form1.fontdialog1.Font.Name := '微软雅黑';
        form1.label1.Font := form1.fontdialog1.Font;
      progressbar1.position := 74;
      loadingform.label1.Caption := '校验文件Hash值，如果卡顿超过3分钟，请退出重试……';
      if encrypthash then
      begin
        nameshash := MD5Print(MD5File(namespath));
        nameslasthash := '';
        encryptkey := 1234;
        hashencryptlength := 0;
        for i := 1 to hashencryptlength do
        begin
          str(i, s);
          s := 'e' + s;
          j := settings.readinteger('hash', s, 0) xor encryptkey;
          nameslasthash := nameslasthash + chr(j);
        end;
        if nameshash <> nameslasthash then
        begin
          ShowMessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
      end;
      if (whetherhash xor encrypthash) and whetherhash then
      begin
        nameslasthash := settings.readstring('hash', 'namesmd5', '');
        if nameslasthash = '' then
        begin
          ShowMessage('没有找到上一次的名单Hash记录，settings.ini中的记录可能被删除，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
        nameshash := MD5Print(MD5File(namespath));
        if nameshash <> nameslasthash then
        begin
          ShowMessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
          application.Terminate;
        end;
      end;
      progressbar1.position := 80;
      loadingform.label1.Caption := '初始化变量';
      i := names.Count;
      k := 0;
      j := 0;
      randomize;
      progressbar1.position := 87;
      loadingform.label1.Caption := '启动完成！';
      progressbar1.position := 100;
      form1.Show;
    end;
    loadingform.hide;
  end;
end;
procedure TLoadingform.UmCheckFirstRun(var Message: TMessage);
begin
  DoThings();
end;

procedure TLoadingForm.ProgressBar1Exit(Sender: TObject);
begin

end;

procedure TLoadingForm.FormActivate(Sender: TObject);
begin

end;

end.
