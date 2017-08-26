unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn, ComCtrls,unit1,md5, Types;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    EditButton1: TEditButton;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure EditButton1Enter(Sender: TObject);
    procedure EditButton1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet4ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TabSheet5ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  rootenabled,ifenter:boolean;
  passwordmd5:string;
implementation

{$R *.lfm}

{ TForm2 }
 uses unit4;
procedure TForm2.FormCreate(Sender: TObject);
begin
end;

procedure TForm2.FormShow(Sender: TObject);
begin
        filenameedit1.Text:=namespath;
    checkbox1.Checked:=savefontsetting;
    checkbox2.Checked:=saveanimatesetting;
    checkbox3.Checked:=savewindowsize;
    checkbox4.checked:=whetherhash;
    checkbox5.checked:=encrypthash;
      if not(checkbox4.Checked) then checkbox5.enabled:=false else checkbox5.enabled:=true;
    if checkbox4.checked then label1.Enabled:=true else label1.Enabled:=false;
    if (checkbox5.checked and checkbox5.enabled) then label3.Enabled:=true else label3.Enabled:=false;
    tabsheet3.tabvisible:=rootenabled;
    edit1.text:=inttostr(rollnumber);
    edit2.text:=inttostr(animateinterval);
    Label7.Caption:='动画总时长将为 '+inttostr(rollnumber*animateinterval)+' 毫秒';
    if not(form1.menuitem5.checked) then tabsheet5.TabVisible:=false;
end;

procedure TForm2.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm2.TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm2.TabSheet4ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm2.TabSheet5ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
    if not(ifenter) then begin
    namespath:=filenameedit1.Text;
    if not(fileexists(namespath)) then begin
    showmessage('找不到您所指定的名单文件。还请检查是否输入错误。');
    exit;
    end;
    savefontsetting:=checkbox1.Checked;
    saveanimatesetting:=checkbox2.Checked;
    savewindowsize:=checkbox3.Checked;
    whetherhash:=checkbox4.checked;
    encrypthash:=checkbox5.checked;
    names.LoadFromFile(namespath);
    i:=names.count;
    rollnumber:=strtoint(edit1.Text);
    animateinterval:=strtoint(edit2.Text);
    form2.close;
    end else ifenter:=false;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  form3.show;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  editbutton1.Text:='';
  tabsheet3.TabVisible:=false;
  tabsheet4.TabVisible:=true;
  pagecontrol1.ActivePage:=tabsheet4;
end;

procedure TForm2.CheckBox4Change(Sender: TObject);
begin
  if not(checkbox4.Checked) then checkbox5.enabled:=false else checkbox5.enabled:=true;
    if checkbox4.checked then label1.Enabled:=true else label1.Enabled:=false;
    if (checkbox5.checked and checkbox5.enabled) then label3.Enabled:=true else label3.Enabled:=false ;
end;

procedure TForm2.CheckBox5Change(Sender: TObject);
begin
      if not(checkbox4.Checked) then checkbox5.enabled:=false else checkbox5.enabled:=true;
    if checkbox4.checked then label1.Enabled:=true else label1.Enabled:=false;
    if (checkbox5.checked and checkbox5.enabled) then label3.Enabled:=true else label3.Enabled:=false
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
if (edit1.text<>'') and (edit2.text<>'') then Label7.Caption:='动画总时长将为 '+inttostr(strtoint(edit1.text)*strtoint(edit2.text))+' 毫秒';
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
if (edit1.text<>'') and (edit2.text<>'') then Label7.Caption:='动画总时长将为 '+inttostr(strtoint(edit1.text)*strtoint(edit2.text))+' 毫秒';
end;

procedure TForm2.EditButton1ButtonClick(Sender: TObject);
begin
    if MD5Print(MD5String(EditButton1.Text))=passwordmd5 then begin
      Tabsheet3.TabVisible:=true;
      pagecontrol1.ActivePage:=tabsheet3;
      tabsheet4.TabVisible:=false;
    end else label5.caption:='密码错误，请重试。';
end;

procedure TForm2.EditButton1Change(Sender: TObject);
begin

end;

procedure TForm2.EditButton1Enter(Sender: TObject);
begin

end;

procedure TForm2.EditButton1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

    if key=13 then begin
      ifenter:=true;
      EditButton1ButtonClick(application);
    end;
end;

end.

