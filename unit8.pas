unit Unit8;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TConfusionSettingsForm }

  TConfusionSettingsForm = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  ConfusionSettingsForm: TConfusionSettingsForm;

implementation
 uses unit1;
{$R *.lfm}

 { TConfusionSettingsForm }

 procedure TConfusionSettingsForm.FormCreate(Sender: TObject);
 begin

 end;

procedure TConfusionSettingsForm.Button1Click(Sender: TObject);
begin
   encryptkey := strtoint(Edit1.Text);
   ConfusionSettingsForm.Close;
end;

procedure TConfusionSettingsForm.FormShow(Sender: TObject);
begin
  Edit1.Text := inttostr(encryptkey);
end;

end.

