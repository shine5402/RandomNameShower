unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, EditBtn, ComCtrls,unit1;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    FileNameEdit1: TFileNameEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
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
    filenameedit1.Text:=namespath;
    checkbox1.Checked:=savefontsetting;
    checkbox2.Checked:=saveanimatesetting;
    checkbox3.Checked:=savewindowsize;
    checkbox4.checked:=whetherhash;
    checkbox5.checked:=encrypthash;
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

procedure TForm2.CheckBox4Change(Sender: TObject);
begin

end;

end.

