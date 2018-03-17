unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TFirstRunForm }

  TFirstRunForm = class(TForm)
    BackButton: TButton;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    NextButton: TButton;
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    procedure BackButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NextButtonClick(Sender: TObject);
  private
    { private declarations }
    procedure UpdateForm();
  public
    { public declarations }
  end;

var
  FirstRunForm: TFirstRunForm;
  step: integer;
  finish: boolean;

implementation

uses Unit4, Unit1,Unit2,Unit5;

{$R *.lfm}

{ TFirstRunForm }
procedure TFirstRunForm.UpdateForm();
begin
  if step = 1 then
  begin
    BackButton.Enabled := False;
    Label2.Caption := '步骤 1 / 4 - 欢迎！';
    Label1.Show();
  end
  else
  begin
    BackButton.Enabled := True;
    Label1.Hide();
  end;
  if step = 2 then
  begin
    Label2.Caption := '步骤 2 / 4 - 加载名单文件';
    Label3.Show();
    Memo1.Show();
    Label4.Show();
  end
  else
  begin
    Label3.hide();
    Memo1.Hide();
    Label4.Hide();
  end;
  if step = 3 then
  begin
    Label2.Caption := '步骤 3 / 4 - 设置管理员密码';
    Label3.Caption :=
      '本程序带有防暗箱功能，即防止在公用电脑上（如多媒体教室主机）其他人为更改概率而恶意篡改名单文件。该功能需要您设置管理员密码。' + #13 + '我们为您设置的默认密码是12345678。为了安全性，请您单击以下按钮修改密码。';
    Label3.Show();
    Button1.Show();
  end
  else
  begin
    Label3.Hide();
    Button1.Hide();
  end;
  if step = 4 then
  begin
    NextButton.Caption := '完成';
    Label2.Caption := '步骤 4 / 4 - 完成！';
    Label1.Caption :=
      '至此，配置本程序所必须的任务就完成了。程序已经可以使用了。'
      +
      #13 + '不过，我们强烈建议您在进入程序之后查看设置，并进行您自己的个性化修改。'
      + #13 + '还需要提的是，本程序所使用的许可协议是GNU GPL V3。您可以在关于中查看其详情。' + #13 + '祝您有个愉快的使用体验！';
    Label1.Show;
  end
  else
  begin
    NextButton.Caption := '下一步';
    if step <> 1 then
      Label1.Hide();
  end;
end;

procedure TFirstRunForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if not (finish) then
    application.Terminate
  else
  begin
LoadingForm.Show();
LoadingForm.firstrunformdone();
  end;
end;

procedure TFirstRunForm.FormCreate(Sender: TObject);
begin

end;

procedure TFirstRunForm.BackButtonClick(Sender: TObject);
begin
  step := step - 1;
  UpdateForm();
end;

procedure TFirstRunForm.Button1Click(Sender: TObject);
begin
  Form3.passwdmd5('25d55ad283aa400af464c76d713c07ad');
  Form3.Show();
end;

procedure TFirstRunForm.Button2Click(Sender: TObject);
begin
  ShowMessage(IntToStr(step) + ' ' + booltostr(Label1.Visible));
end;

procedure TFirstRunForm.FormShow(Sender: TObject);
begin
  step := 1;
  Memo1.Lines.LoadFromFile('./names.txt');
  UpdateForm();
end;

procedure TFirstRunForm.NextButtonClick(Sender: TObject);
begin
  if step < 4 then
  begin
    step := step + 1;
    UpdateForm();
  end
  else
  begin
    Memo1.Lines.SaveToFile('./names.txt');

finish := true;
    FirstRunForm.Close;

  end;
end;

end.
