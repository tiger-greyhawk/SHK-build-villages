program Shold;

uses
  Forms,
  base in 'base.pas' {Form1},
  ShowMessage in 'ShowMessage.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
