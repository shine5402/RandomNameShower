unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls,inifiles,md5,windows,unit1,unit2;
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
  public
    { public declarations }
  end;

var
  LoadingForm: TLoadingForm;
  firstrun:boolean;
implementation
{$R *.lfm}

{ TLoadingForm }

procedure TLoadingForm.FormCreate(Sender: TObject);
begin
  firstrun:=true;
  PostMessage(Handle, UM_CHECKFIRSTRUN, 0, 0);
end;

procedure TLoadingForm.FormShow(Sender: TObject);
begin

end;
procedure TLoadingform.UmCheckFirstRun(var Message: TMessage);
begin
  if firstrun then begin
loadingform.label1.caption:='程序启动……';
loadingform.label1.caption:='重置管理员开关';
rootenabled:=false;
progressbar1.position:=6;
loadingform.label1.caption:='打开设置文件';
settingspath:='./settings.ini';
  if not(fileexists(settingspath)) then begin
  showmessage('找不到设置文件（settings.ini），如果您是第一次使用本程序，或者自己删除了这个文件，那么可以不用在意这个警告。但是，如果您认为自己没有进行过删除操作，这可能代表着有人想要通过删除设置文件来绕过防暗箱设置等机制，请检查名单文件是否被篡改后继续。');
  end;
settings:=Tinifile.create(settingspath);
progressbar1.position:=13;
loadingform.label1.caption:='读取名单文件路径';
namespath:=settings.readstring('paths','namespath','./names.txt');
if not(fileexists(namespath)) then begin
showmessage('找不到名单文件，程序无法运作，即将退出。');
application.Terminate;
end;
progressbar1.position:=20;
loadingform.label1.caption:='读取密码';
passwordmd5:=settings.readstring('password','md5','25d55ad283aa400af464c76d713c07ad');
if passwordmd5='25d55ad283aa400af464c76d713c07ad' then showmessage('您的管理员密码目前为初始密码（12345678）。请进入选项进行修改。');
progressbar1.position:=26;
loadingform.label1.caption:='读取字体保存布尔值';
savefontsetting:=settings.ReadBool('font','whethersave',true);
progressbar1.position:=33;
loadingform.label1.caption:='读取动画保存布尔值';
saveanimatesetting:=settings.ReadBool('animate','whethersave',true);
progressbar1.position:=40;
loadingform.label1.caption:='读取窗口保存布尔值';
savewindowsize:=settings.ReadBool('window','whethersave',false);
progressbar1.position:=47;
loadingform.label1.caption:='读取防暗箱布尔值';
whetherhash:=settings.readbool('hash','whetherhash',false);
encrypthash:=settings.readbool('hash','encrypthash',false);
progressbar1.position:=54;
loadingform.label1.caption:='读取名单文件';
names:=Tstringlist.Create;
names.LoadFromFile(namespath);
progressbar1.position:=60;
loadingform.label1.caption:='读取动画设置';
if saveanimatesetting then begin
animate:=settings.ReadBool('animate','switch',false);
rollnumber:=settings.readinteger('animate','rollnumber',30);
animateinterval:=settings.readinteger('animate','animateinterval',50);
form1.MenuItem5.Checked:=animate;
end;
progressbar1.position:=67;
loadingform.label1.caption:='读取字体设置';
if savefontsetting then begin
form1.fontdialog1.Font.Size:=settings.ReadInteger('font','size',18);
form1.fontdialog1.Font.color:=settings.readinteger('font','color',clDefault);
form1.fontdialog1.Font.name:=settings.Readstring('font','fontname','微软雅黑');
form1.label1.Font:=form1.fontdialog1.Font;
end;
progressbar1.position:=74;
loadingform.label1.caption:='校验文件Hash值，如果卡顿超过3分钟，请退出重试……';
if encrypthash then begin
nameshash:=MD5Print(MD5File(namespath));
nameslasthash:='';
encryptkey:=settings.readinteger('hash','encryptkey',1234);
hashencryptlength:=settings.readinteger('hash','hashencryptlength',0);
for i:= 1 to hashencryptlength do begin
  str(i,s);
  s:='e'+s;
  j:=settings.readinteger('hash',s,0) xor encryptkey;
  nameslasthash:=nameslasthash+chr(j);
end;
if nameshash <> nameslasthash then begin
showmessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
application.Terminate;
end;
end;
if (whetherhash xor encrypthash) and whetherhash then begin
nameslasthash:=settings.readstring('hash','namesmd5','');
if nameslasthash = '' then begin
showmessage('没有找到上一次的名单Hash记录，settings.ini中的记录可能被删除，建议检查名单文件有没有被篡改！程序即将退出。');
application.Terminate;
end;
nameshash:=MD5Print(MD5File(namespath));
if nameshash <> nameslasthash then begin
showmessage('名单文件的Hash记录与上一次记录的不符，建议检查名单文件有没有被篡改！程序即将退出。');
application.Terminate;
end;
end;
progressbar1.position:=80;
loadingform.label1.caption:='初始化变量';
  i:=names.count;
k:=0;
j:=0;
randomize;
progressbar1.position:=87;
loadingform.label1.caption:='启动完成！';
progressbar1.position:=100;
form1.show;
loadingform.hide;
end;
end;
procedure TLoadingForm.ProgressBar1Exit(Sender: TObject);
begin

end;

procedure TLoadingForm.FormActivate(Sender: TObject);
begin

end;

end.

