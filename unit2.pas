unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn,unit1;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DirectoryEdit1: TDirectoryEdit;
    Label2: TLabel;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
    directoryedit1.Text:=namespath;
    checkbox1.Checked:=savefontsetting;
    checkbox2.Checked:=saveanimatesetting;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
    namespath:=directoryedit1.Text;
    savefontsetting:=checkbox1.Checked;
    saveanimatesetting:=checkbox2.Checked;
    names.LoadFromFile(namespath);
    form2.close;
end;

end.

