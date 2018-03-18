unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn, ComCtrls, unit1, md5, Types;

type

  { TOptionForm }

  TOptionForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ConfusionSettingsButton: TButton;
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
    procedure ConfusionSettingsButtonClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure EditButton1ButtonClick(Sender: TObject);
    procedure EditButton1Change(Sender: TObject);
    procedure EditButton1Enter(Sender: TObject);
    procedure EditButton1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FileNameEdit1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure TabSheet4ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);
    procedure TabSheet5ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: boolean);

  private
{ private declarations }
    procedure CheckPassword();
    procedure TabSheet3SettingCheck();
  public
    { public declarations }
  end;

var
  OptionForm: TOptionForm;
  rootenabled: boolean;
  passwordmd5: string;

implementation

{$R *.lfm}

{ TOptionForm }
uses unit4,unit8;

procedure TOptionForm.FormCreate(Sender: TObject);
begin
end;

procedure TOptionForm.FormShow(Sender: TObject);
begin
  filenameedit1.Text := namespath;
  checkbox1.Checked := savefontsetting;
  checkbox2.Checked := saveanimatesetting;
  checkbox3.Checked := savewindowsize;
  checkbox4.Checked := whetherhash;
  checkbox5.Checked := encrypthash;
  TabSheet3SettingCheck();
  tabsheet3.tabvisible := rootenabled;
  Tabsheet4.TabVisible:= not(rootenabled);
  edit1.Text := IntToStr(rollnumber);
  edit2.Text := IntToStr(animateinterval);
  Label7.Caption := '动画总时长将为 ' + IntToStr(rollnumber * animateinterval) + ' 毫秒';
  if not (MainForm.menuitem5.Checked) then   begin
    tabsheet5.Hide();
    tabsheet5.TabVisible:=false;
  end
  else begin
    tabsheet5.Show();
     tabsheet5.TabVisible:=true;
  end;      PageControl1.ActivePage := TabSheet1;
end;

procedure TOptionForm.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin

end;

procedure TOptionForm.TabSheet3ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin

end;

procedure TOptionForm.TabSheet4ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin

end;

procedure TOptionForm.TabSheet5ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: boolean);
begin

end;

procedure TOptionForm.Button1Click(Sender: TObject);
begin
   namespath := filenameedit1.Text;
    if not (fileexists(namespath)) then
    begin
      ShowMessage('找不到您所指定的名单文件。还请检查是否输入错误。');
      exit;
    end;
    savefontsetting := checkbox1.Checked;
    saveanimatesetting := checkbox2.Checked;
    savewindowsize := checkbox3.Checked;
    whetherhash := checkbox4.Checked;
    encrypthash := checkbox5.Checked;
    names.LoadFromFile(namespath);
    i := names.Count;
    rollnumber := StrToInt(edit1.Text);
    animateinterval := StrToInt(edit2.Text);
    OptionForm.Close;
end;

procedure TOptionForm.Button2Click(Sender: TObject);
begin
  PasswordModifyForm := TPasswordModifyForm.Create(Application);//动态创建窗体
  try
    PasswordModifyForm.ShowModal;//显示模式窗体
  finally
    PasswordModifyForm.Free; //释放窗体实例
    //ShowMessage(BoolToStr(ModalForm = nil));
    PasswordModifyForm := nil; //把窗体变量设为nil
    //ShowMessage(BoolToStr(ModalForm = nil));
  end;
end;

procedure TOptionForm.Button3Click(Sender: TObject);
begin
  editbutton1.Text := '';
  tabsheet3.Hide();
  tabsheet4.Show();
  pagecontrol1.ActivePage := tabsheet4;
end;
procedure TOptionForm.TabSheet3SettingCheck();
begin
  if not (checkbox4.Checked) then
    checkbox5.Enabled := False
  else
    checkbox5.Enabled := True;
  if checkbox4.Checked then
    label1.Enabled := True
  else
    label1.Enabled := False;
  if (checkbox5.Checked and checkbox5.Enabled) then begin
    label3.Enabled := True;
    ConfusionSettingsButton.Enabled := True;
  end
  else  begin
    label3.Enabled := False; ConfusionSettingsButton.Enabled := False;
  end;
end;

procedure TOptionForm.CheckBox4Change(Sender: TObject);
begin
  TabSheet3SettingCheck();
end;

procedure TOptionForm.CheckBox5Change(Sender: TObject);
begin
 TabSheet3SettingCheck();
end;

procedure TOptionForm.ConfusionSettingsButtonClick(Sender: TObject);
begin
  ConfusionSettingsForm := TConfusionSettingsForm.Create(Application);//动态创建窗体
  try
    ConfusionSettingsForm.ShowModal;//显示模式窗体
  finally
    ConfusionSettingsForm.Free; //释放窗体实例
    //ShowMessage(BoolToStr(ModalForm = nil));
    ConfusionSettingsForm := nil; //把窗体变量设为nil
    //ShowMessage(BoolToStr(ModalForm = nil));
  end;
 // ConfusionSettingsForm.Show();
end;

procedure TOptionForm.Edit1Change(Sender: TObject);
begin
  if (edit1.Text <> '') and (edit2.Text <> '') then
    Label7.Caption := '动画总时长将为 ' + IntToStr(StrToInt(edit1.Text) *
      StrToInt(edit2.Text)) + ' 毫秒';
end;

procedure TOptionForm.Edit2Change(Sender: TObject);
begin
  if (edit1.Text <> '') and (edit2.Text <> '') then
    Label7.Caption := '动画总时长将为 ' + IntToStr(StrToInt(edit1.Text) *
      StrToInt(edit2.Text)) + ' 毫秒';
end;

procedure TOptionForm.EditButton1ButtonClick(Sender: TObject);
begin
   CheckPassword;
end;
procedure TOptionForm.CheckPassword();
begin
    label5.Caption := '';
  if MD5Print(MD5String(EditButton1.Text)) = passwordmd5 then
  begin
    rootenabled := true;
    Tabsheet3.Show();
    Tabsheet3.TabVisible:=true;

    tabsheet4.Hide();
    Tabsheet4.TabVisible:=false;
    PageControl1.ActivePage := Tabsheet3;
  end
  else
    label5.Caption := '密码错误，请重试。';
end;

procedure TOptionForm.EditButton1Change(Sender: TObject);
begin

end;

procedure TOptionForm.EditButton1Enter(Sender: TObject);
begin

end;

procedure TOptionForm.EditButton1KeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin

  if key = 13 then
  begin
    CheckPassword;
  end;
end;

procedure TOptionForm.FileNameEdit1Change(Sender: TObject);
begin

end;

procedure TOptionForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  rootenabled := false;
  EditButton1.Text:='';
end;

end.
