unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
   Menus, ExtCtrls,unit3,IniFiles,md5;

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
  end;

var
  Form1: TForm1;
  names:Tstringlist;
  namespath,settingspath,nameshash,s,nameslasthash:string;
  rollnumber,k,i,j,animateduration,animatetimes,animateintervalmin,rollnumbermin,encryptkey,hashencryptlength:integer;
  animate,savefontsetting,saveanimatesetting,savewindowsize,whetherhash,encrypthash:boolean;
  settings:tinifile;
implementation
uses unit2;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  names:=Tstringlist.Create;
  settingspath:='./settings.ini';
  settings:=Tinifile.create(settingspath);
  namespath:=settings.readstring('paths','namespath','./names.txt');
  names.LoadFromFile(namespath);
  savefontsetting:=settings.ReadBool('fonts','whethersave',true);
  saveanimatesetting:=settings.ReadBool('animate','whethersave',true);
  savewindowsize:=settings.ReadBool('window','whethersave',false);
  whetherhash:=settings.readbool('hash','whetherhash',false);
  encrypthash:=settings.readbool('hash','encrypthash',false);
  encryptkey:=settings.readinteger('hash','encryptkey',1234);
  hashencryptlength:=settings.readinteger('hash','hashencryptlength',0);
  if saveanimatesetting then begin
  animate:=settings.ReadBool('animate','switch',false);
  animateduration:=settings.ReadInteger('advanced','animte.animteduration',2000);
  rollnumbermin:=settings.ReadInteger('advanced','animate.rollnumbermin',20);
  animateintervalmin:=settings.ReadInteger('advanced','animate.animateintervalmin',1);
  end;
  if savefontsetting then begin
  fontdialog1.Font.Size:=settings.ReadInteger('font','size',18);
  fontdialog1.Font.color:=settings.readinteger('font','color',clDefault);
  fontdialog1.Font.name:=settings.Readstring('font','fontname','微软雅黑');
  label1.Font:=fontdialog1.Font;
  end;
  if encrypthash then begin
  nameshash:=MD5Print(MD5File(namespath));
  nameslasthash:='';
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

  MenuItem5.Checked:=animate;
  rollnumber:=names.count+1;
  if rollnumber < rollnumbermin then rollnumber:=rollnumbermin;
  if animateduration div rollnumber <> 0 then Timer1.Interval:=animateduration div rollnumber else Timer1.Interval:=animateintervalmin;
    i:=names.count;
  k:=0;
  j:=0;
  randomize;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
   names.destroy;
   settings.Destroy;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if savewindowsize then begin
  Form1.SetBounds(settings.ReadInteger('window','left',169),settings.ReadInteger('window','top',491),settings.ReadInteger('window','width',339),settings.ReadInteger('window','height',274));

  Form1.WindowState:=TWindowState(settings.ReadInteger('window','WindowState',Integer(wsNormal)));
  end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if fontdialog1.Execute then label1.Font:=fontdialog1.Font;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
    aboutform.show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  animate:=not animate;
  MenuItem5.checked:=animate;
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
  Label1.Caption:='';
end;

procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
  k:=0
end;

procedure TForm1.Timer1StopTimer(Sender: TObject);
begin
  k:=0
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

  j:=random(i);
  Label1.Caption:=names.Strings[j];
  application.ProcessMessages;
  k:=k+1;
  if k>rollnumber then timer1.Enabled:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     {i:=names.count;
  j:=random(i);
  Label1.Caption:=names.Strings[j];
  }
  if animate then timer1.Enabled:=true else begin
  j:=random(i);
  Label1.Caption:=names.Strings[j];
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if savewindowsize then begin
  settings.WriteInteger('window','top',Form1.top);
  settings.WriteInteger('window','left',Form1.left);
  settings.WriteInteger('window','width',Form1.Width);
  settings.WriteInteger('window','height',Form1.Height);
  settings.WriteInteger('window','WindowState',Integer(Form1.WindowState));
  end;

  settings.WriteString('paths','namespath',namespath);
  settings.WriteBool('fonts','whethersave',savefontsetting);
  settings.WriteBool('animate','whethersave',saveanimatesetting);
  settings.WriteBool('window','whethersave',savewindowsize);
  settings.WriteBool('hash','whetherhash',whetherhash);
  settings.WriteBool('hash','encrypthash',encrypthash);
  if savefontsetting then begin
  settings.writeinteger('font','size',fontdialog1.Font.Size);
  settings.writeinteger('font','color',fontdialog1.Font.color);
  settings.writestring('font','fontname',fontdialog1.Font.name);
  end;
  if saveanimatesetting then begin
  settings.WriteBool('animate','switch',animate);
  settings.WriteInteger('advanced','animte.animteduration',animateduration);
  settings.WriteInteger('advanced','animate.rollnumbermin',rollnumbermin);
  settings.WriteInteger('advanced','animate.animateintervalmin',animateintervalmin);
  end;
  if (whetherhash xor encrypthash) and whetherhash then begin
  settings.WriteString('hash','namesmd5',nameshash);
  end;
  if encrypthash then begin
  settings.writeinteger('hash','encryptkey',encryptkey);
  hashencryptlength:=0;
  nameshash:=MD5Print(MD5File(namespath));
  for i:= 1 to length(nameshash) do begin
    str(i,s);
    s:='e'+s;
    //showmessage(s);
    settings.writeinteger('hash',s,ord(nameshash[i]) xor encryptkey) ;
    hashencryptlength:=hashencryptlength+1;
  end;
  settings.writeinteger('hash','hashencryptlength',hashencryptlength);
  end;

end;



end.

