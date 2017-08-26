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
loadingform.label1.caption:='加载上一次的设置……';
rootenabled:=false;
names:=Tstringlist.Create;
settingspath:='./settings.ini';
settings:=Tinifile.create(settingspath);
namespath:=settings.readstring('paths','namespath','./names.txt');
if not(fileexists(namespath)) then begin
showmessage('找不到名单文件，程序无法运作，即将退出。');
application.Terminate;
end;
passwordmd5:=settings.readstring('password','md5','25d55ad283aa400af464c76d713c07ad');
names.LoadFromFile(namespath);
savefontsetting:=settings.ReadBool('font','whethersave',true);
saveanimatesetting:=settings.ReadBool('animate','whethersave',true);
savewindowsize:=settings.ReadBool('window','whethersave',false);
whetherhash:=settings.readbool('hash','whetherhash',false);
encrypthash:=settings.readbool('hash','encrypthash',false);

progressbar1.position:=20;
loadingform.label1.caption:='应用设置……';

if saveanimatesetting then begin
animate:=settings.ReadBool('animate','switch',false);
{animateduration:=settings.ReadInteger('advanced','animte.animteduration',2000);
rollnumbermin:=settings.ReadInteger('advanced','animate.rollnumbermin',20);
animateintervalmin:=settings.ReadInteger('advanced','animate.animateintervalmin',1);  }
rollnumber:=settings.readinteger('animate','rollnumber',30);
animateinterval:=settings.readinteger('animate','animateinterval',50);
end;
if savefontsetting then begin
form1.fontdialog1.Font.Size:=settings.ReadInteger('font','size',18);
form1.fontdialog1.Font.color:=settings.readinteger('font','color',clDefault);
form1.fontdialog1.Font.name:=settings.Readstring('font','fontname','微软雅黑');
form1.label1.Font:=form1.fontdialog1.Font;
end;
progressbar1.position:=40;
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
  //showmessage(chr(j));
  //showmessage(nameshash);
  nameslasthash:=nameslasthash+chr(j);
  //showmessage(nameslasthash);
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
if passwordmd5='25d55ad283aa400af464c76d713c07ad' then showmessage('您的管理员密码目前为初始密码。请进入选项进行修改。');
progressbar1.position:=60;
loadingform.label1.caption:='应用设置……';

form1.MenuItem5.Checked:=animate;
{rollnumber:=names.count+1;
if rollnumber < rollnumbermin then rollnumber:=rollnumbermin;
if animateduration div rollnumber <> 0 then form1.Timer1.Interval:=animateduration div rollnumber else form1.Timer1.Interval:=animateintervalmin;}
  i:=names.count;
k:=0;
j:=0;
randomize;
progressbar1.position:=80;
loadingform.label1.caption:='加载完成！';
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

