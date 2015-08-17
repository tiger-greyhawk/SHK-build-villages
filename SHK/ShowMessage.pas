unit ShowMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses base;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  SetWindowPos(Handle, HWND_NOTOPMOST, Form2.Left, Form2.Top, Form2.Width, Form2.Height, SWP_SHOWWINDOW);  
  Form2.Close;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
//  SetForegroundWindow(Handle);
//  Form2.Edit1.Text:=('In village '+TTabSheet(Form1.FindComponent('TabSheet'+IntToStr((TButton(Sender)).Tag))).Caption+' finished constructions');
//  ShowWindow(Handle, SW_SHOWNORMAL );
  SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
  SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
//  SetWindowPos(Handle, HWND_TOPMOST, Form2.Left, Form2.Top, Form2.Width, Form2.Height, SWP_SHOWWINDOW);
//  SetWindowPos(Handle, HWND_NOTOPMOST, Form2.Left, Form2.Top, Form2.Width, Form2.Height, SWP_SHOWWINDOW);
  //  Form2.FormStyle:=fsStayOnTop;
end;

end.
