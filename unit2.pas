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
    EditButton1: TEditButton;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure EditButton1Enter(Sender: TObject);
    procedure EditButton1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  rootenabled:boolean;
  passwordmd5:string;
implementation

{$R *.lfm}

{ TForm2 }
 uses unit4;
procedure TForm2.FormCreate(Sender: TObject);
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
end;

procedure TForm2.TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm2.Button1Click(Sender: TObject);
begin
    namespath:=filenameedit1.Text;
    savefontsetting:=checkbox1.Checked;
    saveanimatesetting:=checkbox2.Checked;
    savewindowsize:=checkbox3.Checked;
    whetherhash:=checkbox4.checked;
    encrypthash:=checkbox5.checked;
    names.LoadFromFile(namespath);
    i:=names.count;
    form2.close;
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

procedure TForm2.EditButton1ButtonClick(Sender: TObject);
begin
    if MD5Print(MD5String(EditButton1.Text))=passwordmd5 then begin
      Tabsheet3.TabVisible:=true;
      pagecontrol1.ActivePage:=tabsheet3;
      tabsheet4.TabVisible:=false;
    end else showmessage('密码错误，请重试。');
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

end;

end.

